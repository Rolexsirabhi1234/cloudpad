.class public final synthetic Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda21;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/cloudpad/controller/SettingsActivity$BoolSetter;


# instance fields
.field public final synthetic f$0:Lcom/cloudpad/controller/AppSettings;


# direct methods
.method public synthetic constructor <init>(Lcom/cloudpad/controller/AppSettings;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda21;->f$0:Lcom/cloudpad/controller/AppSettings;

    return-void
.end method


# virtual methods
.method public final set(Z)V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda21;->f$0:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0, p1}, Lcom/cloudpad/controller/AppSettings;->setLowLatency(Z)V

    return-void
.end method
