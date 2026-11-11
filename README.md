# CloudPad

Turn an Android phone into a game controller for a Windows laptop. Up to 4 phones can play together over Bluetooth or USB tethering. Works with cloud gaming in the browser and with games installed on the laptop (Steam, Epic, and others).

## Contents

- `release/CloudPad-1.3.apk`: Android app, version 1.3.0 (USB tethering support)
- `bridge/CloudPad Bridge.pyw`: Windows app that shows up as an Xbox controller for each phone
- `app/`: Android app source (apktool project: `smali/`, `res/`, `AndroidManifest.xml`, `apktool.yml`)

## Install the phone app

Copy `release/CloudPad-1.3.apk` to the phone and install it. Allow installs from unknown sources if asked. If you get "App not installed", uninstall any older CloudPad first.

## Run the laptop app

1. Double-click `CloudPad Bridge.pyw`. The first run may ask to install the ViGEmBus controller driver. Allow it.
2. Bluetooth: hold the phone near the laptop until it appears as a player.
3. USB: plug the phone in and turn on Settings > Hotspot & tethering > USB tethering.

Keep the phone app open while you play.

## Build notes

The APK is debug-signed. `apktool.yml` sets versionCode 4 and versionName 1.3.0-usb.

## 1.4 — layout picker (release/CloudPad-1.4.apk)

Home screen with five layouts: **Xbox, PS5, Shooter, Racing, Formula 1**.
- Pencil = edit mode: drag, resize (pinch or +/−), hide/show, re-map any control to any of 17 buttons, reset, cancel. Saved per layout.
- Racing and F1 have a TILT / WHEEL switch in the top bar.
- F1: DRS/ERS/OVT/PIT/RADIO keys, BIAS and DIFF dials, shift lights, input graph, speedometer/gear/RPM. Gauges are *estimated* from throttle/brake (labelled EST) until real telemetry is fed to `cp.telemetry({speed,rpm,gear,drs})`.
- PS5 is a cosmetic layout; the PC still sees an Xbox pad.

Source for the new UI is in `app-1.4/` (web UI in `web/pad`, Java view in `java`, `build.sh` builds on top of the 1.3 smali project in `app/`).
