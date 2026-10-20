.class final Lcom/cloudpad/controller/BlePeripheral;
.super Ljava/lang/Object;
.source "BlePeripheral.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cloudpad/controller/BlePeripheral$Listener;,
        Lcom/cloudpad/controller/BlePeripheral$Central;
    }
.end annotation


# static fields
.field private static final HEARTBEAT_MS:J = 0xfaL

.field private static final LOW_LATENCY_DELAY_MS:J = 0x3e8L

.field private static final NOTIFY_TIMEOUT_MS:J = 0xc8L

.field private static final RETRY_MS:J = 0x8L

.field static final STATE_ADVERTISING:I = 0x1

.field static final STATE_CONNECTED:I = 0x2

.field static final STATE_ERROR:I = 0x3

.field static final STATE_STARTING:I = 0x0

.field private static final TAG:Ljava/lang/String; = "CloudPad"

.field private static final TICK_MS:J = 0x32L


# instance fields
.field private final adapter:Landroid/bluetooth/BluetoothAdapter;

.field private final advertiseCallback:Landroid/bluetooth/le/AdvertiseCallback;

.field private advertiser:Landroid/bluetooth/le/BluetoothLeAdvertiser;

.field private advertising:Z

.field private final centrals:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/cloudpad/controller/BlePeripheral$Central;",
            ">;"
        }
    .end annotation
.end field

.field private final context:Landroid/content/Context;

.field private failed:Z

.field private final gattCallback:Landroid/bluetooth/BluetoothGattServerCallback;

.field private final handler:Landroid/os/Handler;

.field private includeName:Z

.field private input:Landroid/bluetooth/BluetoothGattCharacteristic;

.field private final listener:Lcom/cloudpad/controller/BlePeripheral$Listener;

.field private lowLatency:Z

.field private final main:Landroid/os/Handler;

.field private final manager:Landroid/bluetooth/BluetoothManager;

.field private volatile released:Z

.field private reportedDetail:Ljava/lang/String;

.field private reportedState:I

.field private final retry:Ljava/lang/Runnable;

.field private retryPending:Z

.field private sequence:I

.field private volatile server:Landroid/bluetooth/BluetoothGattServer;

