.class final Lcom/cloudpad/controller/AppSettings;
.super Ljava/lang/Object;
.source "AppSettings.java"


# static fields
.field static final MODE_GAMEPAD:Ljava/lang/String; = "gamepad"

.field static final MODE_RACING:Ljava/lang/String; = "racing"


# instance fields
.field private final prefs:Landroid/content/SharedPreferences;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 2

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    const-string v0, "cloudpad"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    return-void
.end method

.method private putBoolean(Ljava/lang/String;Z)V
    .locals 1

    .line 99
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method private putInt(Ljava/lang/String;I)V
    .locals 1

    .line 103
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method


# virtual methods
.method analogPedals()Z
    .locals 3

    .line 70
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "analog_pedals"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method floatingSticks()Z
    .locals 3

    .line 38
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "floating_sticks"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method haptics()Z
    .locals 3

    .line 27
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "haptics"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method layout(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .line 83
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "layout_"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v1, ""

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method lowLatency()Z
    .locals 3

    .line 33
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "low_latency"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method mode()Ljava/lang/String;
    .locals 3

    .line 18
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "mode"

    const-string v2, "gamepad"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "racing"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    move-object v2, v1

    :cond_0
    return-object v2
.end method

.method pedalDeadzone()I
    .locals 3

    .line 74
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "pedal_deadzone"

    const/4 v2, 0x5

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method pedalFullAt()I
    .locals 3

    .line 78
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "pedal_full_at"

    const/16 v2, 0x5a

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method resetLayout(Ljava/lang/String;)V
    .locals 3

    .line 85
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "layout_"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method rumble()Z
    .locals 3

    .line 30
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "rumble"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method setAnalogPedals(Z)V
    .locals 1

    .line 71
    const-string v0, "analog_pedals"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method setFloatingSticks(Z)V
    .locals 1

    .line 39
    const-string v0, "floating_sticks"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method setHaptics(Z)V
    .locals 1

    .line 28
    const-string v0, "haptics"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method setLayout(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .line 84
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "layout_"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method setLowLatency(Z)V
    .locals 1

    .line 34
    const-string v0, "low_latency"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method setMode(Ljava/lang/String;)V
    .locals 2

    .line 22
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "mode"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method setPedalDeadzone(I)V
    .locals 1

    .line 75
    const-string v0, "pedal_deadzone"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method setPedalFullAt(I)V
    .locals 1

    .line 79
    const-string v0, "pedal_full_at"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method setRumble(Z)V
    .locals 1

    .line 31
    const-string v0, "rumble"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method setSteeringCenter(F)V
    .locals 2

    .line 68
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "steering_center"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method setSteeringDeadzone(I)V
    .locals 1

    .line 57
    const-string v0, "steering_deadzone"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method setSteeringInvert(Z)V
    .locals 1

    .line 64
    const-string v0, "steering_invert"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method setSteeringRange(I)V
    .locals 1

    .line 53
    const-string v0, "steering_range"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method setSteeringSmoothing(I)V
    .locals 1

    .line 61
    const-string v0, "steering_smoothing"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method setStickDeadzone(I)V
    .locals 1

    .line 43
    const-string v0, "stick_deadzone"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method setStickOuterDeadzone(I)V
    .locals 1

    .line 47
    const-string v0, "stick_outer_deadzone"

    invoke-direct {p0, v0, p1}, Lcom/cloudpad/controller/AppSettings;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method steeringCenter()F
    .locals 3

    .line 67
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "steering_center"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v0

    return v0
.end method

.method steeringDeadzone()I
    .locals 3

    .line 56
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "steering_deadzone"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method steeringInvert()Z
    .locals 3

    .line 63
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "steering_invert"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method steeringRange()I
    .locals 3

    .line 52
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "steering_range"

    const/16 v2, 0x23

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method steeringSmoothing()I
    .locals 3

    .line 60
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "steering_smoothing"

    const/16 v2, 0x19

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method stickDeadzone()I
    .locals 3

    .line 42
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "stick_deadzone"

    const/4 v2, 0x5

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method stickOuterDeadzone()I
    .locals 3

    .line 46
    iget-object v0, p0, Lcom/cloudpad/controller/AppSettings;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "stick_outer_deadzone"

    const/4 v2, 0x5

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method tuning()Lcom/cloudpad/controller/GamepadView$Tuning;
    .locals 3

    .line 88
    new-instance v0, Lcom/cloudpad/controller/GamepadView$Tuning;

    invoke-direct {v0}, Lcom/cloudpad/controller/GamepadView$Tuning;-><init>()V

    .line 89
    invoke-virtual {p0}, Lcom/cloudpad/controller/AppSettings;->floatingSticks()Z

    move-result v1

    iput-boolean v1, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->floatingSticks:Z

    .line 90
    invoke-virtual {p0}, Lcom/cloudpad/controller/AppSettings;->stickDeadzone()I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x42c80000    # 100.0f

    div-float/2addr v1, v2

    iput v1, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->stickDeadzone:F

    .line 91
    invoke-virtual {p0}, Lcom/cloudpad/controller/AppSettings;->stickOuterDeadzone()I

    move-result v1

    int-to-float v1, v1

    div-float/2addr v1, v2

    iput v1, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->stickOuterDeadzone:F

    .line 92
    invoke-virtual {p0}, Lcom/cloudpad/controller/AppSettings;->analogPedals()Z

    move-result v1

    iput-boolean v1, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->analogPedals:Z

    .line 93
    invoke-virtual {p0}, Lcom/cloudpad/controller/AppSettings;->pedalDeadzone()I

    move-result v1

    int-to-float v1, v1

    div-float/2addr v1, v2

    iput v1, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->pedalDeadzone:F

    .line 94
    invoke-virtual {p0}, Lcom/cloudpad/controller/AppSettings;->pedalFullAt()I

    move-result v1

    int-to-float v1, v1

    div-float/2addr v1, v2

    iput v1, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->pedalFullAt:F

    return-object v0
.end method
