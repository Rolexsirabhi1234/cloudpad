.class final Lcom/cloudpad/controller/UsbLink;
.super Ljava/lang/Object;
.source "UsbLink.java"

# interfaces
.implements Ljava/lang/Runnable;

# Controller link over the USB-tethering network (UDP port 47123).
# The laptop sends "CPH1" hellos; the phone answers with "CPN1"+name and its latest state,
# then streams state packets (same 15-byte format as Bluetooth). Rumble comes back as [1,a,b,lo,hi].


# static fields
.field static current:Lcom/cloudpad/controller/UsbLink;


# instance fields
.field final act:Lcom/cloudpad/controller/MainActivity;

.field final view:Lcom/cloudpad/controller/GamepadView;

.field final main:Landroid/os/Handler;

.field final tx:Landroid/os/Handler;

.field final txThread:Landroid/os/HandlerThread;

.field final nameBytes:[B

.field volatile socket:Ljava/net/DatagramSocket;

.field volatile peer:Ljava/net/SocketAddress;

.field volatile lastHello:J

.field volatile running:Z

.field volatile last:[B

.field linked:Z

.field seq:I


# direct methods
.method constructor <init>(Lcom/cloudpad/controller/MainActivity;Lcom/cloudpad/controller/GamepadView;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/UsbLink;->act:Lcom/cloudpad/controller/MainActivity;

    iput-object p2, p0, Lcom/cloudpad/controller/UsbLink;->view:Lcom/cloudpad/controller/GamepadView;

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/cloudpad/controller/UsbLink;->main:Landroid/os/Handler;

    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "CloudPad-USB-tx"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    iput-object v0, p0, Lcom/cloudpad/controller/UsbLink;->txThread:Landroid/os/HandlerThread;

    new-instance v1, Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Lcom/cloudpad/controller/UsbLink;->tx:Landroid/os/Handler;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cloudpad/controller/UsbLink;->running:Z

    invoke-static {}, Lcom/cloudpad/controller/UsbLink;->phoneName()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "CPN1"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    iput-object v0, p0, Lcom/cloudpad/controller/UsbLink;->nameBytes:[B

    return-void
.end method

.method static phoneName()Ljava/lang/String;
    .locals 1

    :try_start_0
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-eqz v0, :fallback

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getName()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :fallback

    return-object v0

    :catch_0
    goto :fallback

    :fallback
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    return-object v0
.end method

.method static start(Lcom/cloudpad/controller/MainActivity;Lcom/cloudpad/controller/GamepadView;)V
    .locals 2

    sget-object v0, Lcom/cloudpad/controller/UsbLink;->current:Lcom/cloudpad/controller/UsbLink;

    if-nez v0, :done

    new-instance v0, Lcom/cloudpad/controller/UsbLink;

    invoke-direct {v0, p0, p1}, Lcom/cloudpad/controller/UsbLink;-><init>(Lcom/cloudpad/controller/MainActivity;Lcom/cloudpad/controller/GamepadView;)V

    sput-object v0, Lcom/cloudpad/controller/UsbLink;->current:Lcom/cloudpad/controller/UsbLink;

    new-instance v1, Ljava/lang/Thread;

    invoke-direct {v1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    :done
    return-void
.end method

.method static stop()V
    .locals 2

    sget-object v0, Lcom/cloudpad/controller/UsbLink;->current:Lcom/cloudpad/controller/UsbLink;

    if-eqz v0, :done

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/cloudpad/controller/UsbLink;->running:Z

    const/4 v1, 0x0

    sput-object v1, Lcom/cloudpad/controller/UsbLink;->current:Lcom/cloudpad/controller/UsbLink;

    iget-object v1, v0, Lcom/cloudpad/controller/UsbLink;->socket:Ljava/net/DatagramSocket;

    if-eqz v1, :nosock

    invoke-virtual {v1}, Ljava/net/DatagramSocket;->close()V

    :nosock
    iget-object v1, v0, Lcom/cloudpad/controller/UsbLink;->txThread:Landroid/os/HandlerThread;

    invoke-virtual {v1}, Landroid/os/HandlerThread;->quitSafely()Z

    :done
    return-void
.end method

.method static state(Lcom/cloudpad/controller/GamepadState;)V
    .locals 1

    sget-object v0, Lcom/cloudpad/controller/UsbLink;->current:Lcom/cloudpad/controller/UsbLink;

    if-eqz v0, :done

    invoke-virtual {v0, p0}, Lcom/cloudpad/controller/UsbLink;->send(Lcom/cloudpad/controller/GamepadState;)V

    :done
    return-void
.end method


# virtual methods
.method send(Lcom/cloudpad/controller/GamepadState;)V
    .locals 4

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/cloudpad/controller/Protocol;->encodeState(Lcom/cloudpad/controller/GamepadState;I)[B

    move-result-object v0

    iget v1, p0, Lcom/cloudpad/controller/UsbLink;->seq:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/cloudpad/controller/UsbLink;->seq:I

    int-to-byte v1, v1

    const/4 v2, 0x1

    aput-byte v1, v0, v2

    iput-object v0, p0, Lcom/cloudpad/controller/UsbLink;->last:[B

    iget-object v1, p0, Lcom/cloudpad/controller/UsbLink;->peer:Ljava/net/SocketAddress;

    if-eqz v1, :done

    new-instance v2, Lcom/cloudpad/controller/UsbLink$Tx;

    invoke-direct {v2, p0, v0}, Lcom/cloudpad/controller/UsbLink$Tx;-><init>(Lcom/cloudpad/controller/UsbLink;[B)V

    iget-object v3, p0, Lcom/cloudpad/controller/UsbLink;->tx:Landroid/os/Handler;

    invoke-virtual {v3, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :done
    return-void
.end method

.method sendNow([B)V
    .locals 4

    iget-object v0, p0, Lcom/cloudpad/controller/UsbLink;->socket:Ljava/net/DatagramSocket;

    iget-object v1, p0, Lcom/cloudpad/controller/UsbLink;->peer:Ljava/net/SocketAddress;

    if-eqz v0, :done

    if-eqz v1, :done

    :try_start_0
    new-instance v2, Ljava/net/DatagramPacket;

    array-length v3, p1

    invoke-direct {v2, p1, v3, v1}, Ljava/net/DatagramPacket;-><init>([BILjava/net/SocketAddress;)V

    invoke-virtual {v0, v2}, Ljava/net/DatagramSocket;->send(Ljava/net/DatagramPacket;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :done
    return-void

    :catch_0
    return-void
.end method

.method public run()V
    .locals 4

    :try_start_0
    new-instance v0, Ljava/net/DatagramSocket;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/net/DatagramSocket;-><init>(Ljava/net/SocketAddress;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/net/DatagramSocket;->setReuseAddress(Z)V

    new-instance v1, Ljava/net/InetSocketAddress;

    const v2, 0xb813

    invoke-direct {v1, v2}, Ljava/net/InetSocketAddress;-><init>(I)V

    invoke-virtual {v0, v1}, Ljava/net/DatagramSocket;->bind(Ljava/net/SocketAddress;)V

    const/16 v1, 0x3e8

    invoke-virtual {v0, v1}, Ljava/net/DatagramSocket;->setSoTimeout(I)V

    iput-object v0, p0, Lcom/cloudpad/controller/UsbLink;->socket:Ljava/net/DatagramSocket;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :bind_failed

    const/16 v1, 0x40

    new-array v1, v1, [B

    :loop
    iget-boolean v2, p0, Lcom/cloudpad/controller/UsbLink;->running:Z

    if-eqz v2, :exit

    new-instance v2, Ljava/net/DatagramPacket;

    array-length v3, v1

    invoke-direct {v2, v1, v3}, Ljava/net/DatagramPacket;-><init>([BI)V

    :try_start_1
    invoke-virtual {v0, v2}, Ljava/net/DatagramSocket;->receive(Ljava/net/DatagramPacket;)V

    invoke-virtual {p0, v2, v1}, Lcom/cloudpad/controller/UsbLink;->handle(Ljava/net/DatagramPacket;[B)V
    :try_end_1
    .catch Ljava/net/SocketTimeoutException; {:try_start_1 .. :try_end_1} :timeout
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :failed

    :timeout
    invoke-virtual {p0}, Lcom/cloudpad/controller/UsbLink;->checkTimeout()V

    goto :loop

    :failed
    iget-boolean v2, p0, Lcom/cloudpad/controller/UsbLink;->running:Z

    if-nez v2, :timeout

    :exit
    invoke-virtual {v0}, Ljava/net/DatagramSocket;->close()V

    return-void

    :bind_failed
    return-void
.end method

.method handle(Ljava/net/DatagramPacket;[B)V
    .locals 6

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getLength()I

    move-result v0

    const/4 v1, 0x4

    if-lt v0, v1, :not_hello

    const/4 v1, 0x0

    aget-byte v1, p2, v1

    const/16 v2, 0x43

    if-ne v1, v2, :not_hello

    const/4 v1, 0x1

    aget-byte v1, p2, v1

    const/16 v2, 0x50

    if-ne v1, v2, :not_hello

    const/4 v1, 0x2

    aget-byte v1, p2, v1

    const/16 v2, 0x48

    if-ne v1, v2, :not_hello

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getSocketAddress()Ljava/net/SocketAddress;

    move-result-object v1

    iput-object v1, p0, Lcom/cloudpad/controller/UsbLink;->peer:Ljava/net/SocketAddress;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/cloudpad/controller/UsbLink;->lastHello:J

    iget-object v2, p0, Lcom/cloudpad/controller/UsbLink;->nameBytes:[B

    invoke-virtual {p0, v2}, Lcom/cloudpad/controller/UsbLink;->sendNow([B)V

    iget-object v2, p0, Lcom/cloudpad/controller/UsbLink;->last:[B

    if-eqz v2, :no_last

    invoke-virtual {p0, v2}, Lcom/cloudpad/controller/UsbLink;->sendNow([B)V

    :no_last
    iget-boolean v2, p0, Lcom/cloudpad/controller/UsbLink;->linked:Z

    if-nez v2, :ret

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/cloudpad/controller/UsbLink;->linked:Z

    invoke-virtual {p0, v2}, Lcom/cloudpad/controller/UsbLink;->postUi(Z)V

    :ret
    return-void

    :not_hello
    const/4 v1, 0x5

    if-lt v0, v1, :ret2

    invoke-static {p2, v0}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v1

    invoke-static {v1}, Lcom/cloudpad/controller/Protocol;->parseRumble([B)[I

    move-result-object v1

    if-eqz v1, :ret2

    new-instance v2, Lcom/cloudpad/controller/UsbLink$Rumble;

    iget-object v3, p0, Lcom/cloudpad/controller/UsbLink;->act:Lcom/cloudpad/controller/MainActivity;

    invoke-direct {v2, v3, v1}, Lcom/cloudpad/controller/UsbLink$Rumble;-><init>(Lcom/cloudpad/controller/MainActivity;[I)V

    iget-object v3, p0, Lcom/cloudpad/controller/UsbLink;->main:Landroid/os/Handler;

    invoke-virtual {v3, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :ret2
    return-void
.end method

.method checkTimeout()V
    .locals 4

    iget-boolean v0, p0, Lcom/cloudpad/controller/UsbLink;->linked:Z

    if-eqz v0, :ret

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/cloudpad/controller/UsbLink;->lastHello:J

    sub-long/2addr v0, v2

    const-wide/16 v2, 0xbb8

    cmp-long v0, v0, v2

    if-lez v0, :ret

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cloudpad/controller/UsbLink;->linked:Z

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/cloudpad/controller/UsbLink;->peer:Ljava/net/SocketAddress;

    invoke-virtual {p0, v0}, Lcom/cloudpad/controller/UsbLink;->postUi(Z)V

    :ret
    return-void
.end method

.method postUi(Z)V
    .locals 2

    new-instance v0, Lcom/cloudpad/controller/UsbLink$Ui;

    invoke-direct {v0, p0, p1}, Lcom/cloudpad/controller/UsbLink$Ui;-><init>(Lcom/cloudpad/controller/UsbLink;Z)V

    iget-object v1, p0, Lcom/cloudpad/controller/UsbLink;->main:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
