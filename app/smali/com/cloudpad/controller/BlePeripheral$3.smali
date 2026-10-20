.class Lcom/cloudpad/controller/BlePeripheral$3;
.super Landroid/bluetooth/le/AdvertiseCallback;
.source "BlePeripheral.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cloudpad/controller/BlePeripheral;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cloudpad/controller/BlePeripheral;


# direct methods
.method constructor <init>(Lcom/cloudpad/controller/BlePeripheral;)V
    .locals 0

    .line 507
    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$3;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-direct {p0}, Landroid/bluetooth/le/AdvertiseCallback;-><init>()V

    return-void
.end method


# virtual methods
.method synthetic lambda$onStartFailure$1$com-cloudpad-controller-BlePeripheral$3(I)V
    .locals 1

    .line 518
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$3;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0, p1}, Lcom/cloudpad/controller/BlePeripheral;->access$300(Lcom/cloudpad/controller/BlePeripheral;I)V

    return-void
.end method

.method synthetic lambda$onStartSuccess$0$com-cloudpad-controller-BlePeripheral$3()V
    .locals 2

    .line 511
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$3;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cloudpad/controller/BlePeripheral;->access$402(Lcom/cloudpad/controller/BlePeripheral;Z)Z

    .line 512
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$3;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0}, Lcom/cloudpad/controller/BlePeripheral;->access$500(Lcom/cloudpad/controller/BlePeripheral;)V

    return-void
.end method

.method public onStartFailure(I)V
    .locals 2

    .line 518
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$3;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0}, Lcom/cloudpad/controller/BlePeripheral;->access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/cloudpad/controller/BlePeripheral$3$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lcom/cloudpad/controller/BlePeripheral$3$$ExternalSyntheticLambda0;-><init>(Lcom/cloudpad/controller/BlePeripheral$3;I)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public onStartSuccess(Landroid/bluetooth/le/AdvertiseSettings;)V
    .locals 1

    .line 510
    iget-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$3;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p1}, Lcom/cloudpad/controller/BlePeripheral;->access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;

    move-result-object p1

    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$3$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/BlePeripheral$3$$ExternalSyntheticLambda1;-><init>(Lcom/cloudpad/controller/BlePeripheral$3;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
