.class public final synthetic Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda3;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/GamepadView;


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/GamepadView;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda3;->f$0:Lcom/cloudpad/controller/GamepadView;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity$$ExternalSyntheticLambda3;->f$0:Lcom/cloudpad/controller/GamepadView;

    invoke-virtual {v0}, Lcom/cloudpad/controller/GamepadView;->startEditing()V

    return-void
.end method
