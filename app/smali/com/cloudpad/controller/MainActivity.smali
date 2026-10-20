.class public final Lcom/cloudpad/controller/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"

# interfaces
.implements Lcom/cloudpad/controller/GamepadView$Listener;
.implements Lcom/cloudpad/controller/BlePeripheral$Listener;


# static fields
.field private static final BACKGROUND_TIMEOUT_MS:J = 0x493e0L

.field private static final REQUEST_ENABLE_BLUETOOTH:I = 0x2

.field private static final REQUEST_PERMISSIONS:I = 0x1

.field private static final REQUEST_SETTINGS:I = 0x3


# instance fields
.field private appliedLayout:Ljava/lang/String;

.field private appliedMode:Ljava/lang/String;

.field private final backgroundTimeout:Ljava/lang/Runnable;

.field private bluetoothManager:Landroid/bluetooth/BluetoothManager;

.field private final bluetoothStateReceiver:Landroid/content/BroadcastReceiver;

.field private editAfterSettings:Z

.field private enableRequested:Z

.field private gamepad:Lcom/cloudpad/controller/GamepadView;

.field private final handler:Landroid/os/Handler;

.field private haptics:Lcom/cloudpad/controller/Haptics;

.field private lastBackPress:J

.field private peripheral:Lcom/cloudpad/controller/BlePeripheral;

.field private peripheralState:I

.field private permissionsRequested:Z

.field private resumed:Z

.field private settings:Lcom/cloudpad/controller/AppSettings;

.field private tilt:Lcom/cloudpad/controller/TiltSteering;


# direct methods
.method public static synthetic $r8$lambda$sequAlnt31W9XSe8Ajudey6SWPU(Lcom/cloudpad/controller/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->stopPeripheral()V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 30
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 38
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/cloudpad/controller/MainActivity;->handler:Landroid/os/Handler;

    .line 39
    new-instance v0, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda2;-><init>(Lcom/cloudpad/controller/MainActivity;)V

    iput-object v0, p0, Lcom/cloudpad/controller/MainActivity;->backgroundTimeout:Ljava/lang/Runnable;

    const/4 v0, -0x1

    .line 47
    iput v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheralState:I

    .line 56
    new-instance v0, Lcom/cloudpad/controller/MainActivity$1;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/MainActivity$1;-><init>(Lcom/cloudpad/controller/MainActivity;)V

    iput-object v0, p0, Lcom/cloudpad/controller/MainActivity;->bluetoothStateReceiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method static synthetic access$002(Lcom/cloudpad/controller/MainActivity;Z)Z
    .locals 0

    .line 30
    iput-boolean p1, p0, Lcom/cloudpad/controller/MainActivity;->enableRequested:Z

    return p1
.end method

.method static synthetic access$100(Lcom/cloudpad/controller/MainActivity;)V
    .locals 0

    .line 30
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->ensureRunning()V

    return-void
.end method

.method static synthetic access$200(Lcom/cloudpad/controller/MainActivity;)V
    .locals 0

    .line 30
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->stopPeripheral()V

    return-void
.end method

.method static synthetic access$300(Lcom/cloudpad/controller/MainActivity;)Lcom/cloudpad/controller/GamepadView;
    .locals 0

    .line 30
    iget-object p0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    return-object p0
.end method

.method private applySettings()V
    .locals 9

    .line 169
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->haptics:Lcom/cloudpad/controller/Haptics;

    iget-object v1, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v1}, Lcom/cloudpad/controller/AppSettings;->haptics()Z

    move-result v1

    iget-object v2, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v2}, Lcom/cloudpad/controller/AppSettings;->rumble()Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/cloudpad/controller/Haptics;->setEnabled(ZZ)V

    .line 170
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    iget-object v1, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v1}, Lcom/cloudpad/controller/AppSettings;->tuning()Lcom/cloudpad/controller/GamepadView$Tuning;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/GamepadView;->setTuning(Lcom/cloudpad/controller/GamepadView$Tuning;)V

    .line 171
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->mode()Ljava/lang/String;

    move-result-object v0

    .line 172
    iget-object v1, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v1, v0}, Lcom/cloudpad/controller/AppSettings;->layout(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 173
    iget-object v2, p0, Lcom/cloudpad/controller/MainActivity;->appliedMode:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/cloudpad/controller/MainActivity;->appliedLayout:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 174
    :cond_0
    iput-object v0, p0, Lcom/cloudpad/controller/MainActivity;->appliedMode:Ljava/lang/String;

    .line 175
    iput-object v1, p0, Lcom/cloudpad/controller/MainActivity;->appliedLayout:Ljava/lang/String;

    .line 176
    iget-object v2, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {v2, v0, v1}, Lcom/cloudpad/controller/GamepadView;->setMode(Ljava/lang/String;Ljava/lang/String;)V

    .line 178
    :cond_1
    iget-object v3, p0, Lcom/cloudpad/controller/MainActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->steeringRange()I

    move-result v0

    int-to-float v4, v0

    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->steeringDeadzone()I

    move-result v0

    int-to-float v5, v0

    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->steeringSmoothing()I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float v6, v0, v1

    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 179
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->steeringInvert()Z

    move-result v7

    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->steeringCenter()F

    move-result v8

    .line 178
    invoke-virtual/range {v3 .. v8}, Lcom/cloudpad/controller/TiltSteering;->configure(FFFZF)V

    .line 180
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheral:Lcom/cloudpad/controller/BlePeripheral;

    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v1}, Lcom/cloudpad/controller/AppSettings;->lowLatency()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/BlePeripheral;->setLowLatency(Z)V

    :cond_2
    return-void
