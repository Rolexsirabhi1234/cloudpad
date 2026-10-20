.class public final synthetic Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/BlePeripheral;

.field public final synthetic f$1:Ljava/lang/String;

.field public final synthetic f$2:Lcom/cloudpad/controller/BlePeripheral$Central;


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/BlePeripheral;Ljava/lang/String;Lcom/cloudpad/controller/BlePeripheral$Central;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda4;->f$0:Lcom/cloudpad/controller/BlePeripheral;

    iput-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda4;->f$1:Ljava/lang/String;

    iput-object p3, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda4;->f$2:Lcom/cloudpad/controller/BlePeripheral$Central;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda4;->f$0:Lcom/cloudpad/controller/BlePeripheral;

    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda4;->f$1:Ljava/lang/String;

    iget-object v2, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda4;->f$2:Lcom/cloudpad/controller/BlePeripheral$Central;

    invoke-virtual {v0, v1, v2}, Lcom/cloudpad/controller/BlePeripheral;->lambda$onConnectionChanged$3$com-cloudpad-controller-BlePeripheral(Ljava/lang/String;Lcom/cloudpad/controller/BlePeripheral$Central;)V

    return-void
.end method
