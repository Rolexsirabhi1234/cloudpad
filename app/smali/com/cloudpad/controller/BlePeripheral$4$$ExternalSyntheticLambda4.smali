.class public final synthetic Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/BlePeripheral$4;

.field public final synthetic f$1:Landroid/bluetooth/BluetoothDevice;


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/BlePeripheral$4;Landroid/bluetooth/BluetoothDevice;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda4;->f$0:Lcom/cloudpad/controller/BlePeripheral$4;

    iput-object p2, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda4;->f$1:Landroid/bluetooth/BluetoothDevice;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda4;->f$0:Lcom/cloudpad/controller/BlePeripheral$4;

    iget-object v1, p0, Lcom/cloudpad/controller/BlePeripheral$4$$ExternalSyntheticLambda4;->f$1:Landroid/bluetooth/BluetoothDevice;

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/BlePeripheral$4;->lambda$onNotificationSent$4$com-cloudpad-controller-BlePeripheral$4(Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method
