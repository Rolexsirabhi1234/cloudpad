package com.cloudpad.controller;

/** Receives game telemetry from the Bridge (packet type 3) and feeds the on-screen gauges. */
public final class Telemetry {
    static volatile GamepadView view;

    private Telemetry() {}

    /** [3, speed u16, rpm u16, gear i8, drs u8, rev% u8], little-endian. Called from a BLE/USB thread. */
    public static void onPacket(byte[] d) {
        final GamepadView v = view;
        if (v == null || d == null || d.length < 7 || d[0] != 3) return;
        final int speed = (d[1] & 255) | ((d[2] & 255) << 8);
        final int rpm = (d[3] & 255) | ((d[4] & 255) << 8);
        final int gear = d[5];
        final int drs = d[6] & 255;
        v.post(new Runnable() {
            @Override
            public void run() {
                v.telemetry(speed, rpm, gear, drs);
            }
        });
    }
}
