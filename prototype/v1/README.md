# v1 — Flutter web experiment

Independent hello-world app for browser-based Flutter iteration. `v0` is unchanged.

## Local preview

From the repository root:

```bash
cd prototype/v1
flutter pub get
flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8181
```

Open http://localhost:8181. On this workstation, the SDK is at `/home/abuhafi/flutter/bin/flutter` if `flutter` is not on `PATH`.

Debug mode enables `device_preview`, initially using an iPhone 13 frame. Its toolbar can change device, orientation and accessibility settings. Device preview simulates layout; it does not emulate native plugins or an actual mobile OS.

The web-server target supports hot restart with `r` in the running terminal. For browser debugging, use `flutter run -d chrome` when Chrome is installed.

The server binds to all interfaces for local network preview; it is not a public deployment. Release mode disables the device-preview wrapper.
