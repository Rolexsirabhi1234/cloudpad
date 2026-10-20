.class final Lcom/cloudpad/controller/UsbLink$Tx;
.super Ljava/lang/Object;
.source "UsbLink.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final link:Lcom/cloudpad/controller/UsbLink;

.field final data:[B


# direct methods
.method constructor <init>(Lcom/cloudpad/controller/UsbLink;[B)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/UsbLink$Tx;->link:Lcom/cloudpad/controller/UsbLink;

    iput-object p2, p0, Lcom/cloudpad/controller/UsbLink$Tx;->data:[B

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/cloudpad/controller/UsbLink$Tx;->link:Lcom/cloudpad/controller/UsbLink;

    iget-object v1, p0, Lcom/cloudpad/controller/UsbLink$Tx;->data:[B

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/UsbLink;->sendNow([B)V

    return-void
.end method
