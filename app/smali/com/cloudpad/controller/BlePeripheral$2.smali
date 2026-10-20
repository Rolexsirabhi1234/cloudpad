.class Lcom/cloudpad/controller/BlePeripheral$2;
.super Ljava/lang/Object;
.source "BlePeripheral.java"

# interfaces
.implements Ljava/lang/Runnable;


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

    .line 390
    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$2;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 393
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$2;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0}, Lcom/cloudpad/controller/BlePeripheral;->access$100(Lcom/cloudpad/controller/BlePeripheral;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 394
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$2;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0}, Lcom/cloudpad/controller/BlePeripheral;->access$200(Lcom/cloudpad/controller/BlePeripheral;)V

    .line 395
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$2;->this$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-static {v0}, Lcom/cloudpad/controller/BlePeripheral;->access$000(Lcom/cloudpad/controller/BlePeripheral;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v1, 0x32

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
