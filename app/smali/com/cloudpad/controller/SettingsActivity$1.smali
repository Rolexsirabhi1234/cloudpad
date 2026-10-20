.class Lcom/cloudpad/controller/SettingsActivity$1;
.super Ljava/lang/Object;
.source "SettingsActivity.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cloudpad/controller/SettingsActivity;->slider(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cloudpad/controller/SettingsActivity;

.field final synthetic val$setter:Lcom/cloudpad/controller/SettingsActivity$IntSetter;

.field final synthetic val$unit:Ljava/lang/String;

.field final synthetic val$valueText:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Lcom/cloudpad/controller/SettingsActivity;Landroid/widget/TextView;Ljava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 238
    iput-object p1, p0, Lcom/cloudpad/controller/SettingsActivity$1;->this$0:Lcom/cloudpad/controller/SettingsActivity;

    iput-object p2, p0, Lcom/cloudpad/controller/SettingsActivity$1;->val$valueText:Landroid/widget/TextView;

    iput-object p3, p0, Lcom/cloudpad/controller/SettingsActivity$1;->val$unit:Ljava/lang/String;

    iput-object p4, p0, Lcom/cloudpad/controller/SettingsActivity$1;->val$setter:Lcom/cloudpad/controller/SettingsActivity$IntSetter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 2

    .line 241
    iget-object p1, p0, Lcom/cloudpad/controller/SettingsActivity$1;->val$valueText:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cloudpad/controller/SettingsActivity$1;->val$unit:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    if-eqz p3, :cond_0

    .line 242
    iget-object p1, p0, Lcom/cloudpad/controller/SettingsActivity$1;->val$setter:Lcom/cloudpad/controller/SettingsActivity$IntSetter;

    invoke-interface {p1, p2}, Lcom/cloudpad/controller/SettingsActivity$IntSetter;->set(I)V

    :cond_0
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method
