.class final Lcom/cloudpad/controller/TiltSteering;
.super Ljava/lang/Object;
.source "TiltSteering.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cloudpad/controller/TiltSteering$Listener;
    }
.end annotation


# static fields
.field private static final ROTATION_CHECK_NS:J = 0xee6b280L

.field private static final SAMPLING_PERIOD_US:I = 0x2710


# instance fields
.field private final activity:Landroid/app/Activity;

.field private center:F

.field private deadzone:F

.field private filtered:F

.field private invert:Z

.field private final listener:Lcom/cloudpad/controller/TiltSteering$Listener;

.field private range:F

.field private final rawAccelerometer:Z

.field private rawAngle:F

.field private rotation:I

.field private rotationCheckedAt:J

.field private running:Z

.field private final sensor:Landroid/hardware/Sensor;

.field private final sensors:Landroid/hardware/SensorManager;

.field private smoothing:F


# direct methods
.method constructor <init>(Landroid/app/Activity;Lcom/cloudpad/controller/TiltSteering$Listener;)V
    .locals 3

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/high16 v0, 0x420c0000    # 35.0f

    .line 35
    iput v0, p0, Lcom/cloudpad/controller/TiltSteering;->range:F

    const/high16 v0, 0x3f800000    # 1.0f

    .line 36
    iput v0, p0, Lcom/cloudpad/controller/TiltSteering;->deadzone:F

    const/high16 v0, 0x3e800000    # 0.25f

    .line 37
    iput v0, p0, Lcom/cloudpad/controller/TiltSteering;->smoothing:F

    const/high16 v0, 0x7fc00000    # Float.NaN

    .line 42
    iput v0, p0, Lcom/cloudpad/controller/TiltSteering;->filtered:F

    const/4 v0, 0x1

    .line 44
    iput v0, p0, Lcom/cloudpad/controller/TiltSteering;->rotation:I

    .line 48
    iput-object p1, p0, Lcom/cloudpad/controller/TiltSteering;->activity:Landroid/app/Activity;

    .line 49
    iput-object p2, p0, Lcom/cloudpad/controller/TiltSteering;->listener:Lcom/cloudpad/controller/TiltSteering$Listener;

    .line 50
    const-class p2, Landroid/hardware/SensorManager;

    invoke-virtual {p1, p2}, Landroid/app/Activity;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/hardware/SensorManager;

    iput-object p1, p0, Lcom/cloudpad/controller/TiltSteering;->sensors:Landroid/hardware/SensorManager;

    const/4 p2, 0x0

    if-eqz p1, :cond_0

    const/16 v1, 0x9

    .line 51
    invoke-virtual {p1, v1}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, p2

    :goto_0
    if-nez v1, :cond_1

    move v2, v0

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    .line 52
    :goto_1
    iput-boolean v2, p0, Lcom/cloudpad/controller/TiltSteering;->rawAccelerometer:Z

    if-eqz v1, :cond_2

    move-object p2, v1

    goto :goto_2

    :cond_2
    if-eqz p1, :cond_3

    .line 54
    invoke-virtual {p1, v0}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object p2

    :cond_3
    :goto_2
    iput-object p2, p0, Lcom/cloudpad/controller/TiltSteering;->sensor:Landroid/hardware/Sensor;

    return-void
.end method

.method private displayRotation()I
    .locals 2

    .line 116
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_0

    .line 117
    iget-object v0, p0, Lcom/cloudpad/controller/TiltSteering;->activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getDisplay()Landroid/view/Display;

    move-result-object v0

    goto :goto_0

    .line 118
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/TiltSteering;->activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    :goto_0
    if-eqz v0, :cond_1

    .line 119
    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v0

    goto :goto_1

    :cond_1
    const/4 v0, 0x1

    :goto_1
    return v0
.end method


# virtual methods
.method configure(FFFZF)V
    .locals 1

    const/high16 v0, 0x40a00000    # 5.0f

    .line 63
    invoke-static {v0, p1}, Ljava/lang/Math;->max(FF)F

    move-result p1

    iput p1, p0, Lcom/cloudpad/controller/TiltSteering;->range:F

    const/high16 v0, 0x3f800000    # 1.0f

    sub-float/2addr p1, v0

    .line 64
    invoke-static {p2, p1}, Ljava/lang/Math;->min(FF)F

    move-result p1

    const/4 p2, 0x0

    invoke-static {p2, p1}, Ljava/lang/Math;->max(FF)F

    move-result p1

    iput p1, p0, Lcom/cloudpad/controller/TiltSteering;->deadzone:F

    const p1, 0x3f733333    # 0.95f

    .line 65
    invoke-static {p3, p2, p1}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result p1

    iput p1, p0, Lcom/cloudpad/controller/TiltSteering;->smoothing:F

    .line 66
    iput-boolean p4, p0, Lcom/cloudpad/controller/TiltSteering;->invert:Z

    .line 67
    iput p5, p0, Lcom/cloudpad/controller/TiltSteering;->center:F

    const/high16 p1, 0x7fc00000    # Float.NaN

    .line 68
    iput p1, p0, Lcom/cloudpad/controller/TiltSteering;->filtered:F

    return-void
.end method

