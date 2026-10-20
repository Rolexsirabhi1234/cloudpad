.class final Lcom/cloudpad/controller/Haptics;
.super Ljava/lang/Object;
.source "Haptics.java"


# instance fields
.field private final attributes:Landroid/media/AudioAttributes;

.field private rumbleEnabled:Z

.field private rumbleUntil:J

.field private ticksEnabled:Z

.field private final vibrator:Landroid/os/Vibrator;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 3

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v1, 0xe

    .line 15
    invoke-virtual {v0, v1}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    const/4 v1, 0x4

    .line 16
    invoke-virtual {v0, v1}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 17
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    iput-object v0, p0, Lcom/cloudpad/controller/Haptics;->attributes:Landroid/media/AudioAttributes;

    const/4 v0, 0x1

    .line 18
    iput-boolean v0, p0, Lcom/cloudpad/controller/Haptics;->ticksEnabled:Z

    .line 19
    iput-boolean v0, p0, Lcom/cloudpad/controller/Haptics;->rumbleEnabled:Z

    .line 24
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    const/4 v2, 0x0

    if-lt v0, v1, :cond_1

    .line 25
    const-class v0, Landroid/os/VibratorManager;

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/os/VibratorManager;

    if-eqz p1, :cond_0

    .line 26
    invoke-virtual {p1}, Landroid/os/VibratorManager;->getDefaultVibrator()Landroid/os/Vibrator;

    move-result-object p1

    goto :goto_0

    :cond_0
    move-object p1, v2

    goto :goto_0

    .line 28
    :cond_1
    const-class v0, Landroid/os/Vibrator;

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/os/Vibrator;

    :goto_0
    if-eqz p1, :cond_2

    .line 30
    invoke-virtual {p1}, Landroid/os/Vibrator;->hasVibrator()Z

    move-result v0

    if-eqz v0, :cond_2

    move-object v2, p1

    :cond_2
    iput-object v2, p0, Lcom/cloudpad/controller/Haptics;->vibrator:Landroid/os/Vibrator;

    return-void
.end method

