.class final Lcom/cloudpad/controller/UsbLink$Rumble;
.super Ljava/lang/Object;
.source "UsbLink.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final act:Lcom/cloudpad/controller/MainActivity;

.field final v:[I


# direct methods
.method constructor <init>(Lcom/cloudpad/controller/MainActivity;[I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/UsbLink$Rumble;->act:Lcom/cloudpad/controller/MainActivity;

    iput-object p2, p0, Lcom/cloudpad/controller/UsbLink$Rumble;->v:[I

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lcom/cloudpad/controller/UsbLink$Rumble;->act:Lcom/cloudpad/controller/MainActivity;

    iget-object v1, p0, Lcom/cloudpad/controller/UsbLink$Rumble;->v:[I

    const/4 v2, 0x0

    aget v2, v1, v2

    const/4 v3, 0x1

    aget v3, v1, v3

    const/4 v4, 0x2

    aget v4, v1, v4

    invoke-virtual {v0, v2, v3, v4}, Lcom/cloudpad/controller/MainActivity;->onRumble(III)V

    return-void
.end method
