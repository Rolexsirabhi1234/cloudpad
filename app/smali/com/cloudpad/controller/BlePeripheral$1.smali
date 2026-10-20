.class Lcom/cloudpad/controller/BlePeripheral$1;
.super Landroid/bluetooth/BluetoothGattCallback;
.source "BlePeripheral.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cloudpad/controller/BlePeripheral;->requestLowLatency(Lcom/cloudpad/controller/BlePeripheral$Central;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cloudpad/controller/BlePeripheral;

.field final synthetic val$c:Lcom/cloudpad/controller/BlePeripheral$Central;


# direct methods
.method constructor <init>(Lcom/cloudpad/controller/BlePeripheral;Lcom/cloudpad/controller/BlePeripheral$Central;)V
    .locals 0

    .line 357
    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$1;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    iput-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$1;->val$c:Lcom/cloudpad/controller/BlePeripheral$Central;

    invoke-direct {p0}, Landroid/bluetooth/BluetoothGattCallback;-><init>()V

    return-void
.end method

.method static synthetic lambda$onConnectionStateChange$0(Lcom/cloudpad/controller/BlePeripheral$Central;Landroid/bluetooth/BluetoothGatt;)V
    .locals 1

    .line 365
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$Central;->priorityGatt:Landroid/bluetooth/BluetoothGatt;

    if-ne v0, p1, :cond_0

    .line 366
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothGatt;->close()V

    const/4 p1, 0x0

    .line 367
    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$Central;->priorityGatt:Landroid/bluetooth/BluetoothGatt;

    :cond_0
    return-void
.end method


# virtual methods
.method public onConnectionStateChange(Landroid/bluetooth/BluetoothGatt;II)V
    .locals 1

    const/4 p2, 0x2

    if-ne p3, p2, :cond_0

    const/4 p2, 0x1

    .line 361
    invoke-virtual {p1, p2}, Landroid/bluetooth/BluetoothGatt;->requestConnectionPriority(I)Z

    move-result p1

    .line 362
    new-instance p2, Ljava/lang/StringBuilder;

    const-string p3, "High connection priority requested: "

    invoke-direct {p2, p3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "CloudPad"

    invoke-static {p2, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_0
    if-nez p3, :cond_1

    .line 364
    iget-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$1;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {p2}, Lcom/cloudpad/controller/BlePeripheral;->access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;

    move-result-object p2

    iget-object p3, p0, Lcom/cloudpad/controller/BlePeripheral$1;->val$c:Lcom/cloudpad/controller/BlePeripheral$Central;

    new-instance v0, Lcom/cloudpad/controller/BlePeripheral$1$$ExternalSyntheticLambda0;

    invoke-direct {v0, p3, p1}, Lcom/cloudpad/controller/BlePeripheral$1$$ExternalSyntheticLambda0;-><init>(Lcom/cloudpad/controller/BlePeripheral$Central;Landroid/bluetooth/BluetoothGatt;)V

    invoke-virtual {p2, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_1
    :goto_0
    return-void
.end method
