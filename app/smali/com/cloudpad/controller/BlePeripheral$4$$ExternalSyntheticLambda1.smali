.class public final synthetic Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/BlePeripheral$4;

.field public final synthetic f$1:Landroid/bluetooth/BluetoothDevice;

.field public final synthetic f$2:[B


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/BlePeripheral$4;Landroid/bluetooth/BluetoothDevice;[B)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda1;->f$0:Lcom/cloudpad/controller/BlePeripheral$4;

    iput-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda1;->f$1:Landroid/bluetooth/BluetoothDevice;

    iput-object p3, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda1;->f$2:[B

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda1;->f$0:Lcom/cloudpad/controller/BlePeripheral$4;

    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda1;->f$1:Landroid/bluetooth/BluetoothDevice;

    iget-object v2, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda1;->f$2:[B

    invoke-virtual {v0, v1, v2}, Lcom/cloudpad/controller/BlePeripheral$4;->lambda$onCharacteristicWriteRequest$2$com-cloudpad-controller-BlePeripheral$4(Landroid/bluetooth/BluetoothDevice;[B)V

    return-void
.end method
