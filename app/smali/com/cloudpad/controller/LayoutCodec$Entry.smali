.class final Lcom/cloudpad/controller/LayoutCodec$Entry;
.super Ljava/lang/Object;
.source "LayoutCodec.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cloudpad/controller/LayoutCodec;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Entry"
.end annotation


# instance fields
.field final hidden:Z

.field final scale:F

.field final x:F

.field final y:F


# direct methods
.method constructor <init>(FFFZ)V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 21
    iput p1, p0, Lcom/cloudpad/controller/LayoutCodec$Entry;->x:F

    .line 22
    iput p2, p0, Lcom/cloudpad/controller/LayoutCodec$Entry;->y:F

    .line 23
    iput p3, p0, Lcom/cloudpad/controller/LayoutCodec$Entry;->scale:F

    .line 24
    iput-boolean p4, p0, Lcom/cloudpad/controller/LayoutCodec$Entry;->hidden:Z

    return-void
.end method
