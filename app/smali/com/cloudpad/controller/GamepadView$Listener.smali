.class interface abstract Lcom/cloudpad/controller/GamepadView$Listener;
.super Ljava/lang/Object;
.source "GamepadView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cloudpad/controller/GamepadView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x608
    name = "Listener"
.end annotation


# virtual methods
.method public abstract onButtonsPressed(I)V
.end method

.method public abstract onEditingChanged(Z)V
.end method

.method public abstract onGamepadState(Lcom/cloudpad/controller/GamepadState;)V
.end method

.method public abstract onLayoutResetRequested()V
.end method

.method public abstract onLayoutSaved(Ljava/lang/String;Ljava/lang/String;)V
.end method

.method public abstract onSettingsTapped()V
.end method

.method public abstract onStatusTapped()V
.end method

.method public abstract onSteeringCenterTapped()V
.end method
