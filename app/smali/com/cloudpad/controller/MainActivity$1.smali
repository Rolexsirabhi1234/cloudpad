.class Lcom/cloudpad/controller/MainActivity$1;
.super Landroid/content/BroadcastReceiver;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cloudpad/controller/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cloudpad/controller/MainActivity;


# direct methods
.method constructor <init>(Lcom/cloudpad/controller/MainActivity;)V
    .locals 0

    .line 56
    iput-object p1, p0, Lcom/cloudpad/controller/MainActivity$1;->this$0:Lcom/cloudpad/controller/MainActivity;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    .line 59
    const-string p1, "android.bluetooth.adapter.extra.STATE"

    const/high16 v0, -0x80000000

    invoke-virtual {p2, p1, v0}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    const/16 p2, 0xc

    const/4 v0, 0x0

    if-ne p1, p2, :cond_0

    .line 61
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity$1;->this$0:Lcom/cloudpad/controller/MainActivity;

    invoke-static {p1, v0}, Lcom/cloudpad/controller/MainActivity;->access$002(Lcom/cloudpad/controller/MainActivity;Z)Z

    .line 62
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity$1;->this$0:Lcom/cloudpad/controller/MainActivity;

    invoke-static {p1}, Lcom/cloudpad/controller/MainActivity;->access$100(Lcom/cloudpad/controller/MainActivity;)V

    goto :goto_0

    :cond_0
    const/16 p2, 0xd

    if-eq p1, p2, :cond_1

    const/16 p2, 0xa

    if-ne p1, p2, :cond_2

    .line 64
    :cond_1
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity$1;->this$0:Lcom/cloudpad/controller/MainActivity;

    invoke-static {p1}, Lcom/cloudpad/controller/MainActivity;->access$200(Lcom/cloudpad/controller/MainActivity;)V

    .line 65
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity$1;->this$0:Lcom/cloudpad/controller/MainActivity;

    invoke-static {p1}, Lcom/cloudpad/controller/MainActivity;->access$300(Lcom/cloudpad/controller/MainActivity;)Lcom/cloudpad/controller/GamepadView;

    move-result-object p1

    invoke-virtual {p1, v0}, Lcom/cloudpad/controller/GamepadView;->setConnected(Z)V

    .line 66
    iget-object p1, p0, Lcom/cloudpad/controller/MainActivity$1;->this$0:Lcom/cloudpad/controller/MainActivity;

    invoke-static {p1}, Lcom/cloudpad/controller/MainActivity;->access$300(Lcom/cloudpad/controller/MainActivity;)Lcom/cloudpad/controller/GamepadView;

    move-result-object p1

    const-string p2, "Bluetooth is off"

    const-string v0, "Tap here to turn it on"

    const/4 v1, 0x2

    invoke-virtual {p1, v1, p2, v0}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    :cond_2
    :goto_0
    return-void
.end method
