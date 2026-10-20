.class Lcom/cloudpad/controller/BlePeripheral$4;
.super Landroid/bluetooth/BluetoothGattServerCallback;
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

    .line 522
    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-direct {p0}, Landroid/bluetooth/BluetoothGattServerCallback;-><init>()V

    return-void
.end method


# virtual methods
.method synthetic lambda$onCharacteristicWriteRequest$2$com-cloudpad-controller-BlePeripheral$4(Landroid/bluetooth/BluetoothDevice;[B)V
    .locals 1

    .line 554
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0, p1, p2}, Lcom/cloudpad/controller/BlePeripheral;->access$1100(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;[B)V

    return-void
.end method

.method synthetic lambda$onConnectionStateChange$1$com-cloudpad-controller-BlePeripheral$4(Landroid/bluetooth/BluetoothDevice;I)V
    .locals 1

    .line 536
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0, p1, p2}, Lcom/cloudpad/controller/BlePeripheral;->access$1200(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;I)V

    return-void
.end method

.method synthetic lambda$onDescriptorWriteRequest$3$com-cloudpad-controller-BlePeripheral$4(Landroid/bluetooth/BluetoothDevice;Z)V
    .locals 1

    .line 579
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0, p1, p2}, Lcom/cloudpad/controller/BlePeripheral;->access$1000(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;Z)V

    return-void
.end method

.method synthetic lambda$onNotificationSent$4$com-cloudpad-controller-BlePeripheral$4(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1

    .line 595
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0}, Lcom/cloudpad/controller/BlePeripheral;->access$900(Lcom/cloudpad/controller/BlePeripheral;)Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/cloudpad/controller/BlePeripheral$Central;

    if-eqz p1, :cond_0

    const/4 v0, 0x0

    .line 596
    iput-boolean v0, p1, Lcom/cloudpad/controller/BlePeripheral$Central;->inFlight:Z

    .line 597
    :cond_0
    iget-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p1}, Lcom/cloudpad/controller/BlePeripheral;->access$200(Lcom/cloudpad/controller/BlePeripheral;)V

    return-void
.end method

