package com.cloudpad.controller;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.Rect;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.view.WindowInsets;
import android.webkit.JavascriptInterface;
import android.webkit.WebSettings;
import android.webkit.WebView;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * Controller surface. The whole touch UI (home screen, five layouts, layout editor,
 * F1 wheel) lives in assets/pad/ and runs inside this WebView. This class only carries
 * data between that page and the rest of the app (Bluetooth / USB / settings).
 *
 * The public surface matches the old canvas view so MainActivity needs no changes.
 */
public class GamepadView extends WebView {

    public interface Listener {
        void onButtonsPressed(int i);

        void onEditingChanged(boolean z);

        void onGamepadState(GamepadState gamepadState);

        void onLayoutResetRequested();

        void onLayoutSaved(String str, String str2);

        void onSettingsTapped();

        void onStatusTapped();

        void onSteeringCenterTapped();
    }

    static final class Tuning {
        boolean floatingSticks = true;
        float stickDeadzone = 0.05f;
        float stickOuterDeadzone = 0.05f;
        boolean analogPedals = true;
        float pedalDeadzone = 0.05f;
        float pedalFullAt = 0.9f;
    }

    private final Listener listener;
    private final Handler main = new Handler(Looper.getMainLooper());
    private final Bridge bridge = new Bridge();

    private boolean ready;
    private boolean editing;
    private boolean connected;
    private boolean steeringAvailable = true;
    private int statusLevel;
    private String statusTitle = "";
    private String statusDetail = "";
    private String mode = "gamepad";
    private Tuning tuning = new Tuning();

    // Latest values coming from the page.
    private int jsButtons;
    private float jsLx;
    private float jsLy;
    private float jsRx;
    private float jsRy;
    private float jsLt;
    private float jsRt;

    // Gyro steering is applied natively so it never waits on the page.
    private boolean gyroActive;
    private float steering;
    private boolean steerPushPending;

    private GamepadState state = new GamepadState();
    private final Runnable steerPush = new Runnable() {
        @Override
        public void run() {
            steerPushPending = false;
            js("cp.setSteering(" + fmt(steering) + ")");
        }
    };

