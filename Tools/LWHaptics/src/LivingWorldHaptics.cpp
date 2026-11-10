// LivingWorldHaptics: VR controller "impact" pulses timed to OStim's own thrust peaks.
//
// How it works
//   OStim Standalone detects every thrust itself (bone distance between the two partners, the same signal that
//   plays its slap sound) and hands those "peaks" to any registered sex toy through its plugin interface.
//   This plugin registers one virtual toy. On each peak it fires a short, decaying rumble on the Touch
//   controllers through OpenVR, so the pulse lands on the beat at every speed with no guessing.
//   Rear-entry filter: it listens to OStim's node-changed events and only arms itself while the player's
//   scene is tagged "doggystyle", or has vaginal/anal sex with a partner tagged "facingaway"/"allfours".
//
// Nothing here runs in Papyrus, so it cannot add Papyrus load (the cause of the earlier 30 s freezes).
// Toy callbacks come from OStim's own worker threads; the rumble runs on one thread of ours.
//
// Freestanding build (no CRT, no Windows SDK needed): see ../build.sh. MSVC ABI is required.

#include <stdint.h>
#include <stddef.h>

#include "OStimPluginInterface.h"
#include "openvr.h"

// ------------------------------------------------------------------------------------------------
// Win32 (declared by hand so no Windows SDK is needed)
extern "C" {
__declspec(dllimport) void* __stdcall GetModuleHandleA(const char*);
__declspec(dllimport) void* __stdcall GetProcAddress(void*, const char*);
__declspec(dllimport) unsigned long __stdcall GetModuleFileNameA(void*, char*, unsigned long);
__declspec(dllimport) void* __stdcall CreateEventA(void*, int, int, const char*);
__declspec(dllimport) int __stdcall SetEvent(void*);
__declspec(dllimport) unsigned long __stdcall WaitForSingleObject(void*, unsigned long);
__declspec(dllimport) void* __stdcall CreateThread(void*, size_t, unsigned long(__stdcall*)(void*), void*, unsigned long, unsigned long*);
__declspec(dllimport) void __stdcall Sleep(unsigned long);
__declspec(dllimport) unsigned int __stdcall GetPrivateProfileIntA(const char*, const char*, int, const char*);
__declspec(dllimport) void* __stdcall CreateFileA(const char*, unsigned long, unsigned long, void*, unsigned long, unsigned long, void*);
__declspec(dllimport) int __stdcall WriteFile(void*, const void*, unsigned long, unsigned long*, void*);
__declspec(dllimport) int __stdcall CloseHandle(void*);

// Things the compiler may reference when there is no CRT.
int _fltused = 0;
int __cdecl _purecall() { return 0; }
void* __cdecl memset(void* d, int c, size_t n) {
    unsigned char* p = (unsigned char*)d;
    while (n--) *p++ = (unsigned char)c;
    return d;
}
void* __cdecl memcpy(void* d, const void* s, size_t n) {
    unsigned char* p = (unsigned char*)d;
    const unsigned char* q = (const unsigned char*)s;
    while (n--) *p++ = *q++;
    return d;
}
}

// ------------------------------------------------------------------------------------------------
// SKSE (old-style VR plugin API; layouts from SKSE/CommonLibVR Stubs.h)
namespace skse {
    using PluginHandle = uint32_t;
    struct PluginInfo {
        uint32_t infoVersion;
        const char* name;
        uint32_t version;
    };
    struct Interface {
        uint32_t skseVersion;
        uint32_t runtimeVersion;
        uint32_t editorVersion;
        uint32_t isEditor;
        void* (*QueryInterface)(uint32_t);
        PluginHandle (*GetPluginHandle)();
        uint32_t (*GetReleaseIndex)();
    };
    struct Message {
        const char* sender;
        uint32_t type;
        uint32_t dataLen;
        void* data;
    };
    using EventCallback = void (*)(Message*);
    struct MessagingInterface {
        uint32_t interfaceVersion;
        bool (*RegisterListener)(PluginHandle, const char*, EventCallback);
        bool (*Dispatch)(PluginHandle, uint32_t, void*, uint32_t, const char*);
        void* (*GetEventDispatcher)(uint32_t);
    };
    enum : uint32_t { kInterface_Messaging = 5 };
    enum : uint32_t { kPostLoad = 0, kPostPostLoad = 1, kPostLoadGame = 3, kNewGame = 7, kDataLoaded = 8 };
}