.method synthetic lambda$onServiceAdded$0$com-cloudpad-controller-BlePeripheral$4(I)V
    .locals 3

    .line 0
    if-nez p1, :cond_0

    .line 527
    iget-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p1}, Lcom/cloudpad/controller/BlePeripheral;->access$1300(Lcom/cloudpad/controller/BlePeripheral;)V

    goto :goto_0

    .line 529
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Couldn\'t register the controller service ("

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, ")"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/cloudpad/controller/BlePeripheral;->access$1400(Lcom/cloudpad/controller/BlePeripheral;Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public onCharacteristicReadRequest(Landroid/bluetooth/BluetoothDevice;IILandroid/bluetooth/BluetoothGattCharacteristic;)V
    .locals 1

    .line 542
    sget-object v0, Lcom/cloudpad/controller/Protocol;->INPUT_UUID:Ljava/util/UUID;

    invoke-virtual {p4}, Landroid/bluetooth/BluetoothGattCharacteristic;->getUuid()Ljava/util/UUID;

    move-result-object p4

    invoke-virtual {v0, p4}, Ljava/util/UUID;->equals(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_0

    iget-object p4, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p4}, Lcom/cloudpad/controller/BlePeripheral;->access$600(Lcom/cloudpad/controller/BlePeripheral;)[B

    move-result-object p4

    goto :goto_0

    :cond_0
    const/4 p4, 0x0

    new-array p4, p4, [B

    .line 543
    :goto_0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0, p1, p2, p3, p4}, Lcom/cloudpad/controller/BlePeripheral;->access$700(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;II[B)V

    return-void
.end method

.method public onCharacteristicWriteRequest(Landroid/bluetooth/BluetoothDevice;ILandroid/bluetooth/BluetoothGattCharacteristic;ZZI[B)V
    .locals 7

    .line 550
    sget-object v0, Lcom/cloudpad/controller/Protocol;->OUTPUT_UUID:Ljava/util/UUID;

    invoke-virtual {p3}, Landroid/bluetooth/BluetoothGattCharacteristic;->getUuid()Ljava/util/UUID;

    move-result-object p3

    invoke-virtual {v0, p3}, Ljava/util/UUID;->equals(Ljava/lang/Object;)Z

    move-result p3

    const/4 v0, 0x0

    if-eqz p3, :cond_0

    if-nez p4, :cond_0

    if-nez p6, :cond_0

    if-eqz p7, :cond_0

    const/4 p3, 0x1

    goto :goto_0

    :cond_0
    move p3, v0

    :goto_0
    if-eqz p3, :cond_1

    .line 553
    invoke-virtual {p7}, [B->clone()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, [B

    .line 554
    iget-object p6, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p6}, Lcom/cloudpad/controller/BlePeripheral;->access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;

    move-result-object p6

    new-instance p7, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda1;

    invoke-direct {p7, p0, p1, p4}, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda1;-><init>(Lcom/cloudpad/controller/BlePeripheral$4;Landroid/bluetooth/BluetoothDevice;[B)V

    invoke-virtual {p6, p7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_1
    if-eqz p5, :cond_3

    .line 557
    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    if-eqz p3, :cond_2

    goto :goto_1

    :cond_2
    const/4 v0, 0x3

    :goto_1
    move v4, v0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v2, p1

    move v3, p2

    invoke-static/range {v1 .. v6}, Lcom/cloudpad/controller/BlePeripheral;->access$800(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;III[B)V

    :cond_3
    return-void
.end method

.method public onConnectionStateChange(Landroid/bluetooth/BluetoothDevice;II)V
    .locals 1

    .line 536
    iget-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p2}, Lcom/cloudpad/controller/BlePeripheral;->access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;

    move-result-object p2

    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda3;

    invoke-direct {v0, p0, p1, p3}, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda3;-><init>(Lcom/cloudpad/controller/BlePeripheral$4;Landroid/bluetooth/BluetoothDevice;I)V

    invoke-virtual {p2, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public onDescriptorReadRequest(Landroid/bluetooth/BluetoothDevice;IILandroid/bluetooth/BluetoothGattDescriptor;)V
    .locals 1

    .line 565
    iget-object p4, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p4}, Lcom/cloudpad/controller/BlePeripheral;->access$900(Lcom/cloudpad/controller/BlePeripheral;)Ljava/util/Map;

    move-result-object p4

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p4, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Lcom/cloudpad/controller/BlePeripheral$Central;

    .line 566
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    if-eqz p4, :cond_0

    iget-boolean p4, p4, Lcom/cloudpad/controller/BlePeripheral$Central;->subscribed:Z

    if-eqz p4, :cond_0

    .line 567
    sget-object p4, Landroid/bluetooth/BluetoothGattDescriptor;->ENABLE_NOTIFICATION_VALUE:[B

    goto :goto_0

    .line 568
    :cond_0
    sget-object p4, Landroid/bluetooth/BluetoothGattDescriptor;->DISABLE_NOTIFICATION_VALUE:[B

    .line 566
    :goto_0
    invoke-static {v0, p1, p2, p3, p4}, Lcom/cloudpad/controller/BlePeripheral;->access$700(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;II[B)V

    return-void
.end method

.method public onDescriptorWriteRequest(Landroid/bluetooth/BluetoothDevice;ILandroid/bluetooth/BluetoothGattDescriptor;ZZI[B)V
    .locals 8

    .line 575
    sget-object v0, Lcom/cloudpad/controller/Protocol;->CCCD_UUID:Ljava/util/UUID;

    invoke-virtual {p3}, Landroid/bluetooth/BluetoothGattDescriptor;->getUuid()Ljava/util/UUID;

    move-result-object p3

    invoke-virtual {v0, p3}, Ljava/util/UUID;->equals(Ljava/lang/Object;)Z

    move-result p3

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p3, :cond_0

    if-nez p4, :cond_0

    if-nez p6, :cond_0

    if-eqz p7, :cond_0

    array-length p3, p7

    const/4 p4, 0x2

    if-ne p3, p4, :cond_0

    move p3, v0

    goto :goto_0

    :cond_0
    move p3, v1

    :goto_0
    const/4 p4, 0x3

    if-eqz p3, :cond_2

    .line 578
    aget-byte p6, p7, v1

    and-int/2addr p6, p4

    if-eqz p6, :cond_1

    goto :goto_1

    :cond_1
    move v0, v1

    .line 579
    :goto_1
    iget-object p6, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p6}, Lcom/cloudpad/controller/BlePeripheral;->access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;

    move-result-object p6

    new-instance p7, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda0;

    invoke-direct {p7, p0, p1, v0}, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda0;-><init>(Lcom/cloudpad/controller/BlePeripheral$4;Landroid/bluetooth/BluetoothDevice;Z)V

    invoke-virtual {p6, p7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_2
    if-eqz p5, :cond_4

    .line 582
    iget-object v2, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    if-eqz p3, :cond_3

    move v5, v1

    goto :goto_2

    :cond_3
    move v5, p4

    :goto_2
    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v3, p1

    move v4, p2

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/BlePeripheral;->access$800(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;III[B)V

    :cond_4
    return-void
.end method

.method public onExecuteWrite(Landroid/bluetooth/BluetoothDevice;IZ)V
    .locals 6

    .line 589
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v3, 0x0

    move-object v1, p1

    move v2, p2

    invoke-static/range {v0 .. v5}, Lcom/cloudpad/controller/BlePeripheral;->access$800(Lcom/cloudpad/controller/BlePeripheral;Landroid/bluetooth/BluetoothDevice;III[B)V

    return-void
.end method

.method public onNotificationSent(Landroid/bluetooth/BluetoothDevice;I)V
    .locals 1

    .line 594
    iget-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p2}, Lcom/cloudpad/controller/BlePeripheral;->access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;

    move-result-object p2

    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda4;

    invoke-direct {v0, p0, p1}, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda4;-><init>(Lcom/cloudpad/controller/BlePeripheral$4;Landroid/bluetooth/BluetoothDevice;)V

    invoke-virtual {p2, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public onServiceAdded(ILandroid/bluetooth/BluetoothGattService;)V
    .locals 1

    .line 525
    iget-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$4;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p2}, Lcom/cloudpad/controller/BlePeripheral;->access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;

    move-result-object p2

    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0, p1}, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda2;-><init>(Lcom/cloudpad/controller/BlePeripheral$4;I)V

    invoke-virtual {p2, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