.end method

.method private static bluetoothPermissions()[Ljava/lang/String;
    .locals 3

    .line 217
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    const/4 v0, 0x2

    .line 218
    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "android.permission.BLUETOOTH_ADVERTISE"

    aput-object v1, v0, v2

    const/4 v1, 0x1

    const-string v2, "android.permission.BLUETOOTH_CONNECT"

    aput-object v2, v0, v1

    return-object v0

    .line 220
    :cond_0
    new-array v0, v2, [Ljava/lang/String;

    return-object v0
.end method

.method private ensureRunning()V
    .locals 4

    .line 186
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheral:Lcom/cloudpad/controller/BlePeripheral;

    if-eqz v0, :cond_0

    return-void

    .line 187
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->bluetoothManager:Landroid/bluetooth/BluetoothManager;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothManager;->getAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    goto :goto_0

    :cond_1
    move-object v0, v1

    :goto_0
    const/4 v2, 0x2

    if-nez v0, :cond_2

    .line 189
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    const-string v3, "This phone has no Bluetooth"

    invoke-virtual {v0, v2, v3, v1}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    return-void

    .line 192
    :cond_2
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->hasBluetoothPermissions()Z

    move-result v1

    if-nez v1, :cond_4

    .line 193
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    const-string v1, "Bluetooth permission needed"

    const-string v3, "Tap here to allow \u201cNearby devices\u201d"

    invoke-virtual {v0, v2, v1, v3}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    .line 195
    iget-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->permissionsRequested:Z

    if-nez v0, :cond_3

    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->requestBluetoothPermissions()V

    :cond_3
    return-void

    .line 198
    :cond_4
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v0

    if-nez v0, :cond_6

    .line 199
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    const-string v1, "Bluetooth is off"

    const-string v3, "Tap here to turn it on"

    invoke-virtual {v0, v2, v1, v3}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    .line 200
    iget-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->enableRequested:Z

    if-nez v0, :cond_5

    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->requestEnableBluetooth()V

    :cond_5
    return-void

    .line 203
    :cond_6
    new-instance v0, Lcom/cloudpad/controller/BlePeripheral;

    iget-object v1, p0, Lcom/cloudpad/controller/MainActivity;->bluetoothManager:Landroid/bluetooth/BluetoothManager;

    iget-object v2, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v2}, Lcom/cloudpad/controller/AppSettings;->lowLatency()Z

    move-result v2

    invoke-direct {v0, p0, v1, p0, v2}, Lcom/cloudpad/controller/BlePeripheral;-><init>(Landroid/content/Context;Landroid/bluetooth/BluetoothManager;Lcom/cloudpad/controller/BlePeripheral$Listener;Z)V

    iput-object v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheral:Lcom/cloudpad/controller/BlePeripheral;

    .line 204
    invoke-virtual {v0}, Lcom/cloudpad/controller/BlePeripheral;->start()V

    .line 205
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheral:Lcom/cloudpad/controller/BlePeripheral;

    iget-object v1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {v1}, Lcom/cloudpad/controller/GamepadView;->getState()Lcom/cloudpad/controller/GamepadState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/BlePeripheral;->updateState(Lcom/cloudpad/controller/GamepadState;)V

    return-void
.end method

.method private enterImmersiveMode()V
    .locals 3

    .line 380
    invoke-virtual {p0}, Lcom/cloudpad/controller/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 381
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1e

    if-lt v1, v2, :cond_0

    const/4 v1, 0x0

    .line 382
    invoke-virtual {v0, v1}, Landroid/view/Window;->setDecorFitsSystemWindows(Z)V

    .line 383
    invoke-virtual {v0}, Landroid/view/Window;->getInsetsController()Landroid/view/WindowInsetsController;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 385
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemBars()I

    move-result v1

    invoke-interface {v0, v1}, Landroid/view/WindowInsetsController;->hide(I)V

    const/4 v1, 0x2

    .line 386
    invoke-interface {v0, v1}, Landroid/view/WindowInsetsController;->setSystemBarsBehavior(I)V

    goto :goto_0

    .line 389
    :cond_0
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x1706

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    :cond_1
    :goto_0
    return-void
.end method

.method private hasBluetoothPermissions()Z
    .locals 5

    .line 224
    invoke-static {}, Lcom/cloudpad/controller/MainActivity;->bluetoothPermissions()[Ljava/lang/String;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_1

    aget-object v4, v0, v3

    .line 225
    invoke-virtual {p0, v4}, Lcom/cloudpad/controller/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v4

    if-eqz v4, :cond_0

    return v2

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x1

    return v0
.end method

.method private openSystemSettings(Landroid/content/Intent;)V
    .locals 1

    .line 401
    :try_start_0
    invoke-virtual {p0, p1}, Lcom/cloudpad/controller/MainActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 403
    :catch_0
    const-string p1, "Open Settings to fix Bluetooth access"

    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :goto_0
    return-void
.end method

.method private requestBluetoothPermissions()V
    .locals 2

    const/4 v0, 0x1

    .line 238
    iput-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->permissionsRequested:Z

    .line 239
    invoke-static {}, Lcom/cloudpad/controller/MainActivity;->bluetoothPermissions()[Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v0}, Lcom/cloudpad/controller/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void
.end method

.method private requestEnableBluetooth()V
    .locals 2

    const/4 v0, 0x1

    .line 250
    iput-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->enableRequested:Z

    .line 252
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.bluetooth.adapter.action.REQUEST_ENABLE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x2

    invoke-virtual {p0, v0, v1}, Lcom/cloudpad/controller/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 254
    :catch_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.BLUETOOTH_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/MainActivity;->openSystemSettings(Landroid/content/Intent;)V

    :goto_0
    return-void
.end method

.method private shouldShowAnyRationale()Z
    .locals 5

    .line 231
    invoke-static {}, Lcom/cloudpad/controller/MainActivity;->bluetoothPermissions()[Ljava/lang/String;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_1

    aget-object v4, v0, v3

    .line 232
    invoke-virtual {p0, v4}, Lcom/cloudpad/controller/MainActivity;->shouldShowRequestPermissionRationale(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    return v2
.end method

.method private stopPeripheral()V
    .locals 2

    .line 209
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheral:Lcom/cloudpad/controller/BlePeripheral;

    if-nez v0, :cond_0

    return-void

    .line 210
    :cond_0
    invoke-virtual {v0}, Lcom/cloudpad/controller/BlePeripheral;->stop()V

    const/4 v0, 0x0

    .line 211
    iput-object v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheral:Lcom/cloudpad/controller/BlePeripheral;

    const/4 v0, -0x1

    .line 212
    iput v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheralState:I

    .line 213
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/GamepadView;->setConnected(Z)V

    return-void
.end method


# virtual methods
.method synthetic lambda$onCreate$0$com-cloudpad-controller-MainActivity(FF)V
    .locals 0

    .line 86
    iget-object p2, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {p2, p1}, Lcom/cloudpad/controller/GamepadView;->setSteering(F)V

    return-void
.end method

.method synthetic lambda$onLayoutResetRequested$1$com-cloudpad-controller-MainActivity(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 336
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {p1}, Lcom/cloudpad/controller/GamepadView;->resetLayout()V

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    .line 260
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    .line 262
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->ensureRunning()V

    goto :goto_0

    :cond_0
    const/4 v0, 0x3

    if-ne p1, v0, :cond_1

    iget v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheralState:I

    const/4 p1, 0x1

    if-ne v0, p1, :pc_keep

    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->stopPeripheral()V

    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->ensureRunning()V

    :pc_keep
    const/4 p1, -0x1

    if-ne p2, p1, :cond_1

    if-eqz p3, :cond_1

    .line 263
    const-string p1, "edit_layout"

    const/4 p2, 0x0

    .line 264
    invoke-virtual {p3, p1, p2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result p1

    if-eqz p1, :cond_1

    const/4 p1, 0x1

    .line 265
    iput-boolean p1, p0, Lcom/cloudpad/controller/MainActivity;->editAfterSettings:Z

    :cond_1
    :goto_0
    return-void
.end method

.method public onBackPressed()V
    .locals 8

    .line 154
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {v0}, Lcom/cloudpad/controller/GamepadView;->isEditing()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 155
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {v0}, Lcom/cloudpad/controller/GamepadView;->cancelEditing()V

    .line 156
    const-string v0, "Layout changes discarded"

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void

    .line 159
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    .line 160
    iget-wide v4, p0, Lcom/cloudpad/controller/MainActivity;->lastBackPress:J

    sub-long v4, v2, v4

    const-wide/16 v6, 0x7d0

    cmp-long v0, v4, v6

    if-gez v0, :cond_1

    .line 161
    invoke-super {p0}, Landroid/app/Activity;->onBackPressed()V

    goto :goto_0

    .line 163
    :cond_1
    iput-wide v2, p0, Lcom/cloudpad/controller/MainActivity;->lastBackPress:J

    .line 164
    const-string v0, "Press back again to exit"

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    :goto_0
    return-void
.end method

.method public onButtonsPressed(I)V
    .locals 0

    .line 278
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->haptics:Lcom/cloudpad/controller/Haptics;

    invoke-virtual {p1}, Lcom/cloudpad/controller/Haptics;->tick()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    .line 73
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 74
    invoke-virtual {p0}, Lcom/cloudpad/controller/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/16 v0, 0x80

    .line 75
    invoke-virtual {p1, v0}, Landroid/view/Window;->addFlags(I)V

    .line 76
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 77
    invoke-virtual {p1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    const/4 v1, 0x1

    .line 78
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->layoutInDisplayCutoutMode:I

    .line 79
    invoke-virtual {p1, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 82
    :cond_0
    new-instance p1, Lcom/cloudpad/controller/AppSettings;

    invoke-direct {p1, p0}, Lcom/cloudpad/controller/AppSettings;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 83
    const-class p1, Landroid/bluetooth/BluetoothManager;

    invoke-virtual {p0, p1}, Lcom/cloudpad/controller/MainActivity;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/bluetooth/BluetoothManager;

    iput-object p1, p0, Lcom/cloudpad/controller/MainActivity;->bluetoothManager:Landroid/bluetooth/BluetoothManager;

    .line 84
    new-instance p1, Lcom/cloudpad/controller/Haptics;

    invoke-direct {p1, p0}, Lcom/cloudpad/controller/Haptics;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/cloudpad/controller/MainActivity;->haptics:Lcom/cloudpad/controller/Haptics;

    .line 85
    new-instance p1, Lcom/cloudpad/controller/GamepadView;

    invoke-direct {p1, p0, p0}, Lcom/cloudpad/controller/GamepadView;-><init>(Landroid/content/Context;Lcom/cloudpad/controller/GamepadView$Listener;)V

    iput-object p1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    .line 86
    new-instance p1, Lcom/cloudpad/controller/TiltSteering;

    new-instance v0, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda0;-><init>(Lcom/cloudpad/controller/MainActivity;)V

    invoke-direct {p1, p0, v0}, Lcom/cloudpad/controller/TiltSteering;-><init>(Landroid/app/Activity;Lcom/cloudpad/controller/TiltSteering$Listener;)V

    iput-object p1, p0, Lcom/cloudpad/controller/MainActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    .line 87
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {p1}, Lcom/cloudpad/controller/TiltSteering;->isAvailable()Z

    move-result p1

    invoke-virtual {v0, p1}, Lcom/cloudpad/controller/GamepadView;->setSteeringAvailable(Z)V

    .line 88
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {p0, p1}, Lcom/cloudpad/controller/MainActivity;->setContentView(Landroid/view/View;)V

    .line 89
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->applySettings()V

    .line 92
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->bluetoothStateReceiver:Landroid/content/BroadcastReceiver;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.bluetooth.adapter.action.STATE_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1, v0}, Lcom/cloudpad/controller/MainActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-static {p0, v0}, Lcom/cloudpad/controller/UsbLink;->start(Lcom/cloudpad/controller/MainActivity;Lcom/cloudpad/controller/GamepadView;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .line 133
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->handler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 134
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->bluetoothStateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/cloudpad/controller/MainActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 135
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v0}, Lcom/cloudpad/controller/TiltSteering;->stop()V

    invoke-static {}, Lcom/cloudpad/controller/UsbLink;->stop()V

    .line 136
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->stopPeripheral()V

    .line 137
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->haptics:Lcom/cloudpad/controller/Haptics;

    invoke-virtual {v0}, Lcom/cloudpad/controller/Haptics;->cancel()V

    .line 138
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    return-void
.end method

.method public onEditingChanged(Z)V
    .locals 0

    if-eqz p1, :cond_0

    .line 321
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->haptics:Lcom/cloudpad/controller/Haptics;

    invoke-virtual {p1}, Lcom/cloudpad/controller/Haptics;->confirm()V

    :cond_0
    return-void
.end method

.method public onGamepadState(Lcom/cloudpad/controller/GamepadState;)V
    .locals 1

    .line 273
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheral:Lcom/cloudpad/controller/BlePeripheral;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/cloudpad/controller/BlePeripheral;->updateState(Lcom/cloudpad/controller/GamepadState;)V

    :cond_0
    invoke-static {p1}, Lcom/cloudpad/controller/UsbLink;->state(Lcom/cloudpad/controller/GamepadState;)V

    return-void
.end method

.method public onLayoutResetRequested()V
    .locals 3

    .line 333
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "Reset layout?"

    .line 334
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Every control goes back to its original place and size. Tap Done afterwards to keep it."

    .line 335
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda1;-><init>(Lcom/cloudpad/controller/MainActivity;)V

    .line 336
    const-string v2, "Reset"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Cancel"

    const/4 v2, 0x0

    .line 337
    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 338
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void
.end method

.method public onLayoutSaved(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .line 326
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0, p1, p2}, Lcom/cloudpad/controller/AppSettings;->setLayout(Ljava/lang/String;Ljava/lang/String;)V

    .line 327
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->appliedMode:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    iput-object p2, p0, Lcom/cloudpad/controller/MainActivity;->appliedLayout:Ljava/lang/String;

    .line 328
    :cond_0
    const-string p1, "Layout saved"

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method protected onPause()V
    .locals 2

    .line 117
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    const/4 v0, 0x0

    .line 118
    iput-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->resumed:Z

    .line 119
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v0}, Lcom/cloudpad/controller/TiltSteering;->stop()V

    .line 120
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/GamepadView;->setSteering(F)V

    .line 121
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {v0}, Lcom/cloudpad/controller/GamepadView;->releaseAll()V

    .line 122
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->haptics:Lcom/cloudpad/controller/Haptics;

    invoke-virtual {v0}, Lcom/cloudpad/controller/Haptics;->stopRumble()V

    return-void
.end method

.method public onPeripheralState(ILjava/lang/String;)V
    .locals 6

    .line 345
    iget v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheralState:I

    .line 346
    iput p1, p0, Lcom/cloudpad/controller/MainActivity;->peripheralState:I

    .line 347
    iget-object v1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x2

    if-ne p1, v4, :cond_0

    move v5, v2

    goto :goto_0

    :cond_0
    move v5, v3

    :goto_0
    invoke-virtual {v1, v5}, Lcom/cloudpad/controller/GamepadView;->setConnected(Z)V

    if-eqz p1, :cond_5

    if-eq p1, v2, :cond_3

    if-eq p1, v4, :cond_1

    .line 366
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    const-string v0, "Tap here to retry"

    invoke-virtual {p1, v4, p2, v0}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    .line 359
    :cond_1
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    if-eqz p2, :cond_2

    .line 360
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "Connected to "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_1

    :cond_2
    const-string p2, "Connected"

    :goto_1
    const-string v1, "Keep this app open while you play"

    .line 359
    invoke-virtual {p1, v2, p2, v1}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    if-eq v0, v4, :cond_6

    .line 362
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->haptics:Lcom/cloudpad/controller/Haptics;

    invoke-virtual {p1}, Lcom/cloudpad/controller/Haptics;->confirm()V

    goto :goto_3

    .line 353
    :cond_3
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-static {p0, p2}, Lcom/cloudpad/controller/PcMode;->waitingDetail(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :pc_cloud

    move-object p2, v0

    goto :goto_2

    :pc_cloud
    if-eqz p2, :cond_4

    .line 355
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "On xbox.com/play click \u201cConnect phone\u201d, then pick \u201c"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, "\u201d"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_2

    .line 356
    :cond_4
    const-string p2, "On xbox.com/play click \u201cConnect phone\u201d"

    .line 353
    :goto_2
    const-string v0, "Waiting for your laptop"

    invoke-virtual {p1, v3, v0, p2}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    .line 350
    :cond_5
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    const-string p2, "Starting Bluetooth\u2026"

    const/4 v0, 0x0

    invoke-virtual {p1, v3, p2, v0}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    :cond_6
    :goto_3
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    .line 244
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    const/4 p2, 0x1

    if-ne p1, p2, :cond_0

    .line 245
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->ensureRunning()V

    :cond_0
    return-void
.end method

.method protected onResume()V
    .locals 2

    .line 104
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    const/4 v0, 0x1

    .line 105
    iput-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->resumed:Z

    .line 106
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->applySettings()V

    .line 107
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->enterImmersiveMode()V

    .line 108
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->mode()Ljava/lang/String;

    move-result-object v0

    const-string v1, "racing"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v0}, Lcom/cloudpad/controller/TiltSteering;->start()V

    .line 109
    :cond_0
    iget-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->editAfterSettings:Z

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    .line 110
    iput-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->editAfterSettings:Z

    .line 111
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-static {v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda3;

    invoke-direct {v1, v0}, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda3;-><init>(Lcom/cloudpad/controller/GamepadView;)V

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/GamepadView;->post(Ljava/lang/Runnable;)Z

    :cond_1
    return-void
.end method

.method public onRumble(III)V
    .locals 1

    .line 373
    iget-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->resumed:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->haptics:Lcom/cloudpad/controller/Haptics;

    invoke-virtual {v0, p1, p2, p3}, Lcom/cloudpad/controller/Haptics;->rumble(III)V

    :cond_0
    return-void
.end method

.method public onSettingsTapped()V
    .locals 2

    .line 305
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/cloudpad/controller/SettingsActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v1, 0x3

    invoke-virtual {p0, v0, v1}, Lcom/cloudpad/controller/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method

.method protected onStart()V
    .locals 2

    .line 97
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    .line 98
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/cloudpad/controller/MainActivity;->backgroundTimeout:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 99
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->ensureRunning()V

    return-void
.end method

.method public onStatusTapped()V
    .locals 4

    .line 283
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->bluetoothManager:Landroid/bluetooth/BluetoothManager;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothManager;->getAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    :goto_0
    if-nez v0, :cond_1

    return-void

    .line 285
    :cond_1
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->hasBluetoothPermissions()Z

    move-result v2

    if-nez v2, :cond_3

    .line 286
    iget-boolean v0, p0, Lcom/cloudpad/controller/MainActivity;->permissionsRequested:Z

    if-eqz v0, :cond_2

    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->shouldShowAnyRationale()Z

    move-result v0

    if-nez v0, :cond_2

    .line 288
    new-instance v0, Landroid/content/Intent;

    const-string v2, "package"

    .line 289
    invoke-virtual {p0}, Lcom/cloudpad/controller/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3, v1}, Landroid/net/Uri;->fromParts(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const-string v2, "android.settings.APPLICATION_DETAILS_SETTINGS"

    invoke-direct {v0, v2, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 288
    invoke-direct {p0, v0}, Lcom/cloudpad/controller/MainActivity;->openSystemSettings(Landroid/content/Intent;)V

    goto :goto_1

    .line 291
    :cond_2
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->requestBluetoothPermissions()V

    goto :goto_1

    .line 293
    :cond_3
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v0

    if-nez v0, :cond_4

    .line 294
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->requestEnableBluetooth()V

    goto :goto_1

    .line 295
    :cond_4
    iget v0, p0, Lcom/cloudpad/controller/MainActivity;->peripheralState:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_5

    .line 296
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->stopPeripheral()V

    .line 297
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->ensureRunning()V

    goto :goto_1

    .line 299
    :cond_5
    invoke-static {p0}, Lcom/cloudpad/controller/Dialogs;->connectHelp(Landroid/app/Activity;)V

    :goto_1
    return-void
.end method

.method public onSteeringCenterTapped()V
    .locals 3

    .line 310
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v0}, Lcom/cloudpad/controller/TiltSteering;->isAvailable()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 311
    const-string v0, "This phone has no tilt sensor"

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void

    .line 314
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    iget-object v2, p0, Lcom/cloudpad/controller/MainActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v2}, Lcom/cloudpad/controller/TiltSteering;->recenter()F

    move-result v2

    invoke-virtual {v0, v2}, Lcom/cloudpad/controller/AppSettings;->setSteeringCenter(F)V

    .line 315
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->haptics:Lcom/cloudpad/controller/Haptics;

    invoke-virtual {v0}, Lcom/cloudpad/controller/Haptics;->confirm()V

    .line 316
    const-string v0, "Steering centered"

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method protected onStop()V
    .locals 4

    .line 127
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 128
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/cloudpad/controller/MainActivity;->backgroundTimeout:Ljava/lang/Runnable;

    const-wide/32 v2, 0x493e0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 0

    .line 143
    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowFocusChanged(Z)V

    if-eqz p1, :cond_0

    .line 145
    invoke-direct {p0}, Lcom/cloudpad/controller/MainActivity;->enterImmersiveMode()V

    goto :goto_0

    .line 147
    :cond_0
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity;->gamepad:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {p1}, Lcom/cloudpad/controller/GamepadView;->releaseAll()V

    :goto_0
    return-void
.end method
