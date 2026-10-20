.class final Lcom/cloudpad/controller/BlePeripheral$Central;
.super Ljava/lang/Object;
.source "BlePeripheral.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cloudpad/controller/BlePeripheral;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Central"
.end annotation


# instance fields
.field final device:Landroid/bluetooth/BluetoothDevice;

.field inFlight:Z

.field inFlightSince:J

.field lastSend:J

.field pendingPong:[B

.field priorityGatt:Landroid/bluetooth/BluetoothGatt;

.field sentVersion:I

.field volatile subscribed:Z


# direct methods
.method constructor <init>(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1

    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    .line 71
    iput v0, p0, Lcom/cloudpad/controller/BlePeripheral$Central;->sentVersion:I

    .line 76
    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$Central;->device:Landroid/bluetooth/BluetoothDevice;

    return-void
.end method
