.class public final synthetic Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/widget/RadioGroup$OnCheckedChangeListener;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/SettingsActivity;

.field public final synthetic f$1:Landroid/widget/RadioButton;


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/SettingsActivity;Landroid/widget/RadioButton;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda0;->f$0:Lcom/cloudpad/controller/SettingsActivity;

    iput-object p2, p0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda0;->f$1:Landroid/widget/RadioButton;

    return-void
.end method


# virtual methods
.method public final onCheckedChanged(Landroid/widget/RadioGroup;I)V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda0;->f$0:Lcom/cloudpad/controller/SettingsActivity;

    iget-object v1, p0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda0;->f$1:Landroid/widget/RadioButton;

    invoke-virtual {v0, v1, p1, p2}, Lcom/cloudpad/controller/SettingsActivity;->lambda$modePicker$10$com-cloudpad-controller-SettingsActivity(Landroid/widget/RadioButton;Landroid/widget/RadioGroup;I)V

    return-void
.end method