// ------------------------------------------------------------------------------------------------
// small helpers
namespace {
    void* g_module = nullptr;
    char g_iniPath[300];
    char g_logPath[300];
    skse::PluginHandle g_handle = 0;
    skse::MessagingInterface* g_messaging = nullptr;


    void Log(const char* a, const char* b = nullptr, int number = -99999) {
        if (!g_logPath[0]) return;
        // FILE_APPEND_DATA, FILE_SHARE_READ|WRITE, OPEN_ALWAYS
        void* f = CreateFileA(g_logPath, 4, 3, nullptr, 4, 0x80, nullptr);
        if (f == (void*)(intptr_t)-1) return;
        char buf[256];
        size_t n = 0;
        const char* parts[2] = {a, b};
        for (int k = 0; k < 2; k++) {
            const char* s = parts[k];
            if (!s) continue;
            for (size_t i = 0; s[i] && n < 200; i++) buf[n++] = s[i];
        }
        if (number != -99999) {
            buf[n++] = ' ';
            int v = number;
            if (v < 0) { buf[n++] = '-'; v = -v; }
            char digits[12];
            int d = 0;
            do { digits[d++] = (char)('0' + v % 10); v /= 10; } while (v && d < 11);
            while (d) buf[n++] = digits[--d];
        }
        buf[n++] = '\r';
        buf[n++] = '\n';
        unsigned long written = 0;
        WriteFile(f, buf, (unsigned long)n, &written, nullptr);
        CloseHandle(f);
    }

    void StartLog() {
        // CREATE_ALWAYS: a fresh log each game start
        void* f = CreateFileA(g_logPath, 0x40000000, 3, nullptr, 2, 0x80, nullptr);
        if (f != (void*)(intptr_t)-1) CloseHandle(f);
    }

    // ------------------------------------------------------------------------------------------
    // settings (LivingWorldHaptics.ini next to the dll; re-read at every scene start)
    struct Settings {
        int enabled = 1;
        int strength = 80;      // percent, 0-100
        int pulseMs = 70;       // length of one impact
        int hands = 0;          // 0 both, 1 right, 2 left
        int rearOnly = 1;       // only doggystyle / from-behind scenes
        int climax = 1;         // long rumble when OStim reports a climax
        int climaxMs = 700;
        int testOnLoad = 0;     // one long buzz after a save loads, to check the hardware path
    };
    Settings g_settings;

    int Clamp(int v, int lo, int hi) { return v < lo ? lo : (v > hi ? hi : v); }

    void LoadSettings() {
        Settings s;
        s.enabled = (int)GetPrivateProfileIntA("Haptics", "bEnabled", 1, g_iniPath);
        s.strength = Clamp((int)GetPrivateProfileIntA("Haptics", "iStrength", 80, g_iniPath), 0, 100);
        s.pulseMs = Clamp((int)GetPrivateProfileIntA("Haptics", "iPulseMs", 70, g_iniPath), 10, 400);
        s.hands = Clamp((int)GetPrivateProfileIntA("Haptics", "iHands", 0, g_iniPath), 0, 2);
        s.rearOnly = (int)GetPrivateProfileIntA("Haptics", "bRearEntryOnly", 1, g_iniPath);
        s.climax = (int)GetPrivateProfileIntA("Haptics", "bClimax", 1, g_iniPath);
        s.climaxMs = Clamp((int)GetPrivateProfileIntA("Haptics", "iClimaxMs", 700, g_iniPath), 50, 3000);
        s.testOnLoad = (int)GetPrivateProfileIntA("Haptics", "bTestPulseOnLoad", 0, g_iniPath);
        g_settings = s;
    }

    // ------------------------------------------------------------------------------------------
    // rumble worker: OStim threads only post a request; this thread talks to OpenVR
    void* g_wake = nullptr;
    volatile long g_requestSeq = 0;
    volatile int g_requestMs = 0;
    volatile int g_requestStrength = 0;  // per mille
    vr::IVRSystem* g_vr = nullptr;

    vr::IVRSystem* VR() {
        if (g_vr) return g_vr;
        void* openvr = GetModuleHandleA("openvr_api.dll");
        if (!openvr) return nullptr;
        using GetGeneric = void*(__cdecl*)(const char*, vr::EVRInitError*);
        auto fn = (GetGeneric)GetProcAddress(openvr, "VR_GetGenericInterface");
        if (!fn) return nullptr;
        vr::EVRInitError err = vr::VRInitError_None;
        g_vr = (vr::IVRSystem*)fn(vr::IVRSystem_Version, &err);
        Log(g_vr ? "OpenVR system found" : "OpenVR system NOT available, error", nullptr, g_vr ? -99999 : (int)err);
        return g_vr;
    }

