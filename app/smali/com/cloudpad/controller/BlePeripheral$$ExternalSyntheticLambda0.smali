.class public final synthetic Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/BlePeripheral;

.field public final synthetic f$1:Z


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/BlePeripheral;Z)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda0;->f$0:Lcom/cloudpad/controller/BlePeripheral;

    iput-boolean p2, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda0;->f$1:Z

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda0;->f$0:Lcom/cloudpad/controller/BlePeripheral;

    iget-boolean v1, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda0;->f$1:Z

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/BlePeripheral;->lambda$setLowLatency$1$com-cloudpad-controller-BlePeripheral(Z)V

    return-void
.end method
