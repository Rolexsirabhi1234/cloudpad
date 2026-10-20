.class final Lcom/cloudpad/controller/PcMode$Listener;
.super Ljava/lang/Object;
.source "PcMode.java"

# interfaces
.implements Landroid/widget/RadioGroup$OnCheckedChangeListener;


# instance fields
.field private final ctx:Landroid/content/Context;

.field private final pcId:I


# direct methods
.method constructor <init>(Landroid/content/Context;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/PcMode$Listener;->ctx:Landroid/content/Context;

    iput p2, p0, Lcom/cloudpad/controller/PcMode$Listener;->pcId:I

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/RadioGroup;I)V
    .locals 2

    iget v0, p0, Lcom/cloudpad/controller/PcMode$Listener;->pcId:I

    if-ne p2, v0, :cloud

    const/4 v0, 0x1

    goto :set

    :cloud
    const/4 v0, 0x0

    :set
    iget-object v1, p0, Lcom/cloudpad/controller/PcMode$Listener;->ctx:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/cloudpad/controller/PcMode;->setPc(Landroid/content/Context;Z)V

    return-void
.end method
