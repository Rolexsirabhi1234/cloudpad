.class final Lcom/cloudpad/controller/UsbLink$Ui;
.super Ljava/lang/Object;
.source "UsbLink.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final link:Lcom/cloudpad/controller/UsbLink;

.field final on:Z


# direct methods
.method constructor <init>(Lcom/cloudpad/controller/UsbLink;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/UsbLink$Ui;->link:Lcom/cloudpad/controller/UsbLink;

    iput-boolean p2, p0, Lcom/cloudpad/controller/UsbLink$Ui;->on:Z

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/cloudpad/controller/UsbLink$Ui;->link:Lcom/cloudpad/controller/UsbLink;

    iget-object v0, v0, Lcom/cloudpad/controller/UsbLink;->view:Lcom/cloudpad/controller/GamepadView;

    iget-boolean v1, p0, Lcom/cloudpad/controller/UsbLink$Ui;->on:Z

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/GamepadView;->setConnected(Z)V

    if-eqz v1, :off

    const/4 v1, 0x1

    const-string v2, "Connected by USB cable"

    const-string v3, "Keep this app open while you play"

    invoke-virtual {v0, v1, v2, v3}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    return-void

    :off
    const/4 v1, 0x0

    const-string v2, "USB cable disconnected"

    const-string v3, "Plug it back in with USB tethering on, or join over Bluetooth"

    invoke-virtual {v0, v1, v2, v3}, Lcom/cloudpad/controller/GamepadView;->setStatus(ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method