.method private rumbling()Z
    .locals 4

    .line 86
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/cloudpad/controller/Haptics;->rumbleUntil:J

    cmp-long v0, v0, v2

    if-gez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private vibrate(Landroid/os/VibrationEffect;)V
    .locals 2

    .line 92
    :try_start_0
    iget-object v0, p0, Lcom/cloudpad/controller/Haptics;->vibrator:Landroid/os/Vibrator;

    iget-object v1, p0, Lcom/cloudpad/controller/Haptics;->attributes:Landroid/media/AudioAttributes;

    invoke-virtual {v0, p1, v1}, Landroid/os/Vibrator;->vibrate(Landroid/os/VibrationEffect;Landroid/media/AudioAttributes;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method cancel()V
    .locals 2

    .line 81
    iget-object v0, p0, Lcom/cloudpad/controller/Haptics;->vibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/os/Vibrator;->cancel()V

    :cond_0
    const-wide/16 v0, 0x0

    .line 82
    iput-wide v0, p0, Lcom/cloudpad/controller/Haptics;->rumbleUntil:J

    return-void
.end method

.method confirm()V
    .locals 2

    .line 50
    iget-object v0, p0, Lcom/cloudpad/controller/Haptics;->vibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_2

    invoke-direct {p0}, Lcom/cloudpad/controller/Haptics;->rumbling()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 51
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_1

    const/4 v0, 0x1

    .line 52
    invoke-static {v0}, Landroid/os/VibrationEffect;->createPredefined(I)Landroid/os/VibrationEffect;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/Haptics;->vibrate(Landroid/os/VibrationEffect;)V

    goto :goto_0

    :cond_1
    const/4 v0, 0x4

    .line 54
    new-array v0, v0, [J

    fill-array-data v0, :array_0

    const/4 v1, -0x1

    invoke-static {v0, v1}, Landroid/os/VibrationEffect;->createWaveform([JI)Landroid/os/VibrationEffect;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/Haptics;->vibrate(Landroid/os/VibrationEffect;)V

    :cond_2
    :goto_0
    return-void

    nop

    :array_0
    .array-data 8
        0x0
        0x1e
        0x50
        0x1e
    .end array-data
.end method

.method rumble(III)V
    .locals 2

    .line 60
    iget-boolean v0, p0, Lcom/cloudpad/controller/Haptics;->rumbleEnabled:Z

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/cloudpad/controller/Haptics;->vibrator:Landroid/os/Vibrator;

    if-nez v0, :cond_0

    goto :goto_3

    :cond_0
    mul-int/lit8 p2, p2, 0x3

    .line 62
    div-int/lit8 p2, p2, 0x4

    invoke-static {p1, p2}, Ljava/lang/Math;->max(II)I

    move-result p1

    .line 63
    iget-object p2, p0, Lcom/cloudpad/controller/Haptics;->vibrator:Landroid/os/Vibrator;

    invoke-virtual {p2}, Landroid/os/Vibrator;->hasAmplitudeControl()Z

    move-result p2

    if-eqz p2, :cond_1

    const/16 v0, 0xc

    goto :goto_0

    :cond_1
    const/16 v0, 0x5a

    :goto_0
    if-lt p1, v0, :cond_4

    if-gtz p3, :cond_2

    goto :goto_2

    :cond_2
    if-eqz p2, :cond_3

    const/16 p2, 0xff

    .line 70
    invoke-static {p2, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    goto :goto_1

    :cond_3
    const/4 p1, -0x1

    :goto_1
    int-to-long p2, p3

    .line 71
    invoke-static {p2, p3, p1}, Landroid/os/VibrationEffect;->createOneShot(JI)Landroid/os/VibrationEffect;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/cloudpad/controller/Haptics;->vibrate(Landroid/os/VibrationEffect;)V

    .line 72
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    add-long/2addr v0, p2

    iput-wide v0, p0, Lcom/cloudpad/controller/Haptics;->rumbleUntil:J

    return-void

    .line 67
    :cond_4
    :goto_2
    invoke-virtual {p0}, Lcom/cloudpad/controller/Haptics;->stopRumble()V

    :cond_5
    :goto_3
    return-void
.end method

.method setEnabled(ZZ)V
    .locals 0

    .line 34
    iput-boolean p1, p0, Lcom/cloudpad/controller/Haptics;->ticksEnabled:Z

    .line 35
    iput-boolean p2, p0, Lcom/cloudpad/controller/Haptics;->rumbleEnabled:Z

    if-nez p2, :cond_0

    .line 36
    invoke-virtual {p0}, Lcom/cloudpad/controller/Haptics;->stopRumble()V

    :cond_0
    return-void
.end method

.method stopRumble()V
    .locals 2

    .line 76
    iget-object v0, p0, Lcom/cloudpad/controller/Haptics;->vibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/cloudpad/controller/Haptics;->rumbling()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cloudpad/controller/Haptics;->vibrator:Landroid/os/Vibrator;

    invoke-virtual {v0}, Landroid/os/Vibrator;->cancel()V

    :cond_0
    const-wide/16 v0, 0x0

    .line 77
    iput-wide v0, p0, Lcom/cloudpad/controller/Haptics;->rumbleUntil:J

    return-void
.end method

.method tick()V
    .locals 3

    .line 40
    iget-boolean v0, p0, Lcom/cloudpad/controller/Haptics;->ticksEnabled:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/cloudpad/controller/Haptics;->vibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_2

    invoke-direct {p0}, Lcom/cloudpad/controller/Haptics;->rumbling()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 41
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_1

    const/4 v0, 0x2

    .line 42
    invoke-static {v0}, Landroid/os/VibrationEffect;->createPredefined(I)Landroid/os/VibrationEffect;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/Haptics;->vibrate(Landroid/os/VibrationEffect;)V

    goto :goto_0

    :cond_1
    const-wide/16 v0, 0xc

    const/4 v2, -0x1

    .line 44
    invoke-static {v0, v1, v2}, Landroid/os/VibrationEffect;->createOneShot(JI)Landroid/os/VibrationEffect;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/cloudpad/controller/Haptics;->vibrate(Landroid/os/VibrationEffect;)V

    :cond_2
    :goto_0
    return-void
.end method