    void Request(int ms, int perMille) {
        if (perMille <= 0 || ms <= 0) return;
        g_requestMs = ms;
        g_requestStrength = perMille > 1000 ? 1000 : perMille;
        __atomic_add_fetch(&g_requestSeq, 1, __ATOMIC_SEQ_CST);
        if (g_wake) SetEvent(g_wake);
    }

    unsigned long __stdcall Worker(void*) {
        long handled = 0;
        for (;;) {
            WaitForSingleObject(g_wake, 0xFFFFFFFF);
        restart:
            handled = __atomic_load_n(&g_requestSeq, __ATOMIC_SEQ_CST);
            int ms = g_requestMs;
            int strength = g_requestStrength;
            vr::IVRSystem* vrs = VR();
            if (!vrs) continue;
            int hands = g_settings.hands;
            vr::TrackedDeviceIndex_t right = vrs->GetTrackedDeviceIndexForControllerRole(vr::TrackedControllerRole_RightHand);
            vr::TrackedDeviceIndex_t left = vrs->GetTrackedDeviceIndexForControllerRole(vr::TrackedControllerRole_LeftHand);
            // An impact: full strength for the first quarter, then fades to 30 %.
            for (int t = 0; t < ms; t += 5) {
                if (__atomic_load_n(&g_requestSeq, __ATOMIC_SEQ_CST) != handled) goto restart;
                int quarter = ms / 4;
                int env = t < quarter ? 1000 : 1000 - (700 * (t - quarter)) / (ms - quarter > 0 ? ms - quarter : 1);
                int us = (3999 * strength / 1000) * env / 1000;
                if (us > 0) {
                    if (hands != 2 && right != vr::k_unTrackedDeviceIndexInvalid) vrs->TriggerHapticPulse(right, 0, (unsigned short)us);
                    if (hands != 1 && left != vr::k_unTrackedDeviceIndexInvalid) vrs->TriggerHapticPulse(left, 0, (unsigned short)us);
                }
                Sleep(5);
            }
        }
        return 0;
    }

    // ------------------------------------------------------------------------------------------
    // rear-entry detection from OStim's node events
    volatile int g_armed = 0;
    volatile int g_inScene = 0;

    bool IsRearEntry(OStim::Node* node) {
        if (!node) return false;
        if (node->hasTag("doggystyle")) return true;
        if (!node->hasAction("vaginalsex") && !node->hasAction("analsex")) return false;
        uint32_t count = node->getActorCount();
        for (uint32_t i = 0; i < count; i++) {
            OStim::NodeActor* actor = node->getActor(i);
            if (actor && (actor->hasTag("facingaway") || actor->hasTag("allfours"))) return true;
        }
        return false;
    }

    class NodeListener : public OStim::ThreadEventListener {
    public:
        constexpr NodeListener() = default;
        void listen(OStim::Thread* thread) override {
            if (!thread || !thread->isPlayerThread()) return;
            OStim::Node* node = thread->getCurrentNode();
            int armed = IsRearEntry(node) ? 1 : 0;
            if (armed != g_armed) Log(armed ? "rear-entry scene: haptics armed " : "scene changed: haptics idle ", node ? node->getNodeID() : "");
            g_armed = armed;
            g_inScene = 1;
        }
    };

    class StopListener : public OStim::ThreadEventListener {
    public:
        constexpr StopListener() = default;
        void listen(OStim::Thread* thread) override {
            if (!thread || !thread->isPlayerThread()) return;
            g_armed = 0;
            g_inScene = 0;
        }
    };

    bool Active() { return g_settings.enabled && g_inScene && (g_armed || !g_settings.rearOnly); }

    // ------------------------------------------------------------------------------------------
    // the virtual toy
    class ControllerToy : public OStim::SexToy {
    public:
        constexpr ControllerToy() = default;
        const char* getID() override { return "livingworld_vr_controllers"; }
        const char* getName() override { return "VR controllers (Living World)"; }
        uint16_t getUpdateInterval() override { return 0; }  // every peak
        void turnOn() override { LoadSettings(); }
        void turnOff() override {}
        void update(float, float peak, int16_t peakInterval) override {
            if (peakInterval < 0 || !Active()) return;  // only real thrust peaks
            float scale = peak > 0.0f ? peak : 1.0f;     // OStim's toy scaling (MCM) still applies
            Request(g_settings.pulseMs, (int)(g_settings.strength * 10 * scale));
        }
        void peak(float magnitude, float) override {
            if (!g_settings.climax || !Active()) return;
            float scale = magnitude > 0.0f ? magnitude : 1.0f;
            Request(g_settings.climaxMs, (int)(g_settings.strength * 10 * scale));
        }
        void stop() override {}
    };

