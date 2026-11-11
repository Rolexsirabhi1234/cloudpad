package com.cloudpad.controller;

/* loaded from: classes.dex */
final class GamepadState {
    static final int A = 0;
    static final int B = 1;
    static final int BUTTON_COUNT = 17;
    static final int DOWN = 13;
    static final int GUIDE = 16;
    static final int L3 = 10;
    static final int LB = 4;
    static final int LEFT = 14;
    static final int LT = 6;
    static final int MENU = 9;
    static final int R3 = 11;
    static final int RB = 5;
    static final int RIGHT = 15;
    static final int RT = 7;
    static final int UP = 12;
    static final int VIEW = 8;
    static final int X = 2;
    static final int Y = 3;
    int buttons;
    float lt;
    float lx;
    float ly;
    float rt;
    float rx;
    float ry;

    /* JADX INFO: Access modifiers changed from: package-private */
    public static int bit(int i) {
        return B << i;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean isPressed(int i) {
        return (bit(i) & this.buttons) != 0;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof GamepadState)) {
            return false;
        }
        GamepadState gamepadState = (GamepadState) obj;
        return this.buttons == gamepadState.buttons && Float.compare(this.lx, gamepadState.lx) == 0 && Float.compare(this.ly, gamepadState.ly) == 0 && Float.compare(this.rx, gamepadState.rx) == 0 && Float.compare(this.ry, gamepadState.ry) == 0 && Float.compare(this.lt, gamepadState.lt) == 0 && Float.compare(this.rt, gamepadState.rt) == 0;
    }

    public int hashCode() {
        return (((((((((((this.buttons * 31) + Float.floatToIntBits(this.lx)) * 31) + Float.floatToIntBits(this.ly)) * 31) + Float.floatToIntBits(this.rx)) * 31) + Float.floatToIntBits(this.ry)) * 31) + Float.floatToIntBits(this.lt)) * 31) + Float.floatToIntBits(this.rt);
    }
}
