#!/usr/bin/env bash
# Builds LivingWorldHaptics.dll with clang + lld, no Windows SDK or CRT needed (Linux, macOS or Windows).
# Output: Dist/LWHaptics-<version>.zip, laid out for Vortex (SKSE/Plugins/...).
set -euo pipefail
cd "$(dirname "$0")"
VERSION=0.1.0
OUT=build
mkdir -p "$OUT" Dist
llvm-dlltool -m i386:x86-64 -d src/kernel32.def -l "$OUT/kernel32.lib"
clang --target=x86_64-pc-windows-msvc -std=c++20 -O2 -ffreestanding -fno-exceptions -fno-rtti \
  -fno-builtin -mno-stack-arg-probe -Wall -Wno-multichar -Wno-unused-private-field \
  -c src/LivingWorldHaptics.cpp -o "$OUT/LivingWorldHaptics.obj"
lld-link /dll /nodefaultlib /entry:DllMain /subsystem:windows /machine:x64 \
  /out:"$OUT/LivingWorldHaptics.dll" "$OUT/LivingWorldHaptics.obj" "$OUT/kernel32.lib"
rm -rf "$OUT/pkg" && mkdir -p "$OUT/pkg/SKSE/Plugins"
cp "$OUT/LivingWorldHaptics.dll" LivingWorldHaptics.ini "$OUT/pkg/SKSE/Plugins/"
(cd "$OUT/pkg" && rm -f "../../Dist/LWHaptics-$VERSION.zip" && zip -qr "../../Dist/LWHaptics-$VERSION.zip" SKSE)
echo "built Dist/LWHaptics-$VERSION.zip"
