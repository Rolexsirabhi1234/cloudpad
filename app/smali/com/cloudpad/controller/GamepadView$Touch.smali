.class final Lcom/cloudpad/controller/GamepadView$Touch;
.super Ljava/lang/Object;
.source "GamepadView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cloudpad/controller/GamepadView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Touch"
.end annotation


# instance fields
.field consumed:Z

.field control:Lcom/cloudpad/controller/Control;

.field onButtons:Z

.field onStatus:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 90
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cloudpad/controller/GamepadView$1;)V
    .locals 0

    .line 90
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView$Touch;-><init>()V

    return-void
.end method
