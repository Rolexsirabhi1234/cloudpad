.class public final synthetic Lcom/cloudpad/controller/BlePeripheral$1$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/BlePeripheral$Central;

.field public final synthetic f$1:Landroid/bluetooth/BluetoothGatt;


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/BlePeripheral$Central;Landroid/bluetooth/BluetoothGatt;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$1$$ExternalSyntheticLambda0;->f$0:Lcom/cloudpad/controller/BlePeripheral$Central;

    iput-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$1$$ExternalSyntheticLambda0;->f$1:Landroid/bluetooth/BluetoothGatt;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$1$$ExternalSyntheticLambda0;->f$0:Lcom/cloudpad/controller/BlePeripheral$Central;

    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral$1$$ExternalSyntheticLambda0;->f$1:Landroid/bluetooth/BluetoothGatt;

    invoke-static {v0, v1}, Lcom/cloudpad/controller/BlePeripheral$1;->lambda$onConnectionStateChange$0(Lcom/cloudpad/controller/BlePeripheral$Central;Landroid/bluetooth/BluetoothGatt;)V

    return-void
.end method