.field private volatile state:[B

.field private stateVersion:I

.field private stopped:Z

.field private final thread:Landroid/os/HandlerThread;

.field private final tick:Ljava/lang/Runnable;


# direct methods
.method public static synthetic $r8$lambda$nJ8VrhSglbjd0CKHcn3JhnwRV0w(Lcom/cloudpad/controller/BlePeripheral;)V
    .locals 0

    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->openServer()V

    return-void
.end method

.method constructor <init>(Landroid/content/Context;Landroid/bluetooth/BluetoothManager;Lcom/cloudpad/controller/BlePeripheral$Listener;Z)V
    .locals 2

    .line 107
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 86
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->main:Landroid/os/Handler;

    .line 87
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    .line 90
    new-instance v0, Lcom/cloudpad/controller/GamepadState;

    invoke-direct {v0}, Lcom/cloudpad/controller/GamepadState;-><init>()V

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/cloudpad/controller/Protocol;->encodeState(Lcom/cloudpad/controller/GamepadState;I)[B

    move-result-object v0

    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->state:[B

    const/4 v0, 0x1

    .line 97
    iput-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->includeName:Z

    const/4 v0, -0x1

    .line 104
    iput v0, p0, Lcom/cloudpad/controller/BlePeripheral;->reportedState:I

    .line 390
    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$2;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/BlePeripheral$2;-><init>(Lcom/cloudpad/controller/BlePeripheral;)V

    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->tick:Ljava/lang/Runnable;

    .line 399
    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda1;-><init>(Lcom/cloudpad/controller/BlePeripheral;)V

    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->retry:Ljava/lang/Runnable;

    .line 507
    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$3;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/BlePeripheral$3;-><init>(Lcom/cloudpad/controller/BlePeripheral;)V

    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->advertiseCallback:Landroid/bluetooth/le/AdvertiseCallback;

    .line 522
    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$4;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/BlePeripheral$4;-><init>(Lcom/cloudpad/controller/BlePeripheral;)V

    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->gattCallback:Landroid/bluetooth/BluetoothGattServerCallback;

    .line 108
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral;->context:Landroid/content/Context;

    .line 109
    iput-object p2, p0, Lcom/cloudpad/controller/BlePeripheral;->manager:Landroid/bluetooth/BluetoothManager;

    .line 110
    invoke-virtual {p2}, Landroid/bluetooth/BluetoothManager;->getAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object p1

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral;->adapter:Landroid/bluetooth/BluetoothAdapter;

    .line 111
    iput-object p3, p0, Lcom/cloudpad/controller/BlePeripheral;->listener:Lcom/cloudpad/controller/BlePeripheral$Listener;

    .line 112
    iput-boolean p4, p0, Lcom/cloudpad/controller/BlePeripheral;->lowLatency:Z

    .line 113
    new-instance p1, Landroid/os/HandlerThread;

    const-string p2, "CloudPad-BLE"

    const/4 p3, -0x4

    invoke-direct {p1, p2, p3}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;I)V

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral;->thread:Landroid/os/HandlerThread;

    .line 114
    invoke-virtual {p1}, Landroid/os/HandlerThread;->start()V

    .line 115
    new-instance p2, Landroid/os/Handler;

    invoke-virtual {p1}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object p1

    invoke-direct {p2, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p2, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    return-void
.end method

.method static synthetic access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;
    .locals 0

    .line 43
    iget-object p0, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic access$100(Lcom/cloudpad/controller/BlePeripheral;)Z
    .locals 0

    .line 43
    iget-boolean p0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    return p0
.end method

.method static synthetic access$1000(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;Z)V
    .locals 0

    .line 43
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/BlePeripheral;->onSubscription(Landroid/bluetooth/BluetoothDevice;Z)V

    return-void
.end method

.method static synthetic access$1100(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;[B)V
    .locals 0

    .line 43
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/BlePeripheral;->onOutput(Landroid/bluetooth/BluetoothDevice;[B)V

    return-void
.end method

.method static synthetic access$1200(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;I)V
    .locals 0

    .line 43
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/BlePeripheral;->onConnectionChanged(Landroid/bluetooth/BluetoothDevice;I)V

    return-void
.end method

.method static synthetic access$1300(Lcom/cloudpad/controller/BlePeripheral;)V
    .locals 0

    .line 43
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->startAdvertising()V

    return-void
.end method

.method static synthetic access$1400(Lcom/cloudpad/controller/BlePeripheral;Ljava/lang/String;)V
    .locals 0

    .line 43
    invoke-direct {p0, p1}, Lcom/cloudpad/controller/BlePeripheral;->fail(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$200(Lcom/cloudpad/controller/BlePeripheral;)V
    .locals 0

    .line 43
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->pump()V

    return-void
.end method

.method static synthetic access$300(Lcom/cloudpad/controller/BlePeripheral;I)V
    .locals 0

    .line 43
    invoke-direct {p0, p1}, Lcom/cloudpad/controller/BlePeripheral;->onAdvertiseFailure(I)V

    return-void
.end method

.method static synthetic access$402(Lcom/cloudpad/controller/BlePeripheral;Z)Z
    .locals 0

    .line 43
    iput-boolean p1, p0, Lcom/cloudpad/controller/BlePeripheral;->advertising:Z

    return p1
.end method

.method static synthetic access$500(Lcom/cloudpad/controller/BlePeripheral;)V
    .locals 0

    .line 43
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->reportCurrent()V

    return-void
.end method

.method static synthetic access$600(Lcom/cloudpad/controller/BlePeripheral;)[B
    .locals 0

    .line 43
    iget-object p0, p0, Lcom/cloudpad/controller/BlePeripheral;->state:[B

    return-object p0
.end method

.method static synthetic access$700(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;II[B)V
    .locals 0

    .line 43
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/cloudpad/controller/BlePeripheral;->respond(Landroid/bluetooth/BluetoothDevice;II[B)V

    return-void
.end method

.method static synthetic access$800(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;III[B)V
    .locals 0

    .line 43
    invoke-direct/range {p0 .. p5}, Lcom/cloudpad/controller/BlePeripheral;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)V

    return-void
.end method

.method static synthetic access$900(Lcom/cloudpad/controller/BlePeripheral;)Ljava/util/Map;
    .locals 0

    .line 43
    iget-object p0, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    return-object p0
.end method

.method private adapterName()Ljava/lang/String;
    .locals 1

    .line 491
    :try_start_0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->adapter:Landroid/bluetooth/BluetoothAdapter;

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getName()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method private static advertiseError(I)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x2

    if-eq p0, v0, :cond_1

    const/4 v0, 0x5

    if-eq p0, v0, :cond_0

    .line 289
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Bluetooth advertising failed (error "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ")"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 285
    :cond_0
    const-string p0, "This phone doesn\'t support Bluetooth LE advertising"

    return-object p0

    .line 287
    :cond_1
    const-string p0, "Too many apps are using Bluetooth advertising"

    return-object p0
.end method

.method private static deviceName(Landroid/bluetooth/BluetoothDevice;)Ljava/lang/String;
    .locals 0

    .line 499
    :try_start_0
    invoke-virtual {p0}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private fail(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    .line 484
    iput-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->failed:Z

    .line 485
    const-string v0, "CloudPad"

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x3

    .line 486
    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/BlePeripheral;->report(ILjava/lang/String;)V

    return-void
.end method

.method private notify(Landroid/bluetooth/BluetoothDevice;[B)Z
    .locals 4

    .line 447
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->server:Landroid/bluetooth/BluetoothGattServer;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 450
    :cond_0
    :try_start_0
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x21

    if-lt v2, v3, :cond_2

    .line 451
    iget-object v2, p0, Lcom/cloudpad/controller/BlePeripheral;->input:Landroid/bluetooth/BluetoothGattCharacteristic;

    invoke-virtual {v0, p1, v2, v1, p2}, Landroid/bluetooth/BluetoothGattServer;->notifyCharacteristicChanged(Landroid/bluetooth/BluetoothDevice;Landroid/bluetooth/BluetoothGattCharacteristic;Z[B)I

    move-result p1

    if-nez p1, :cond_1

    const/4 v1, 0x1

    :cond_1
    return v1

    .line 453
    :cond_2
    iget-object v2, p0, Lcom/cloudpad/controller/BlePeripheral;->input:Landroid/bluetooth/BluetoothGattCharacteristic;

    invoke-virtual {v2, p2}, Landroid/bluetooth/BluetoothGattCharacteristic;->setValue([B)Z

    .line 454
    iget-object p2, p0, Lcom/cloudpad/controller/BlePeripheral;->input:Landroid/bluetooth/BluetoothGattCharacteristic;

    invoke-virtual {v0, p1, p2, v1}, Landroid/bluetooth/BluetoothGattServer;->notifyCharacteristicChanged(Landroid/bluetooth/BluetoothDevice;Landroid/bluetooth/BluetoothGattCharacteristic;Z)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 456
    const-string p2, "CloudPad"

    const-string v0, "Notification failed"

    invoke-static {p2, v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return v1
.end method

.method private onAdvertiseFailure(I)V
    .locals 3

    .line 261
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-ne p1, v1, :cond_1

    .line 262
    iget-boolean v2, p0, Lcom/cloudpad/controller/BlePeripheral;->includeName:Z

    if-eqz v2, :cond_1

    .line 263
    iput-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->includeName:Z

    .line 264
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->startAdvertising()V

    return-void

    :cond_1
    const/4 v2, 0x3

    if-ne p1, v2, :cond_2

    .line 268
    iput-boolean v1, p0, Lcom/cloudpad/controller/BlePeripheral;->advertising:Z

    .line 269
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->reportCurrent()V

    return-void

    .line 272
    :cond_2
    iput-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->advertising:Z

    .line 273
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Advertising failed: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CloudPad"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 275
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 276
    invoke-static {p1}, Lcom/cloudpad/controller/BlePeripheral;->advertiseError(I)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/cloudpad/controller/BlePeripheral;->fail(Ljava/lang/String;)V

    goto :goto_0

    .line 278
    :cond_3
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->reportCurrent()V

    :goto_0
    return-void
.end method

.method private onConnectionChanged(Landroid/bluetooth/BluetoothDevice;I)V
    .locals 4

    .line 296
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    if-eqz v0, :cond_0

    return-void

    .line 297
    :cond_0
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x2

    if-ne p2, v1, :cond_2

    .line 299
    iget-object p2, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {p2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/cloudpad/controller/BlePeripheral$Central;

    if-nez p2, :cond_1

    .line 301
    new-instance p2, Lcom/cloudpad/controller/BlePeripheral$Central;

    invoke-direct {p2, p1}, Lcom/cloudpad/controller/BlePeripheral$Central;-><init>(Landroid/bluetooth/BluetoothDevice;)V

    .line 302
    iget-object p1, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {p1, v0, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 306
    :cond_1
    iget-object p1, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    new-instance v1, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0, v0, p2}, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda4;-><init>(Lcom/cloudpad/controller/BlePeripheral;Ljava/lang/String;Lcom/cloudpad/controller/BlePeripheral$Central;)V

    const-wide/16 v2, 0x3e8

    invoke-virtual {p1, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    :cond_2
    if-nez p2, :cond_3

    .line 310
    iget-object p1, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {p1, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/cloudpad/controller/BlePeripheral$Central;

    if-eqz p1, :cond_3

    .line 311
    invoke-static {p1}, Lcom/cloudpad/controller/BlePeripheral;->releaseCentral(Lcom/cloudpad/controller/BlePeripheral$Central;)V

    .line 313
    :cond_3
    :goto_0
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->restartAdvertising()V

    .line 314
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->reportCurrent()V

    return-void
.end method

.method private onOutput(Landroid/bluetooth/BluetoothDevice;[B)V
    .locals 3

    .line 332
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    if-nez v0, :cond_2

    array-length v0, p2

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 333
    aget-byte v0, p2, v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 334
    invoke-static {p2}, Lcom/cloudpad/controller/Protocol;->parseRumble([B)[I

    move-result-object p1

    if-eqz p1, :cond_2

    .line 336
    iget-object p2, p0, Lcom/cloudpad/controller/BlePeripheral;->main:Landroid/os/Handler;

    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda3;

    invoke-direct {v0, p0, p1}, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda3;-><init>(Lcom/cloudpad/controller/BlePeripheral;[I)V

    invoke-virtual {p2, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    :cond_1
    const/4 v2, 0x2

    if-ne v0, v2, :cond_2

    .line 340
    array-length v0, p2

    if-lt v0, v2, :cond_2

    .line 341
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/cloudpad/controller/BlePeripheral$Central;

    if-eqz p1, :cond_2

    .line 343
    aget-byte p2, p2, v1

    invoke-static {p2}, Lcom/cloudpad/controller/Protocol;->pong(B)[B

    move-result-object p2

    iput-object p2, p1, Lcom/cloudpad/controller/BlePeripheral$Central;->pendingPong:[B

    .line 344
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->pump()V

    :cond_2
    :goto_0
    return-void
.end method

.method private onSubscription(Landroid/bluetooth/BluetoothDevice;Z)V
    .locals 2

    .line 318
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    if-eqz v0, :cond_0

    return-void

    .line 319
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cloudpad/controller/BlePeripheral$Central;

    if-nez v0, :cond_1

    .line 321
    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$Central;

    invoke-direct {v0, p1}, Lcom/cloudpad/controller/BlePeripheral$Central;-><init>(Landroid/bluetooth/BluetoothDevice;)V

    .line 322
    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 324
    :cond_1
    iput-boolean p2, v0, Lcom/cloudpad/controller/BlePeripheral$Central;->subscribed:Z

    const/4 p1, 0x0

    .line 325
    iput-boolean p1, v0, Lcom/cloudpad/controller/BlePeripheral$Central;->inFlight:Z

    const/4 p1, -0x1

    .line 326
    iput p1, v0, Lcom/cloudpad/controller/BlePeripheral$Central;->sentVersion:I

    .line 327
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->reportCurrent()V

    .line 328
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->pump()V

    return-void
.end method

.method private openServer()V
    .locals 6

    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 176
    invoke-direct {p0, v1, v0}, Lcom/cloudpad/controller/BlePeripheral;->report(ILjava/lang/String;)V

    .line 179
    :try_start_0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->manager:Landroid/bluetooth/BluetoothManager;

    iget-object v2, p0, Lcom/cloudpad/controller/BlePeripheral;->context:Landroid/content/Context;

    iget-object v3, p0, Lcom/cloudpad/controller/BlePeripheral;->gattCallback:Landroid/bluetooth/BluetoothGattServerCallback;

    invoke-virtual {v0, v2, v3}, Landroid/bluetooth/BluetoothManager;->openGattServer(Landroid/content/Context;Landroid/bluetooth/BluetoothGattServerCallback;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v0, :cond_0

    .line 185
    const-string v0, "Couldn\'t start the Bluetooth server"

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/BlePeripheral;->fail(Ljava/lang/String;)V

    return-void

    .line 188
    :cond_0
    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->server:Landroid/bluetooth/BluetoothGattServer;

    .line 190
    new-instance v2, Landroid/bluetooth/BluetoothGattCharacteristic;

    sget-object v3, Lcom/cloudpad/controller/Protocol;->INPUT_UUID:Ljava/util/UUID;

    const/16 v4, 0x12

    const/4 v5, 0x1

    invoke-direct {v2, v3, v4, v5}, Landroid/bluetooth/BluetoothGattCharacteristic;-><init>(Ljava/util/UUID;II)V

    iput-object v2, p0, Lcom/cloudpad/controller/BlePeripheral;->input:Landroid/bluetooth/BluetoothGattCharacteristic;

    .line 193
    new-instance v3, Landroid/bluetooth/BluetoothGattDescriptor;

    sget-object v4, Lcom/cloudpad/controller/Protocol;->CCCD_UUID:Ljava/util/UUID;

    const/16 v5, 0x11

    invoke-direct {v3, v4, v5}, Landroid/bluetooth/BluetoothGattDescriptor;-><init>(Ljava/util/UUID;I)V

    invoke-virtual {v2, v3}, Landroid/bluetooth/BluetoothGattCharacteristic;->addDescriptor(Landroid/bluetooth/BluetoothGattDescriptor;)Z

    .line 195
    new-instance v2, Landroid/bluetooth/BluetoothGattCharacteristic;

    sget-object v3, Lcom/cloudpad/controller/Protocol;->OUTPUT_UUID:Ljava/util/UUID;

    const/16 v4, 0xc

    const/16 v5, 0x10

    invoke-direct {v2, v3, v4, v5}, Landroid/bluetooth/BluetoothGattCharacteristic;-><init>(Ljava/util/UUID;II)V

    .line 198
    new-instance v3, Landroid/bluetooth/BluetoothGattService;

    sget-object v4, Lcom/cloudpad/controller/Protocol;->SERVICE_UUID:Ljava/util/UUID;

    invoke-direct {v3, v4, v1}, Landroid/bluetooth/BluetoothGattService;-><init>(Ljava/util/UUID;I)V

    .line 200
    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral;->input:Landroid/bluetooth/BluetoothGattCharacteristic;

    invoke-virtual {v3, v1}, Landroid/bluetooth/BluetoothGattService;->addCharacteristic(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    .line 201
    invoke-virtual {v3, v2}, Landroid/bluetooth/BluetoothGattService;->addCharacteristic(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    .line 202
    invoke-virtual {v0, v3}, Landroid/bluetooth/BluetoothGattServer;->addService(Landroid/bluetooth/BluetoothGattService;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 203
    const-string v0, "Couldn\'t register the controller service"

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/BlePeripheral;->fail(Ljava/lang/String;)V

    return-void

    .line 206
    :cond_1
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral;->tick:Ljava/lang/Runnable;

    const-wide/16 v2, 0x32

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void

    .line 181
    :catch_0
    const-string v0, "Bluetooth permission is missing"

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/BlePeripheral;->fail(Ljava/lang/String;)V

    return-void
.end method

.method private pump()V
    .locals 11

    .line 410
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->server:Landroid/bluetooth/BluetoothGattServer;

    if-eqz v0, :cond_a

    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    if-eqz v0, :cond_0

    goto/16 :goto_2

    .line 411
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    .line 412
    iget-object v2, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_a

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/cloudpad/controller/BlePeripheral$Central;

    .line 413
    iget-boolean v4, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->subscribed:Z

    if-nez v4, :cond_2

    goto :goto_0

    .line 414
    :cond_2
    iget-boolean v4, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->inFlight:Z

    const/4 v5, 0x0

    if-eqz v4, :cond_4

    .line 415
    iget-wide v6, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->inFlightSince:J

    sub-long v6, v0, v6

    const-wide/16 v8, 0xc8

    cmp-long v4, v6, v8

    if-gez v4, :cond_3

    goto :goto_0

    .line 416
    :cond_3
    iput-boolean v5, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->inFlight:Z

    .line 418
    :cond_4
    iget-object v4, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->pendingPong:[B

    const/4 v6, 0x1

    if-eqz v4, :cond_5

    move v5, v6

    :cond_5
    if-eqz v5, :cond_6

    .line 421
    iget-object v4, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->pendingPong:[B

    goto :goto_1

    .line 422
    :cond_6
    iget v4, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->sentVersion:I

    iget v7, p0, Lcom/cloudpad/controller/BlePeripheral;->stateVersion:I

    if-ne v4, v7, :cond_7

    iget-wide v7, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->lastSend:J

    sub-long v7, v0, v7

    const-wide/16 v9, 0xfa

    cmp-long v4, v7, v9

    if-ltz v4, :cond_1

    .line 423
    :cond_7
    iget-object v4, p0, Lcom/cloudpad/controller/BlePeripheral;->state:[B

    .line 427
    :goto_1
    iget-object v7, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->device:Landroid/bluetooth/BluetoothDevice;

    invoke-direct {p0, v7, v4}, Lcom/cloudpad/controller/BlePeripheral;->notify(Landroid/bluetooth/BluetoothDevice;[B)Z

    move-result v4

    if-nez v4, :cond_8

    .line 428
    iget-boolean v3, p0, Lcom/cloudpad/controller/BlePeripheral;->retryPending:Z

    if-nez v3, :cond_1

    .line 429
    iput-boolean v6, p0, Lcom/cloudpad/controller/BlePeripheral;->retryPending:Z

    .line 430
    iget-object v3, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    iget-object v4, p0, Lcom/cloudpad/controller/BlePeripheral;->retry:Ljava/lang/Runnable;

    const-wide/16 v5, 0x8

    invoke-virtual {v3, v4, v5, v6}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    .line 434
    :cond_8
    iput-boolean v6, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->inFlight:Z

    .line 435
    iput-wide v0, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->inFlightSince:J

    .line 436
    iput-wide v0, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->lastSend:J

    if-eqz v5, :cond_9

    const/4 v4, 0x0

    .line 438
    iput-object v4, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->pendingPong:[B

    goto :goto_0

    .line 440
    :cond_9
    iget v4, p0, Lcom/cloudpad/controller/BlePeripheral;->stateVersion:I

    iput v4, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->sentVersion:I

    goto :goto_0

    :cond_a
    :goto_2
    return-void
.end method

.method private static releaseCentral(Lcom/cloudpad/controller/BlePeripheral$Central;)V
    .locals 1

    .line 379
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$Central;->priorityGatt:Landroid/bluetooth/BluetoothGatt;

    if-eqz v0, :cond_0

    .line 381
    :try_start_0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$Central;->priorityGatt:Landroid/bluetooth/BluetoothGatt;

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothGatt;->close()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    .line 384
    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$Central;->priorityGatt:Landroid/bluetooth/BluetoothGatt;

    :cond_0
    return-void
.end method

.method private report(ILjava/lang/String;)V
    .locals 2

    .line 475
    iget v0, p0, Lcom/cloudpad/controller/BlePeripheral;->reportedState:I

    if-ne p1, v0, :cond_0

    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->reportedDetail:Ljava/lang/String;

    invoke-static {p2, v0}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 476
    :cond_0
    iput p1, p0, Lcom/cloudpad/controller/BlePeripheral;->reportedState:I

    .line 477
    iput-object p2, p0, Lcom/cloudpad/controller/BlePeripheral;->reportedDetail:Ljava/lang/String;

    .line 478
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->main:Landroid/os/Handler;

    new-instance v1, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0, p1, p2}, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda6;-><init>(Lcom/cloudpad/controller/BlePeripheral;ILjava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private reportCurrent()V
    .locals 3

    .line 464
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    if-nez v0, :cond_4

    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->failed:Z

    if-eqz v0, :cond_0

    goto :goto_1

    .line 465
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cloudpad/controller/BlePeripheral$Central;

    .line 466
    iget-boolean v2, v1, Lcom/cloudpad/controller/BlePeripheral$Central;->subscribed:Z

    if-eqz v2, :cond_1

    .line 467
    iget-object v0, v1, Lcom/cloudpad/controller/BlePeripheral$Central;->device:Landroid/bluetooth/BluetoothDevice;

    invoke-static {v0}, Lcom/cloudpad/controller/BlePeripheral;->deviceName(Landroid/bluetooth/BluetoothDevice;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x2

    invoke-direct {p0, v1, v0}, Lcom/cloudpad/controller/BlePeripheral;->report(ILjava/lang/String;)V

    return-void

    .line 471
    :cond_2
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->advertising:Z

    if-eqz v0, :cond_3

    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->adapterName()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_3
    const/4 v1, 0x0

    :goto_0
    invoke-direct {p0, v0, v1}, Lcom/cloudpad/controller/BlePeripheral;->report(ILjava/lang/String;)V

    :cond_4
    :goto_1
    return-void
.end method

.method private requestLowLatency(Lcom/cloudpad/controller/BlePeripheral$Central;)V
    .locals 5

    .line 355
    iget-object v0, p1, Lcom/cloudpad/controller/BlePeripheral$Central;->priorityGatt:Landroid/bluetooth/BluetoothGatt;

    if-eqz v0, :cond_0

    return-void

    .line 357
    :cond_0
    :try_start_0
    iget-object v0, p1, Lcom/cloudpad/controller/BlePeripheral$Central;->device:Landroid/bluetooth/BluetoothDevice;

    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral;->context:Landroid/content/Context;

    new-instance v2, Lcom/cloudpad/controller/BlePeripheral$1;

    invoke-direct {v2, p0, p1}, Lcom/cloudpad/controller/BlePeripheral$1;-><init>(Lcom/cloudpad/controller/BlePeripheral;Lcom/cloudpad/controller/BlePeripheral$Central;)V

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v4, v2, v3}, Landroid/bluetooth/BluetoothDevice;->connectGatt(Landroid/content/Context;ZLandroid/bluetooth/BluetoothGattCallback;I)Landroid/bluetooth/BluetoothGatt;

    move-result-object v0

    iput-object v0, p1, Lcom/cloudpad/controller/BlePeripheral$Central;->priorityGatt:Landroid/bluetooth/BluetoothGatt;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 374
    const-string v0, "CloudPad"

    const-string v1, "Couldn\'t request a low-latency connection"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method

.method private respond(Landroid/bluetooth/BluetoothDevice;II[B)V
    .locals 7

    .line 603
    array-length v0, p4

    if-le p3, v0, :cond_0

    const/4 v4, 0x7

    const/4 v6, 0x0

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v5, p3

    .line 604
    invoke-direct/range {v1 .. v6}, Lcom/cloudpad/controller/BlePeripheral;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)V

    goto :goto_0

    .line 606
    :cond_0
    array-length v0, p4

    .line 607
    invoke-static {p4, p3, v0}, Ljava/util/Arrays;->copyOfRange([BII)[B

    move-result-object v6

    const/4 v4, 0x0

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v5, p3

    .line 606
    invoke-direct/range {v1 .. v6}, Lcom/cloudpad/controller/BlePeripheral;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)V

    :goto_0
    return-void
.end method

.method private restartAdvertising()V
    .locals 1

    .line 255
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->failed:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->advertiser:Landroid/bluetooth/le/BluetoothLeAdvertiser;

    if-nez v0, :cond_0

    goto :goto_0

    .line 256
    :cond_0
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->stopAdvertising()V

    .line 257
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->startAdvertising()V

    :cond_1
    :goto_0
    return-void
.end method

.method private sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)V
    .locals 6

    .line 612
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->server:Landroid/bluetooth/BluetoothGattServer;

    if-nez v0, :cond_0

    return-void

    :cond_0
    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move-object v5, p5

    .line 615
    :try_start_0
    invoke-virtual/range {v0 .. v5}, Landroid/bluetooth/BluetoothGattServer;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 617
    const-string p2, "CloudPad"

    const-string p3, "sendResponse failed"

    invoke-static {p2, p3, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method

.method private startAdvertising()V
    .locals 5

    .line 211
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    if-eqz v0, :cond_0

    return-void

    .line 212
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->advertiser:Landroid/bluetooth/le/BluetoothLeAdvertiser;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->adapter:Landroid/bluetooth/BluetoothAdapter;

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getBluetoothLeAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;

    move-result-object v0

    iput-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->advertiser:Landroid/bluetooth/le/BluetoothLeAdvertiser;

    .line 213
    :cond_1
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->advertiser:Landroid/bluetooth/le/BluetoothLeAdvertiser;

    if-nez v0, :cond_2

    .line 214
    const-string v0, "This phone can\'t act as a Bluetooth LE peripheral"

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/BlePeripheral;->fail(Ljava/lang/String;)V

    return-void

    .line 217
    :cond_2
    new-instance v0, Landroid/bluetooth/le/AdvertiseSettings$Builder;

    invoke-direct {v0}, Landroid/bluetooth/le/AdvertiseSettings$Builder;-><init>()V

    const/4 v1, 0x2

    .line 218
    invoke-virtual {v0, v1}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setAdvertiseMode(I)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v0

    const/4 v1, 0x3

    .line 219
    invoke-virtual {v0, v1}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setTxPowerLevel(I)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 220
    invoke-virtual {v0, v1}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setConnectable(Z)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v0

    const/4 v1, 0x0

    .line 221
    invoke-virtual {v0, v1}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setTimeout(I)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v0

    .line 222
    invoke-virtual {v0}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->build()Landroid/bluetooth/le/AdvertiseSettings;

    move-result-object v0

    .line 223
    new-instance v2, Landroid/bluetooth/le/AdvertiseData$Builder;

    invoke-direct {v2}, Landroid/bluetooth/le/AdvertiseData$Builder;-><init>()V

    new-instance v3, Landroid/os/ParcelUuid;

    sget-object v4, Lcom/cloudpad/controller/Protocol;->SERVICE_UUID:Ljava/util/UUID;

    invoke-direct {v3, v4}, Landroid/os/ParcelUuid;-><init>(Ljava/util/UUID;)V

    .line 224
    invoke-virtual {v2, v3}, Landroid/bluetooth/le/AdvertiseData$Builder;->addServiceUuid(Landroid/os/ParcelUuid;)Landroid/bluetooth/le/AdvertiseData$Builder;

    move-result-object v2

    .line 225
    invoke-virtual {v2, v1}, Landroid/bluetooth/le/AdvertiseData$Builder;->setIncludeDeviceName(Z)Landroid/bluetooth/le/AdvertiseData$Builder;

    move-result-object v2

    .line 226
    invoke-virtual {v2, v1}, Landroid/bluetooth/le/AdvertiseData$Builder;->setIncludeTxPowerLevel(Z)Landroid/bluetooth/le/AdvertiseData$Builder;

    move-result-object v2

    .line 227
    invoke-virtual {v2}, Landroid/bluetooth/le/AdvertiseData$Builder;->build()Landroid/bluetooth/le/AdvertiseData;

    move-result-object v2

    .line 229
    new-instance v3, Landroid/bluetooth/le/AdvertiseData$Builder;

    invoke-direct {v3}, Landroid/bluetooth/le/AdvertiseData$Builder;-><init>()V

    iget-boolean v4, p0, Lcom/cloudpad/controller/BlePeripheral;->includeName:Z

    .line 230
    invoke-virtual {v3, v4}, Landroid/bluetooth/le/AdvertiseData$Builder;->setIncludeDeviceName(Z)Landroid/bluetooth/le/AdvertiseData$Builder;

    move-result-object v3

    .line 231
    invoke-virtual {v3, v1}, Landroid/bluetooth/le/AdvertiseData$Builder;->setIncludeTxPowerLevel(Z)Landroid/bluetooth/le/AdvertiseData$Builder;

    move-result-object v1

    .line 232
    invoke-virtual {v1}, Landroid/bluetooth/le/AdvertiseData$Builder;->build()Landroid/bluetooth/le/AdvertiseData;

    move-result-object v1

    .line 234
    :try_start_0
    iget-object v3, p0, Lcom/cloudpad/controller/BlePeripheral;->advertiser:Landroid/bluetooth/le/BluetoothLeAdvertiser;

    iget-object v4, p0, Lcom/cloudpad/controller/BlePeripheral;->advertiseCallback:Landroid/bluetooth/le/AdvertiseCallback;

    invoke-virtual {v3, v0, v2, v1, v4}, Landroid/bluetooth/le/BluetoothLeAdvertiser;->startAdvertising(Landroid/bluetooth/le/AdvertiseSettings;Landroid/bluetooth/le/AdvertiseData;Landroid/bluetooth/le/AdvertiseData;Landroid/bluetooth/le/AdvertiseCallback;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 236
    :catch_0
    const-string v0, "Couldn\'t start Bluetooth advertising"

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/BlePeripheral;->fail(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method private stopAdvertising()V
    .locals 2

    .line 241
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->advertiser:Landroid/bluetooth/le/BluetoothLeAdvertiser;

    if-eqz v0, :cond_0

    .line 243
    :try_start_0
    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral;->advertiseCallback:Landroid/bluetooth/le/AdvertiseCallback;

    invoke-virtual {v0, v1}, Landroid/bluetooth/le/BluetoothLeAdvertiser;->stopAdvertising(Landroid/bluetooth/le/AdvertiseCallback;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    .line 247
    iput-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->advertising:Z

    return-void
.end method


# virtual methods
.method synthetic lambda$new$5$com-cloudpad-controller-BlePeripheral()V
    .locals 1

    .line 0
    const/4 v0, 0x0

    .line 400
    iput-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->retryPending:Z

    .line 401
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->pump()V

    return-void
.end method

.method synthetic lambda$onConnectionChanged$3$com-cloudpad-controller-BlePeripheral(Ljava/lang/String;Lcom/cloudpad/controller/BlePeripheral$Central;)V
    .locals 1

    .line 307
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->lowLatency:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, p2, :cond_0

    invoke-direct {p0, p2}, Lcom/cloudpad/controller/BlePeripheral;->requestLowLatency(Lcom/cloudpad/controller/BlePeripheral$Central;)V

    :cond_0
    return-void
.end method

.method synthetic lambda$onOutput$4$com-cloudpad-controller-BlePeripheral([I)V
    .locals 4

    .line 337
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->released:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->listener:Lcom/cloudpad/controller/BlePeripheral$Listener;

    const/4 v1, 0x0

    aget v1, p1, v1

    const/4 v2, 0x1

    aget v2, p1, v2

    const/4 v3, 0x2

    aget p1, p1, v3

    invoke-interface {v0, v1, v2, p1}, Lcom/cloudpad/controller/BlePeripheral$Listener;->onRumble(III)V

    :cond_0
    return-void
.end method

.method synthetic lambda$report$6$com-cloudpad-controller-BlePeripheral(ILjava/lang/String;)V
    .locals 1

    .line 479
    iget-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->released:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->listener:Lcom/cloudpad/controller/BlePeripheral$Listener;

    invoke-interface {v0, p1, p2}, Lcom/cloudpad/controller/BlePeripheral$Listener;->onPeripheralState(ILjava/lang/String;)V

    :cond_0
    return-void
.end method

.method synthetic lambda$setLowLatency$1$com-cloudpad-controller-BlePeripheral(Z)V
    .locals 1

    .line 137
    iput-boolean p1, p0, Lcom/cloudpad/controller/BlePeripheral;->lowLatency:Z

    if-eqz p1, :cond_0

    .line 139
    iget-object p1, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {p1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cloudpad/controller/BlePeripheral$Central;

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/BlePeripheral;->requestLowLatency(Lcom/cloudpad/controller/BlePeripheral$Central;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method synthetic lambda$stop$2$com-cloudpad-controller-BlePeripheral()V
    .locals 4

    .line 0
    const/4 v0, 0x1

    .line 147
    iput-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->stopped:Z

    .line 148
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 149
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->stopAdvertising()V

    .line 150
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->server:Landroid/bluetooth/BluetoothGattServer;

    .line 151
    iget-object v2, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :catch_0
    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/cloudpad/controller/BlePeripheral$Central;

    .line 152
    invoke-static {v3}, Lcom/cloudpad/controller/BlePeripheral;->releaseCentral(Lcom/cloudpad/controller/BlePeripheral$Central;)V

    if-eqz v0, :cond_0

    .line 155
    :try_start_0
    iget-object v3, v3, Lcom/cloudpad/controller/BlePeripheral$Central;->device:Landroid/bluetooth/BluetoothDevice;

    invoke-virtual {v0, v3}, Landroid/bluetooth/BluetoothGattServer;->cancelConnection(Landroid/bluetooth/BluetoothDevice;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 160
    :cond_1
    iget-object v2, p0, Lcom/cloudpad/controller/BlePeripheral;->centrals:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->clear()V

    if-eqz v0, :cond_2

    .line 163
    :try_start_1
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothGattServer;->clearServices()V

    .line 164
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothGattServer;->close()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    .line 167
    :catch_1
    iput-object v1, p0, Lcom/cloudpad/controller/BlePeripheral;->server:Landroid/bluetooth/BluetoothGattServer;

    .line 169
    :cond_2
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->quitSafely()Z

    return-void
.end method

.method synthetic lambda$updateState$0$com-cloudpad-controller-BlePeripheral([B)V
    .locals 2

    .line 126
    iget v0, p0, Lcom/cloudpad/controller/BlePeripheral;->sequence:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    and-int/lit16 v0, v0, 0xff

    iput v0, p0, Lcom/cloudpad/controller/BlePeripheral;->sequence:I

    int-to-byte v0, v0

    .line 127
    aput-byte v0, p1, v1

    .line 128
    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral;->state:[B

    .line 129
    iget p1, p0, Lcom/cloudpad/controller/BlePeripheral;->stateVersion:I

    add-int/2addr p1, v1

    iput p1, p0, Lcom/cloudpad/controller/BlePeripheral;->stateVersion:I

    .line 130
    invoke-direct {p0}, Lcom/cloudpad/controller/BlePeripheral;->pump()V

    return-void
.end method

.method setLowLatency(Z)V
    .locals 2

    .line 136
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    new-instance v1, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda0;-><init>(Lcom/cloudpad/controller/BlePeripheral;Z)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method start()V
    .locals 2

    .line 119
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    new-instance v1, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda5;

    invoke-direct {v1, p0}, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda5;-><init>(Lcom/cloudpad/controller/BlePeripheral;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method stop()V
    .locals 2

    const/4 v0, 0x1

    .line 145
    iput-boolean v0, p0, Lcom/cloudpad/controller/BlePeripheral;->released:Z

    .line 146
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    new-instance v1, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda2;-><init>(Lcom/cloudpad/controller/BlePeripheral;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method updateState(Lcom/cloudpad/controller/GamepadState;)V
    .locals 2

    const/4 v0, 0x0

    .line 124
    invoke-static {p1, v0}, Lcom/cloudpad/controller/Protocol;->encodeState(Lcom/cloudpad/controller/GamepadState;I)[B

    move-result-object p1

    .line 125
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral;->handler:Landroid/os/Handler;

    new-instance v1, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0, p1}, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda7;-><init>(Lcom/cloudpad/controller/BlePeripheral;[B)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
