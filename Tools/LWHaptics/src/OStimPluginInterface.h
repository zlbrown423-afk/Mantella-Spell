#pragma once
// Minimal copy of OStim Standalone's plugin interface (OStimNG 7.5.1b, skse/src/PluginInterface, GPL-3.0,
// https://github.com/VersuchDrei/OStimNG). Only the classes this plugin touches. The order of the virtual
// functions IS the ABI: do not reorder, and build with an MSVC-ABI compiler (clang --target=*-windows-msvc
// or cl.exe), because OStim.dll is built with MSVC.
#include <stdint.h>

namespace OStim {
    struct InterfaceExchangeMessage {
        enum : uint32_t { MESSAGE_TYPE = 'OST' };
        class InterfaceMap* interfaceMap = nullptr;
    };

    class PluginInterface {
    public:
        virtual ~PluginInterface() {}
        virtual uint32_t getVersion() = 0;
    };

    class InterfaceMap {
    public:
        virtual PluginInterface* queryInterface(const char* name) = 0;
        virtual bool addInterface(const char* name, PluginInterface* pluginInterface) = 0;
        virtual PluginInterface* removeInterface(const char* name) = 0;
    };

    // ---- sex toys ("SexToys") ----
    class SexToy {
    public:
        virtual const char* getID() = 0;
        virtual const char* getName() = 0;
        virtual uint16_t getUpdateInterval() = 0;
        virtual void turnOn() = 0;
        virtual void turnOff() = 0;
        // sent on every animation peak (thrust); peakInterval is -1 when the update is not a peak
        virtual void update(float baseline, float peak, int16_t peakInterval) = 0;
        // climax and other one-off events
        virtual void peak(float magnitude, float duration) = 0;
        virtual void stop() = 0;
    };

    class SexToyReloadListener {
    public:
        virtual void reloadToys() = 0;
    };

    class SexToyInterface : public PluginInterface {
    public:
        virtual void registerReloadListener(SexToyReloadListener* listener) = 0;
        virtual void addToy(SexToy* toy) = 0;
    };

    // ---- graph (only what we call) ----
    class NodeActor {
    public:
        virtual bool hasTag(const char* tag) = 0;
        virtual uint32_t getTagCount() = 0;
        virtual void* getTag(uint32_t index) = 0;
        virtual void forEachTag(void* visitor) = 0;
    };

    class Node {
    public:
        virtual const char* getNodeID() = 0;
        virtual uint32_t getActorCount() = 0;
        virtual NodeActor* getActor(uint32_t index) = 0;
        virtual void forEachActor(void* visitor) = 0;
        virtual bool hasTag(const char* tag) = 0;
        virtual uint32_t getTagCount() = 0;
        virtual void* getTag(uint32_t index) = 0;
        virtual void forEachTag(void* visitor) = 0;
        virtual bool hasAction(const char* action) = 0;
        // (more follow in OStim; never called here)
    };

    // ---- threads ("Threads") ----
    class Thread {
    public:
        virtual int32_t getThreadID() = 0;
        virtual bool isPlayerThread() = 0;
        virtual uint32_t getActorCount() = 0;
        virtual void* getActor(uint32_t position) = 0;
        virtual void forEachThreadActor(void* visitor) = 0;
        virtual Node* getCurrentNode() = 0;
    };

    class ThreadEventListener {
    public:
        virtual void listen(Thread* thread) = 0;
    };

    class ThreadInterface : public PluginInterface {
    public:
        virtual Thread* getThread(int32_t threadID) = 0;
        virtual void registerThreadStartListener(ThreadEventListener* listener) = 0;
        virtual void registerSpeedChangedListener(ThreadEventListener* listener) = 0;
        virtual void registerNodeChangedListener(ThreadEventListener* listener) = 0;
        virtual void registerClimaxListener(void* listener) = 0;
        virtual void registerThreadStopListener(ThreadEventListener* listener) = 0;
    };
}