.method isAvailable()Z
    .locals 1

    .line 58
    iget-object v0, p0, Lcom/cloudpad/controller/TiltSteering;->sensor:Landroid/hardware/Sensor;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0

    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 4

    .line 95
    iget-wide v0, p1, Landroid/hardware/SensorEvent;->timestamp:J

    iget-wide v2, p0, Lcom/cloudpad/controller/TiltSteering;->rotationCheckedAt:J

    sub-long/2addr v0, v2

    const-wide/32 v2, 0xee6b280

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    .line 96
    iget-wide v0, p1, Landroid/hardware/SensorEvent;->timestamp:J

    iput-wide v0, p0, Lcom/cloudpad/controller/TiltSteering;->rotationCheckedAt:J

    .line 97
    invoke-direct {p0}, Lcom/cloudpad/controller/TiltSteering;->displayRotation()I

    move-result v0

    iput v0, p0, Lcom/cloudpad/controller/TiltSteering;->rotation:I

    .line 99
    :cond_0
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v1, 0x0

    aget v0, v0, v1

    iget-object p1, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v1, 0x1

    aget p1, p1, v1

    iget v1, p0, Lcom/cloudpad/controller/TiltSteering;->rotation:I

    invoke-static {v0, p1, v1}, Lcom/cloudpad/controller/InputMath;->tiltAngle(FFI)F

    move-result p1

    .line 100
    invoke-static {p1}, Ljava/lang/Float;->isNaN(F)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    .line 101
    :cond_1
    iput p1, p0, Lcom/cloudpad/controller/TiltSteering;->rawAngle:F

    .line 102
    iget v0, p0, Lcom/cloudpad/controller/TiltSteering;->center:F

    sub-float/2addr p1, v0

    invoke-static {p1}, Lcom/cloudpad/controller/InputMath;->wrapDegrees(F)F

    move-result p1

    .line 103
    iget-boolean v0, p0, Lcom/cloudpad/controller/TiltSteering;->invert:Z

    if-eqz v0, :cond_2

    neg-float p1, p1

    .line 104
    :cond_2
    iget-boolean v0, p0, Lcom/cloudpad/controller/TiltSteering;->rawAccelerometer:Z

    if-eqz v0, :cond_3

    iget v0, p0, Lcom/cloudpad/controller/TiltSteering;->smoothing:F

    const v1, 0x3f19999a    # 0.6f

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    goto :goto_0

    :cond_3
    iget v0, p0, Lcom/cloudpad/controller/TiltSteering;->smoothing:F

    .line 105
    :goto_0
    iget v1, p0, Lcom/cloudpad/controller/TiltSteering;->filtered:F

    invoke-static {v1, p1, v0}, Lcom/cloudpad/controller/InputMath;->smooth(FFF)F

    move-result p1

    iput p1, p0, Lcom/cloudpad/controller/TiltSteering;->filtered:F

    .line 106
    iget-object v0, p0, Lcom/cloudpad/controller/TiltSteering;->listener:Lcom/cloudpad/controller/TiltSteering$Listener;

    iget v1, p0, Lcom/cloudpad/controller/TiltSteering;->deadzone:F

    iget v2, p0, Lcom/cloudpad/controller/TiltSteering;->range:F

    invoke-static {p1, v1, v2}, Lcom/cloudpad/controller/InputMath;->steering(FFF)F

    move-result p1

    iget v1, p0, Lcom/cloudpad/controller/TiltSteering;->filtered:F

    invoke-interface {v0, p1, v1}, Lcom/cloudpad/controller/TiltSteering$Listener;->onSteering(FF)V

    return-void
.end method

.method recenter()F
    .locals 2

    .line 87
    iget v0, p0, Lcom/cloudpad/controller/TiltSteering;->rawAngle:F

    iput v0, p0, Lcom/cloudpad/controller/TiltSteering;->center:F

    const/4 v0, 0x0

    .line 88
    iput v0, p0, Lcom/cloudpad/controller/TiltSteering;->filtered:F

    .line 89
    iget-object v1, p0, Lcom/cloudpad/controller/TiltSteering;->listener:Lcom/cloudpad/controller/TiltSteering$Listener;

    invoke-interface {v1, v0, v0}, Lcom/cloudpad/controller/TiltSteering$Listener;->onSteering(FF)V

    .line 90
    iget v0, p0, Lcom/cloudpad/controller/TiltSteering;->center:F

    return v0
.end method

.method start()V
    .locals 3

    .line 72
    iget-boolean v0, p0, Lcom/cloudpad/controller/TiltSteering;->running:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/cloudpad/controller/TiltSteering;->sensor:Landroid/hardware/Sensor;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x1

    .line 73
    iput-boolean v1, p0, Lcom/cloudpad/controller/TiltSteering;->running:Z

    const/high16 v1, 0x7fc00000    # Float.NaN

    .line 74
    iput v1, p0, Lcom/cloudpad/controller/TiltSteering;->filtered:F

    const-wide/16 v1, 0x0

    .line 75
    iput-wide v1, p0, Lcom/cloudpad/controller/TiltSteering;->rotationCheckedAt:J

    .line 76
    iget-object v1, p0, Lcom/cloudpad/controller/TiltSteering;->sensors:Landroid/hardware/SensorManager;

    const/16 v2, 0x2710

    invoke-virtual {v1, p0, v0, v2}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    :cond_1
    :goto_0
    return-void
.end method

.method stop()V
    .locals 1

    .line 80
    iget-boolean v0, p0, Lcom/cloudpad/controller/TiltSteering;->running:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    .line 81
    iput-boolean v0, p0, Lcom/cloudpad/controller/TiltSteering;->running:Z

    .line 82
    iget-object v0, p0, Lcom/cloudpad/controller/TiltSteering;->sensors:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    return-void
.end method
