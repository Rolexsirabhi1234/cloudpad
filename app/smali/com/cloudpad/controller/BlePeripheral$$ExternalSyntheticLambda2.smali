.class public final synthetic Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/BlePeripheral;


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/BlePeripheral;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda2;->f$0:Lcom/cloudpad/controller/BlePeripheral;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/BlePeripheral$$ExternalSyntheticLambda2;->f$0:Lcom/cloudpad/controller/BlePeripheral;

    invoke-virtual {v0}, Lcom/cloudpad/controller/BlePeripheral;->lambda$stop$2$com-cloudpad-controller-BlePeripheral()V

    return-void
.end method
