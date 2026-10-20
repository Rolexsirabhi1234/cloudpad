.class public final Lcom/cloudpad/controller/PcMode;
.super Ljava/lang/Object;
.source "PcMode.java"


# "Play on" option: cloud gaming in the browser, or installed PC games via CloudPad Bridge.

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isPc(Landroid/content/Context;)Z
    .locals 3

    const-string v0, "cloudpad"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "play_target"

    const-string v2, "cloud"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "pc"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static setPc(Landroid/content/Context;Z)V
    .locals 3

    const-string v0, "cloudpad"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "play_target"

    if-eqz p1, :cloud

    const-string v2, "pc"

    goto :put

    :cloud
    const-string v2, "cloud"

    :put
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public static waitingDetail(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    invoke-static {p0}, Lcom/cloudpad/controller/PcMode;->isPc(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :pc

    const/4 v0, 0x0

    return-object v0

    :pc
    if-nez p1, :named

    const-string v0, "Start CloudPad Bridge on the laptop — it connects by itself"

    return-object v0

    :named
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Start CloudPad Bridge on the laptop — it finds “"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "” by itself"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static showHelp(Landroid/app/Activity;)Z
    .locals 3

    invoke-static {p0}, Lcom/cloudpad/controller/PcMode;->isPc(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :pc

    const/4 v0, 0x0

    return v0

    :pc
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "Play games installed on your laptop"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Your phone shows up on the laptop as a normal Xbox controller, so it works in Steam, Epic and any game that supports a controller. Up to 4 phones can play together.\n\nOn the laptop: open CloudPad Bridge (double-click CloudPad Bridge.pyw).\n\nBluetooth (wireless): hold this phone next to the laptop until the Bridge shows it as a player. You can then move back.\n\nUSB cable (most reliable): plug the phone into the laptop and turn on Settings > Hotspot & tethering > USB tethering. It joins by itself. Tip: turn off mobile data on this phone so the laptop keeps using Wi-Fi for internet.\n\nKeep this app open while you play."

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Got it"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    const/4 v0, 0x1

    return v0
.end method

.method private static radio(Landroid/content/Context;Ljava/lang/String;F)Landroid/widget/RadioButton;
    .locals 4

    new-instance v0, Landroid/widget/RadioButton;

    invoke-direct {v0, p0}, Landroid/widget/RadioButton;-><init>(Landroid/content/Context;)V

    invoke-static {}, Landroid/view/View;->generateViewId()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setId(I)V

    invoke-virtual {v0, p1}, Landroid/widget/RadioButton;->setText(Ljava/lang/CharSequence;)V

    const v1, -0x19120d

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setTextColor(I)V

    const/4 v1, 0x2

    const/high16 v2, 0x41700000    # 15.0f

    invoke-virtual {v0, v1, v2}, Landroid/widget/RadioButton;->setTextSize(IF)V

    const v1, -0xc046b0

    invoke-static {v1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setButtonTintList(Landroid/content/res/ColorStateList;)V

    const/high16 v1, 0x40800000    # 4.0f

    mul-float/2addr v1, p2

    float-to-int v1, v1

    const/high16 v2, 0x40c00000    # 6.0f

    mul-float/2addr v2, p2

    float-to-int v2, v2

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3, v2}, Landroid/widget/RadioButton;->setPadding(IIII)V

    return-object v0
.end method

.method public static picker(Landroid/app/Activity;)Landroid/view/View;
    .locals 7

    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    new-instance v2, Landroid/widget/RadioGroup;

    invoke-direct {v2, p0}, Landroid/widget/RadioGroup;-><init>(Landroid/content/Context;)V

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/widget/RadioGroup;->setOrientation(I)V

    const/high16 v3, 0x40800000    # 4.0f

    mul-float/2addr v3, v0

    float-to-int v3, v3

    const/4 v4, 0x0

    invoke-virtual {v2, v4, v3, v4, v3}, Landroid/widget/RadioGroup;->setPadding(IIII)V

    const-string v3, "Cloud gaming — xbox.com/play in the browser"

    invoke-static {p0, v3, v0}, Lcom/cloudpad/controller/PcMode;->radio(Landroid/content/Context;Ljava/lang/String;F)Landroid/widget/RadioButton;

    move-result-object v3

    const-string v4, "Installed PC games — CloudPad Bridge on the laptop"

    invoke-static {p0, v4, v0}, Lcom/cloudpad/controller/PcMode;->radio(Landroid/content/Context;Ljava/lang/String;F)Landroid/widget/RadioButton;

    move-result-object v4

    invoke-virtual {v2, v3}, Landroid/widget/RadioGroup;->addView(Landroid/view/View;)V

    invoke-virtual {v2, v4}, Landroid/widget/RadioGroup;->addView(Landroid/view/View;)V

    invoke-static {p0}, Lcom/cloudpad/controller/PcMode;->isPc(Landroid/content/Context;)Z

    move-result v5

    const/4 v6, 0x1

    if-eqz v5, :cloud

    invoke-virtual {v4, v6}, Landroid/widget/RadioButton;->setChecked(Z)V

    goto :checked

    :cloud
    invoke-virtual {v3, v6}, Landroid/widget/RadioButton;->setChecked(Z)V

    :checked
    new-instance v5, Lcom/cloudpad/controller/PcMode$Listener;

    invoke-virtual {v4}, Landroid/widget/RadioButton;->getId()I

    move-result v6

    invoke-direct {v5, p0, v6}, Lcom/cloudpad/controller/PcMode$Listener;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v2, v5}, Landroid/widget/RadioGroup;->setOnCheckedChangeListener(Landroid/widget/RadioGroup$OnCheckedChangeListener;)V

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v3, "Installed games need CloudPad Bridge running on the laptop. See “How to connect” under Connection for the steps."

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const v3, -0x746b62

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    const/4 v3, 0x2

    const/high16 v4, 0x41500000    # 13.0f

    invoke-virtual {v2, v3, v4}, Landroid/widget/TextView;->setTextSize(IF)V

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-object v1
.end method