    public GamepadView(Context context, Listener listener) {
        super(context);
        this.listener = listener;
        setBackgroundColor(Color.parseColor("#07080C"));
        setHapticFeedbackEnabled(false);
        setOverScrollMode(View.OVER_SCROLL_NEVER);
        setVerticalScrollBarEnabled(false);
        setHorizontalScrollBarEnabled(false);
        setLongClickable(false);
        setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View v) {
                return true;
            }
        });
        WebSettings ws = getSettings();
        ws.setJavaScriptEnabled(true);
        ws.setDomStorageEnabled(true);
        ws.setAllowFileAccess(true);
        ws.setAllowContentAccess(false);
        ws.setSupportZoom(false);
        ws.setBuiltInZoomControls(false);
        ws.setDisplayZoomControls(false);
        ws.setTextZoom(100);
        ws.setMediaPlaybackRequiresUserGesture(false);
        ws.setCacheMode(WebSettings.LOAD_DEFAULT);
        addJavascriptInterface(bridge, "Native");
        loadUrl("file:///android_asset/pad/index.html");
    }

    // ---------------------------------------------------------------- public API (used by MainActivity)

    public void setMode(String mode, String layout) {
        this.mode = mode == null ? "gamepad" : mode;
        js("cp.setMode(" + quote(this.mode) + ")");
    }

    public void setTuning(Tuning t) {
        if (t == null) {
            return;
        }
        this.tuning = t;
        pushTuning();
    }

    public void setSteeringAvailable(boolean z) {
        this.steeringAvailable = z;
        js("cp.setSteeringAvailable(" + z + ")");
    }

    public void setSteering(float f) {
        if (f == this.steering) {
            return;
        }
        this.steering = f;
        if (gyroActive) {
            publish();
        }
        if (!steerPushPending) {
            steerPushPending = true;
            postOnAnimation(steerPush);
        }
    }

    public GamepadState getState() {
        return state;
    }

    public void setConnected(boolean z) {
        this.connected = z;
        js("cp.setConnected(" + z + ")");
    }

    public void setStatus(int level, String title, String detail) {
        this.statusLevel = level;
        this.statusTitle = title == null ? "" : title;
        this.statusDetail = detail == null ? "" : detail;
        pushStatus();
    }

    public void releaseAll() {
        jsButtons = 0;
        jsLx = jsLy = jsRx = jsRy = jsLt = jsRt = 0f;
        publish();
        js("cp.releaseAll()");
    }

    public boolean isEditing() {
        return editing;
    }

    public void startEditing() {
        js("cp.startEditing()");
    }

    public void cancelEditing() {
        js("cp.cancelEditing()");
    }

    public void resetLayout() {
        js("cp.resetLayout()");
    }

    // ---------------------------------------------------------------- internals

    private void publish() {
        GamepadState s = new GamepadState();
        s.buttons = jsButtons;
        s.lx = gyroActive ? steering : jsLx;
        s.ly = jsLy;
        s.rx = jsRx;
        s.ry = jsRy;
        s.lt = jsLt;
        s.rt = jsRt;
        if (!s.equals(state)) {
            state = s;
            listener.onGamepadState(s);
        }
    }

    private void pushTuning() {
        Tuning t = tuning;
        js("cp.setTuning({floatingSticks:" + t.floatingSticks
                + ",stickDeadzone:" + fmt(t.stickDeadzone)
                + ",stickOuterDeadzone:" + fmt(t.stickOuterDeadzone)
                + ",analogPedals:" + t.analogPedals
                + ",pedalDeadzone:" + fmt(t.pedalDeadzone)
                + ",pedalFullAt:" + fmt(t.pedalFullAt) + "})");
    }

    private void pushStatus() {
        js("cp.setStatus(" + statusLevel + "," + quote(statusTitle) + "," + quote(statusDetail) + ")");
    }

    private void pushAll() {
        js("cp.setMode(" + quote(mode) + ")");
        pushTuning();
        pushStatus();
        js("cp.setSteeringAvailable(" + steeringAvailable + ")");
        js("cp.setConnected(" + connected + ")");
        js("cp.setSteering(" + fmt(steering) + ")");
        if (editing) {
            js("cp.startEditing()");
        }
    }

    private void js(final String code) {
        if (!ready) {
            return;
        }
        if (Looper.myLooper() == Looper.getMainLooper()) {
            evaluateJavascript(code, null);
        } else {
            main.post(new Runnable() {
                @Override
                public void run() {
                    evaluateJavascript(code, null);
                }
            });
        }
    }

    private static String fmt(float f) {
        if (Float.isNaN(f) || Float.isInfinite(f)) {
            return "0";
        }
        return String.format(Locale.US, "%.4f", f);
    }

    private static String quote(String s) {
        StringBuilder sb = new StringBuilder("\"");
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '"':
                    sb.append("\\\"");
                    break;
                case '\\':
                    sb.append("\\\\");
                    break;
                case '\n':
                    sb.append("\\n");
                    break;
                case '\r':
                    break;
                case ' ':
                    sb.append("\\u2028");
                    break;
                case ' ':
                    sb.append("\\u2029");
                    break;
                default:
                    sb.append(c);
            }
        }
        return sb.append('"').toString();
    }

    @Override
    public WindowInsets onApplyWindowInsets(WindowInsets insets) {
        int l = insets.getSystemWindowInsetLeft();
        int t = insets.getSystemWindowInsetTop();
        int r = insets.getSystemWindowInsetRight();
        int b = insets.getSystemWindowInsetBottom();
        if (Build.VERSION.SDK_INT >= 28 && insets.getDisplayCutout() != null) {
            l = Math.max(l, insets.getDisplayCutout().getSafeInsetLeft());
            t = Math.max(t, insets.getDisplayCutout().getSafeInsetTop());
            r = Math.max(r, insets.getDisplayCutout().getSafeInsetRight());
            b = Math.max(b, insets.getDisplayCutout().getSafeInsetBottom());
        }
        float d = getResources().getDisplayMetrics().density;
        final String call = "cp.setInsets(" + fmt(l / d) + "," + fmt(t / d) + "," + fmt(r / d) + "," + fmt(b / d) + ")";
        insetsCall = call;
        js(call);
        return super.onApplyWindowInsets(insets);
    }

    private String insetsCall;

    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        super.onLayout(changed, l, t, r, b);
        if (Build.VERSION.SDK_INT >= 29) {
            // Keep the edge swipe (system Back) from stealing touches meant for the controls.
            float d = getResources().getDisplayMetrics().density;
            int edge = (int) (28 * d);
            int h = b - t;
            List<Rect> rects = new ArrayList<Rect>();
            rects.add(new Rect(0, 0, edge, h));
            rects.add(new Rect(r - l - edge, 0, r - l, h));
            setSystemGestureExclusionRects(rects);
        }
    }

    // ---------------------------------------------------------------- page -> app

    public final class Bridge {
        @JavascriptInterface
        public void ready() {
            main.post(new Runnable() {
                @Override
                public void run() {
                    ready = true;
                    if (insetsCall != null) {
                        js(insetsCall);
                    }
                    pushAll();
                }
            });
        }

        /** buttons bitmask + axes; steering from the page is ignored while gyro steering is on. */
        @JavascriptInterface
        public void state(final int buttons, final double lx, final double ly, final double rx,
                          final double ry, final double lt, final double rt) {
            main.post(new Runnable() {
                @Override
                public void run() {
                    jsButtons = buttons;
                    jsLx = (float) lx;
                    jsLy = (float) ly;
                    jsRx = (float) rx;
                    jsRy = (float) ry;
                    jsLt = (float) lt;
                    jsRt = (float) rt;
                    publish();
                }
            });
        }

        /** The page says whether the phone's tilt sensor currently drives steering. */
        @JavascriptInterface
        public void gyro(final boolean on) {
            main.post(new Runnable() {
                @Override
                public void run() {
                    gyroActive = on;
                    Context c = getContext();
                    if (c instanceof MainActivity) {
                        ((MainActivity) c).setTiltActive(on);
                    }
                    publish();
                }
            });
        }

        @JavascriptInterface
        public void pressed(final int mask) {
            main.post(new Runnable() {
                @Override
                public void run() {
                    listener.onButtonsPressed(mask);
                }
            });
        }

        @JavascriptInterface
        public void editing(final boolean on) {
            main.post(new Runnable() {
                @Override
                public void run() {
                    editing = on;
                    listener.onEditingChanged(on);
                }
            });
        }

        @JavascriptInterface
        public void layoutSaved(final String preset, final String data) {
            main.post(new Runnable() {
                @Override
                public void run() {
                    listener.onLayoutSaved(preset, data);
                }
            });
        }

        @JavascriptInterface
        public void settings() {
            main.post(new Runnable() {
                @Override
                public void run() {
                    listener.onSettingsTapped();
                }
            });
        }

        @JavascriptInterface
        public void status() {
            main.post(new Runnable() {
                @Override
                public void run() {
                    listener.onStatusTapped();
                }
            });
        }

        @JavascriptInterface
        public void center() {
            main.post(new Runnable() {
                @Override
                public void run() {
                    listener.onSteeringCenterTapped();
                }
            });
        }

        /** Remember the family so the rest of the app (tilt sensor, settings) follows the chosen layout. */
        @JavascriptInterface
        public void preset(final String id, final boolean racing) {
            main.post(new Runnable() {
                @Override
                public void run() {
                    SharedPreferences p = getContext().getSharedPreferences("cloudpad", 0);
                    p.edit().putString("preset", id).putString("mode", racing ? "racing" : "gamepad").apply();
                    mode = racing ? "racing" : "gamepad";
                }
            });
        }

        @JavascriptInterface
        public String lastPreset() {
            return getContext().getSharedPreferences("cloudpad", 0).getString("preset", "");
        }
    }
}