    class ReloadListener : public OStim::SexToyReloadListener {
    public:
        constexpr ReloadListener() = default;
        void reloadToys() override;
    };

    constinit ControllerToy g_toy;
    constinit ReloadListener g_reload;
    constinit NodeListener g_nodeListener;
    constinit StopListener g_stopListener;
    OStim::SexToyInterface* g_toys = nullptr;
    bool g_hooked = false;

    void ReloadListener::reloadToys() {
        if (g_toys) g_toys->addToy(&g_toy);
    }

    OStim::InterfaceMap* AskOStim(const char* receiver) {
        OStim::InterfaceExchangeMessage msg;
        g_messaging->Dispatch(g_handle, OStim::InterfaceExchangeMessage::MESSAGE_TYPE, &msg, sizeof(msg), receiver);
        return msg.interfaceMap;
    }

    void HookOStim() {
        if (g_hooked || !g_messaging) return;
        OStim::InterfaceMap* map = AskOStim("OStim");
        if (!map) map = AskOStim(nullptr);
        if (!map) {
            Log("OStim did not answer (is OStim.dll loaded?)");
            return;
        }
        g_toys = (OStim::SexToyInterface*)map->queryInterface("SexToys");
        auto* threads = (OStim::ThreadInterface*)map->queryInterface("Threads");
        if (!g_toys || !threads) {
            Log("OStim interfaces missing (SexToys/Threads)");
            return;
        }
        threads->registerThreadStartListener(&g_nodeListener);
        threads->registerNodeChangedListener(&g_nodeListener);
        threads->registerThreadStopListener(&g_stopListener);
        g_toys->registerReloadListener(&g_reload);
        g_toys->addToy(&g_toy);
        g_hooked = true;
        Log("hooked into OStim; toy registered. OStim plugin interface version", nullptr, (int)g_toys->getVersion());
    }

    void OnSkse(skse::Message* msg) {
        if (!msg) return;
        switch (msg->type) {
            case skse::kPostPostLoad:
            case skse::kDataLoaded:
                HookOStim();
                break;
            case skse::kPostLoadGame:
            case skse::kNewGame:
                LoadSettings();
                g_armed = 0;
                g_inScene = 0;
                if (g_settings.testOnLoad) {
                    Log("test pulse");
                    Request(600, g_settings.strength * 10);  // one long buzz; never sleep on the game thread
                }
                break;
        }
    }

    void SetPaths() {
        char path[300];
        unsigned long n = GetModuleFileNameA(g_module, path, 260);
        if (n < 4 || n >= 260) return;
        // ...\LivingWorldHaptics.dll -> .ini / .log
        for (unsigned long i = 0; i <= n; i++) g_iniPath[i] = g_logPath[i] = path[i];
        const char* ini = "ini";
        const char* log = "log";
        for (int i = 0; i < 3; i++) {
            g_iniPath[n - 3 + i] = ini[i];
            g_logPath[n - 3 + i] = log[i];
        }
    }
}

// ------------------------------------------------------------------------------------------------
// exports
extern "C" {
int __stdcall DllMain(void* module, unsigned long reason, void*) {
    if (reason == 1) g_module = module;
    return 1;
}

__declspec(dllexport) bool SKSEPlugin_Query(const skse::Interface* skse, skse::PluginInfo* info) {
    info->infoVersion = 1;
    info->name = "LivingWorldHaptics";
    info->version = 1;
    return skse && !skse->isEditor;
}

__declspec(dllexport) bool SKSEPlugin_Load(const skse::Interface* skse) {
    SetPaths();
    StartLog();
    Log("LivingWorldHaptics 0.1.0 loading");
    LoadSettings();
    g_handle = skse->GetPluginHandle();
    g_messaging = (skse::MessagingInterface*)skse->QueryInterface(skse::kInterface_Messaging);
    if (!g_messaging || !g_messaging->RegisterListener(g_handle, "SKSE", OnSkse)) {
        Log("no SKSE messaging interface");
        return false;
    }
    g_wake = CreateEventA(nullptr, 0, 0, nullptr);  // auto-reset
    CreateThread(nullptr, 0, Worker, nullptr, 0, nullptr);
    return true;
}
}
