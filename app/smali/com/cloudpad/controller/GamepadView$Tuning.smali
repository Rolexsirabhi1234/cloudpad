.class final Lcom/cloudpad/controller/GamepadView$Tuning;
.super Ljava/lang/Object;
.source "GamepadView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cloudpad/controller/GamepadView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Tuning"
.end annotation


# instance fields
.field analogPedals:Z

.field floatingSticks:Z

.field pedalDeadzone:F

.field pedalFullAt:F

.field stickDeadzone:F

.field stickOuterDeadzone:F


# direct methods
.method constructor <init>()V
    .locals 2

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    .line 50
    iput-boolean v0, p0, Lcom/cloudpad/controller/GamepadView$Tuning;->floatingSticks:Z

    const v1, 0x3d4ccccd    # 0.05f

    .line 51
    iput v1, p0, Lcom/cloudpad/controller/GamepadView$Tuning;->stickDeadzone:F

    .line 52
    iput v1, p0, Lcom/cloudpad/controller/GamepadView$Tuning;->stickOuterDeadzone:F

    .line 53
    iput-boolean v0, p0, Lcom/cloudpad/controller/GamepadView$Tuning;->analogPedals:Z

    .line 54
    iput v1, p0, Lcom/cloudpad/controller/GamepadView$Tuning;->pedalDeadzone:F

    const v0, 0x3f666666    # 0.9f

    .line 55
    iput v0, p0, Lcom/cloudpad/controller/GamepadView$Tuning;->pedalFullAt:F

    return-void
.end method
