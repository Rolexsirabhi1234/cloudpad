.class public final synthetic Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/BlePeripheral$4;

.field public final synthetic f$1:Landroid/bluetooth/BluetoothDevice;

.field public final synthetic f$2:Z


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/BlePeripheral$4;Landroid/bluetooth/BluetoothDevice;Z)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda0;->f$0:Lcom/cloudpad/controller/BlePeripheral$4;

    iput-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda0;->f$1:Landroid/bluetooth/BluetoothDevice;

    iput-boolean p3, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda0;->f$2:Z

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda0;->f$0:Lcom/cloudpad/controller/BlePeripheral$4;

    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda0;->f$1:Landroid/bluetooth/BluetoothDevice;

    iget-boolean v2, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda0;->f$2:Z

    invoke-virtual {v0, v1, v2}, Lcom/cloudpad/controller/BlePeripheral$4;->lambda$onDescriptorWriteRequest$3$com-cloudpad-controller-BlePeripheral$4(Landroid/bluetooth/BluetoothDevice;Z)V

    return-void
.end method
