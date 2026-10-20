.class public final Lcom/cloudpad/controller/SettingsActivity;
.super Landroid/app/Activity;
.source "SettingsActivity.java"

# interfaces
.implements Lcom/cloudpad/controller/TiltSteering$Listener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;,
        Lcom/cloudpad/controller/SettingsActivity$IntSetter;,
        Lcom/cloudpad/controller/SettingsActivity$BoolSetter;
    }
.end annotation


# static fields
.field private static final ACCENT:I = -0xc046b0

.field private static final BG:I = -0xf2eee9

.field private static final BORDER:I = -0xcfc9c3

.field private static final DIM:I = -0x746b62

.field static final EXTRA_EDIT_LAYOUT:Ljava/lang/String; = "edit_layout"

.field private static final TEXT:I = -0x19120d


# instance fields
.field private meter:Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;

.field private settings:Lcom/cloudpad/controller/AppSettings;

.field private tilt:Lcom/cloudpad/controller/TiltSteering;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method private actionRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;
    .locals 4

    .line 274
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/16 v1, 0x10

    .line 275
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/4 v1, 0x6

    .line 276
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v2

    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v1

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v2, v3, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 277
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/SettingsActivity;->texts(Ljava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object p1

    new-instance p2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {p2, v3, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, p1, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 278
    invoke-direct {p0, p3, p4}, Lcom/cloudpad/controller/SettingsActivity;->textButton(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/Button;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-object v0
.end method

.method private configureTilt()V
    .locals 6

    .line 158
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    iget-object v1, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v1}, Lcom/cloudpad/controller/AppSettings;->steeringRange()I

    move-result v1

    int-to-float v1, v1

    iget-object v2, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v2}, Lcom/cloudpad/controller/AppSettings;->steeringDeadzone()I

    move-result v2

    int-to-float v2, v2

    iget-object v3, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v3}, Lcom/cloudpad/controller/AppSettings;->steeringSmoothing()I

    move-result v3

    int-to-float v3, v3

    const/high16 v4, 0x42c80000    # 100.0f

    div-float/2addr v3, v4

    iget-object v4, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 159
    invoke-virtual {v4}, Lcom/cloudpad/controller/AppSettings;->steeringInvert()Z

    move-result v4

    iget-object v5, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v5}, Lcom/cloudpad/controller/AppSettings;->steeringCenter()F

    move-result v5

    .line 158
    invoke-virtual/range {v0 .. v5}, Lcom/cloudpad/controller/TiltSteering;->configure(FFFZF)V

    return-void
.end method

.method private confirmResetLayout()V
    .locals 5

    .line 172
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->mode()Ljava/lang/String;

    move-result-object v0

    .line 173
    const-string v1, "racing"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    :cond_0
    const-string v1, "gamepad"

    .line 174
    :goto_0
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Reset the "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " layout?"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 175
    invoke-virtual {v2, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "Every control goes back to its original place and size."

    .line 176
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda12;

    invoke-direct {v2, p0, v0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda12;-><init>(Lcom/cloudpad/controller/SettingsActivity;Ljava/lang/String;)V

    .line 177
    const-string v0, "Reset"

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Cancel"

    const/4 v2, 0x0

    .line 181
    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 182
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void
.end method

.method private dp(I)I
    .locals 1

    int-to-float p1, p1

    .line 333
    invoke-virtual {p0}, Lcom/cloudpad/controller/SettingsActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method private header()Landroid/view/View;
    .locals 6

    .line 188
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/16 v1, 0x10

    .line 189
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    const v1, -0x19120d

    const/4 v2, 0x1

    .line 190
    const-string v3, "Settings"

    const/16 v4, 0x16

    invoke-direct {p0, v3, v4, v1, v2}, Lcom/cloudpad/controller/SettingsActivity;->label(Ljava/lang/String;IIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 191
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v5, 0x0

    invoke-direct {v2, v5, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 192
    new-instance v1, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda13;

    invoke-direct {v1, p0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda13;-><init>(Lcom/cloudpad/controller/SettingsActivity;)V

    const-string v2, "Done"

    invoke-direct {p0, v2, v1}, Lcom/cloudpad/controller/SettingsActivity;->textButton(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-object v0
.end method

.method private label(Ljava/lang/String;IIZ)Landroid/widget/TextView;
    .locals 1

    .line 313
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 314
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 315
    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setTextColor(I)V

    const/4 p1, 0x2

    int-to-float p2, p2

    .line 316
    invoke-virtual {v0, p1, p2}, Landroid/widget/TextView;->setTextSize(IF)V

    if-eqz p4, :cond_0

    .line 317
    sget-object p1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    :cond_0
    return-object v0
.end method

.method static synthetic lambda$toggle$11(Lcom/cloudpad/controller/SettingsActivity$BoolSetter;Landroid/widget/CompoundButton;Z)V
    .locals 0

    .line 267
    invoke-interface {p0, p2}, Lcom/cloudpad/controller/SettingsActivity$BoolSetter;->set(Z)V

    return-void
.end method

.method static synthetic lambda$toggle$12(Landroid/widget/Switch;Landroid/view/View;)V
    .locals 0

    .line 269
    invoke-virtual {p0}, Landroid/widget/Switch;->toggle()V

    return-void
.end method

.method private modePicker()Landroid/view/View;
    .locals 5

    .line 197
    new-instance v0, Landroid/widget/RadioGroup;

    invoke-direct {v0, p0}, Landroid/widget/RadioGroup;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x0

    .line 198
    invoke-virtual {v0, v1}, Landroid/widget/RadioGroup;->setOrientation(I)V

    const/4 v2, 0x4

    .line 199
    invoke-direct {p0, v2}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v2

    const/16 v3, 0x8

    invoke-direct {p0, v3}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v3

    invoke-virtual {v0, v1, v2, v1, v3}, Landroid/widget/RadioGroup;->setPadding(IIII)V

    .line 200
    const-string v1, "Gamepad"

    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->radio(Ljava/lang/String;)Landroid/widget/RadioButton;

    move-result-object v1

    .line 201
    const-string v2, "Racing (tilt to steer)"

    invoke-direct {p0, v2}, Lcom/cloudpad/controller/SettingsActivity;->radio(Ljava/lang/String;)Landroid/widget/RadioButton;

    move-result-object v2

    .line 202
    invoke-virtual {v0, v1}, Landroid/widget/RadioGroup;->addView(Landroid/view/View;)V

    .line 203
    invoke-virtual {v0, v2}, Landroid/widget/RadioGroup;->addView(Landroid/view/View;)V

    .line 204
    iget-object v3, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v3}, Lcom/cloudpad/controller/AppSettings;->mode()Ljava/lang/String;

    move-result-object v3

    const-string v4, "racing"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    move-object v1, v2

    :cond_0
    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Landroid/widget/RadioButton;->setChecked(Z)V

    .line 205
    new-instance v1, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, v2}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda0;-><init>(Lcom/cloudpad/controller/SettingsActivity;Landroid/widget/RadioButton;)V

    invoke-virtual {v0, v1}, Landroid/widget/RadioGroup;->setOnCheckedChangeListener(Landroid/widget/RadioGroup$OnCheckedChangeListener;)V

    return-object v0
.end method

.method private radio(Ljava/lang/String;)Landroid/widget/RadioButton;
    .locals 3

    .line 211
    new-instance v0, Landroid/widget/RadioButton;

    invoke-direct {v0, p0}, Landroid/widget/RadioButton;-><init>(Landroid/content/Context;)V

    .line 212
    invoke-static {}, Landroid/view/View;->generateViewId()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/RadioButton;->setId(I)V

    .line 213
    invoke-virtual {v0, p1}, Landroid/widget/RadioButton;->setText(Ljava/lang/CharSequence;)V

    const p1, -0x19120d

    .line 214
    invoke-virtual {v0, p1}, Landroid/widget/RadioButton;->setTextColor(I)V

    const/4 p1, 0x2

    const/high16 v1, 0x41700000    # 15.0f

    .line 215
    invoke-virtual {v0, p1, v1}, Landroid/widget/RadioButton;->setTextSize(IF)V

    const p1, -0xc046b0

    .line 216
    invoke-static {p1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/RadioButton;->setButtonTintList(Landroid/content/res/ColorStateList;)V

    const/4 p1, 0x4

    .line 217
    invoke-direct {p0, p1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result p1

    const/16 v1, 0x18

    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v2, v1, v2}, Landroid/widget/RadioButton;->setPadding(IIII)V

    return-object v0
.end method

.method private recenter()V
    .locals 3

    .line 163
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v0}, Lcom/cloudpad/controller/TiltSteering;->isAvailable()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 164
    const-string v0, "This phone has no tilt sensor"

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void

    .line 167
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    iget-object v2, p0, Lcom/cloudpad/controller/SettingsActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v2}, Lcom/cloudpad/controller/TiltSteering;->recenter()F

    move-result v2

    invoke-virtual {v0, v2}, Lcom/cloudpad/controller/AppSettings;->setSteeringCenter(F)V

    .line 168
    const-string v0, "Steering centered"

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private rowColumn()Landroid/widget/LinearLayout;
    .locals 4

    .line 291
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    .line 292
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v1, 0xa

    .line 293
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v1

    const/4 v2, 0x6

    invoke-direct {p0, v2}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v1, v3, v2}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    return-object v0
.end method

.method private section(Landroid/widget/LinearLayout;Ljava/lang/String;)V
    .locals 4

    .line 298
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p2, v0}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p2

    const/16 v0, 0xc

    const v1, -0xc046b0

    const/4 v2, 0x1

    invoke-direct {p0, p2, v0, v1, v2}, Lcom/cloudpad/controller/SettingsActivity;->label(Ljava/lang/String;IIZ)Landroid/widget/TextView;

    move-result-object p2

    const v0, 0x3d75c28f    # 0.06f

    .line 299
    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setLetterSpacing(F)V

    .line 300
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x2

    const/4 v3, -0x1

    invoke-direct {v0, v3, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/16 v1, 0x16

    .line 302
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 303
    invoke-virtual {p1, p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 304
    new-instance p2, Landroid/view/View;

    invoke-direct {p2, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    const v0, -0xcfc9c3

    .line 305
    invoke-virtual {p2, v0}, Landroid/view/View;->setBackgroundColor(I)V

    .line 306
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v3, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/4 v1, 0x6

    .line 307
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    const/4 v1, 0x2

    .line 308
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 309
    invoke-virtual {p1, p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method private slider(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)Landroid/view/View;
    .locals 7

    .line 223
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->rowColumn()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 224
    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/16 v2, 0x10

    .line 225
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/16 v2, 0xf

    const v3, -0x19120d

    const/4 v4, 0x0

    .line 226
    invoke-direct {p0, p1, v2, v3, v4}, Lcom/cloudpad/controller/SettingsActivity;->label(Ljava/lang/String;IIZ)Landroid/widget/TextView;

    move-result-object p1

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x3f800000    # 1.0f

    const/4 v6, -0x2

    invoke-direct {v3, v4, v6, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, p1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 227
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v3, 0x1

    const v5, -0xc046b0

    invoke-direct {p0, p1, v2, v5, v3}, Lcom/cloudpad/controller/SettingsActivity;->label(Ljava/lang/String;IIZ)Landroid/widget/TextView;

    move-result-object p1

    .line 228
    invoke-virtual {v1, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 229
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    if-eqz p2, :cond_0

    const/16 v1, 0xd

    const v2, -0x746b62

    .line 230
    invoke-direct {p0, p2, v1, v2, v4}, Lcom/cloudpad/controller/SettingsActivity;->label(Ljava/lang/String;IIZ)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 232
    :cond_0
    new-instance p2, Landroid/widget/SeekBar;

    invoke-direct {p2, p0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 233
    invoke-virtual {p2, p4}, Landroid/widget/SeekBar;->setMax(I)V

    .line 234
    invoke-virtual {p2, p3}, Landroid/widget/SeekBar;->setMin(I)V

    .line 235
    invoke-virtual {p2, p5}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 236
    invoke-static {v5}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/SeekBar;->setProgressTintList(Landroid/content/res/ColorStateList;)V

    .line 237
    invoke-static {v5}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/SeekBar;->setThumbTintList(Landroid/content/res/ColorStateList;)V

    .line 238
    new-instance p3, Lcom/cloudpad/controller/SettingsActivity$1;

    invoke-direct {p3, p0, p1, p6, p7}, Lcom/cloudpad/controller/SettingsActivity$1;-><init>(Lcom/cloudpad/controller/SettingsActivity;Landroid/widget/TextView;Ljava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)V

    invoke-virtual {p2, p3}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 253
    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 p3, -0x1

    invoke-direct {p1, p3, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/4 p3, 0x4

    .line 255
    invoke-direct {p0, p3}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result p3

    iput p3, p1, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 256
    invoke-virtual {v0, p2, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-object v0
.end method

.method private textButton(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/Button;
    .locals 3

    .line 322
    new-instance v0, Landroid/widget/Button;

    const/4 v1, 0x0

    const v2, 0x101032b

    invoke-direct {v0, p0, v1, v2}, Landroid/widget/Button;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 323
    invoke-virtual {v0, p1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    const p1, -0xc046b0

    .line 324
    invoke-virtual {v0, p1}, Landroid/widget/Button;->setTextColor(I)V

    const/4 p1, 0x0

    .line 325
    invoke-virtual {v0, p1}, Landroid/widget/Button;->setAllCaps(Z)V

    const/4 p1, 0x2

    const/high16 v1, 0x41700000    # 15.0f

    .line 326
    invoke-virtual {v0, p1, v1}, Landroid/widget/Button;->setTextSize(IF)V

    .line 327
    sget-object p1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setTypeface(Landroid/graphics/Typeface;)V

    .line 328
    invoke-virtual {v0, p2}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object v0
.end method

.method private texts(Ljava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 4

    .line 283
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    .line 284
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v1, 0xf

    const v2, -0x19120d

    const/4 v3, 0x0

    .line 285
    invoke-direct {p0, p1, v1, v2, v3}, Lcom/cloudpad/controller/SettingsActivity;->label(Ljava/lang/String;IIZ)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    if-eqz p2, :cond_0

    const/16 p1, 0xd

    const v1, -0x746b62

    .line 286
    invoke-direct {p0, p2, p1, v1, v3}, Lcom/cloudpad/controller/SettingsActivity;->label(Ljava/lang/String;IIZ)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    :cond_0
    return-object v0
.end method

.method private toggle(Ljava/lang/String;Ljava/lang/String;ZLcom/cloudpad/controller/SettingsActivity$BoolSetter;)Landroid/view/View;
    .locals 4

    .line 261
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/16 v1, 0x10

    .line 262
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/16 v1, 0xa

    .line 263
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v2

    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v1

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v2, v3, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 264
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/SettingsActivity;->texts(Ljava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object p1

    new-instance p2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {p2, v3, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, p1, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 265
    new-instance p1, Landroid/widget/Switch;

    invoke-direct {p1, p0}, Landroid/widget/Switch;-><init>(Landroid/content/Context;)V

    .line 266
    invoke-virtual {p1, p3}, Landroid/widget/Switch;->setChecked(Z)V

    .line 267
    new-instance p2, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda11;

    invoke-direct {p2, p4}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda11;-><init>(Lcom/cloudpad/controller/SettingsActivity$BoolSetter;)V

    invoke-virtual {p1, p2}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 268
    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 269
    new-instance p2, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda14;

    invoke-direct {p2, p1}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda14;-><init>(Landroid/widget/Switch;)V

    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object v0
.end method


# virtual methods
.method synthetic lambda$confirmResetLayout$8$com-cloudpad-controller-SettingsActivity(Ljava/lang/String;Landroid/content/DialogInterface;I)V
    .locals 0

    .line 178
    iget-object p2, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {p2, p1}, Lcom/cloudpad/controller/AppSettings;->resetLayout(Ljava/lang/String;)V

    .line 179
    const-string p1, "Layout reset"

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method synthetic lambda$header$9$com-cloudpad-controller-SettingsActivity(Landroid/view/View;)V
    .locals 0

    .line 192
    invoke-virtual {p0}, Lcom/cloudpad/controller/SettingsActivity;->finish()V

    return-void
.end method

.method synthetic lambda$modePicker$10$com-cloudpad-controller-SettingsActivity(Landroid/widget/RadioButton;Landroid/widget/RadioGroup;I)V
    .locals 0

    .line 206
    iget-object p2, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {p1}, Landroid/widget/RadioButton;->getId()I

    move-result p1

    if-ne p3, p1, :cond_0

    const-string p1, "racing"

    goto :goto_0

    :cond_0
    const-string p1, "gamepad"

    :goto_0
    invoke-virtual {p2, p1}, Lcom/cloudpad/controller/AppSettings;->setMode(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$onCreate$0$com-cloudpad-controller-SettingsActivity(Landroid/view/View;)V
    .locals 2

    .line 78
    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-string v0, "edit_layout"

    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    move-result-object p1

    const/4 v0, -0x1

    invoke-virtual {p0, v0, p1}, Lcom/cloudpad/controller/SettingsActivity;->setResult(ILandroid/content/Intent;)V

    .line 79
    invoke-virtual {p0}, Lcom/cloudpad/controller/SettingsActivity;->finish()V

    return-void
.end method

.method synthetic lambda$onCreate$1$com-cloudpad-controller-SettingsActivity(Landroid/view/View;)V
    .locals 0

    .line 82
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->confirmResetLayout()V

    return-void
.end method

.method synthetic lambda$onCreate$2$com-cloudpad-controller-SettingsActivity(Landroid/view/View;)V
    .locals 0

    .line 89
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->recenter()V

    return-void
.end method

.method synthetic lambda$onCreate$3$com-cloudpad-controller-SettingsActivity(I)V
    .locals 1

    .line 92
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0, p1}, Lcom/cloudpad/controller/AppSettings;->setSteeringRange(I)V

    .line 93
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->configureTilt()V

    return-void
.end method

.method synthetic lambda$onCreate$4$com-cloudpad-controller-SettingsActivity(I)V
    .locals 1

    .line 97
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0, p1}, Lcom/cloudpad/controller/AppSettings;->setSteeringDeadzone(I)V

    .line 98
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->configureTilt()V

    return-void
.end method

.method synthetic lambda$onCreate$5$com-cloudpad-controller-SettingsActivity(I)V
    .locals 1

    .line 102
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0, p1}, Lcom/cloudpad/controller/AppSettings;->setSteeringSmoothing(I)V

    .line 103
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->configureTilt()V

    return-void
.end method

.method synthetic lambda$onCreate$6$com-cloudpad-controller-SettingsActivity(Z)V
    .locals 1

    .line 106
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0, p1}, Lcom/cloudpad/controller/AppSettings;->setSteeringInvert(Z)V

    .line 107
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->configureTilt()V

    return-void
.end method

.method synthetic lambda$onCreate$7$com-cloudpad-controller-SettingsActivity(Landroid/view/View;)V
    .locals 0

    .line 135
    invoke-static {p0}, Lcom/cloudpad/controller/Dialogs;->connectHelp(Landroid/app/Activity;)V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 12

    .line 56
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 57
    new-instance p1, Lcom/cloudpad/controller/AppSettings;

    invoke-direct {p1, p0}, Lcom/cloudpad/controller/AppSettings;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 58
    new-instance p1, Lcom/cloudpad/controller/TiltSteering;

    invoke-direct {p1, p0, p0}, Lcom/cloudpad/controller/TiltSteering;-><init>(Landroid/app/Activity;Lcom/cloudpad/controller/TiltSteering$Listener;)V

    iput-object p1, p0, Lcom/cloudpad/controller/SettingsActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    .line 60
    new-instance p1, Landroid/widget/LinearLayout;

    invoke-direct {p1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x1

    .line 61
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 62
    invoke-virtual {p0}, Lcom/cloudpad/controller/SettingsActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    const/16 v1, 0x10

    .line 63
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v1

    const/16 v2, 0x2a8

    invoke-direct {p0, v2}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v2

    sub-int/2addr v0, v2

    div-int/lit8 v0, v0, 0x2

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    const/16 v1, 0x8

    .line 64
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v1

    const/16 v2, 0x20

    invoke-direct {p0, v2}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v2

    invoke-virtual {p1, v0, v1, v0, v2}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 66
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    const v1, -0xf2eee9

    .line 67
    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setBackgroundColor(I)V

    .line 68
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v2, -0x2

    const/4 v3, -0x1

    invoke-direct {v1, v3, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p1, v1}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 70
    invoke-virtual {p0, v0}, Lcom/cloudpad/controller/SettingsActivity;->setContentView(Landroid/view/View;)V

    .line 72
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->header()Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    const-string v0, "Play on"

    invoke-direct {p0, p1, v0}, Lcom/cloudpad/controller/SettingsActivity;->section(Landroid/widget/LinearLayout;Ljava/lang/String;)V

    invoke-static {p0}, Lcom/cloudpad/controller/PcMode;->picker(Landroid/app/Activity;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 74
    const-string v0, "Controller"

    invoke-direct {p0, p1, v0}, Lcom/cloudpad/controller/SettingsActivity;->section(Landroid/widget/LinearLayout;Ljava/lang/String;)V

    .line 75
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->modePicker()Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 76
    new-instance v0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda15;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda15;-><init>(Lcom/cloudpad/controller/SettingsActivity;)V

    const-string v1, "Customize layout"

    const-string v2, "Drag, resize or hide the controls of the selected mode"

    const-string v4, "Edit"

    invoke-direct {p0, v1, v2, v4, v0}, Lcom/cloudpad/controller/SettingsActivity;->actionRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 81
    new-instance v0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda2;-><init>(Lcom/cloudpad/controller/SettingsActivity;)V

    const-string v1, "Reset layout"

    const-string v2, "Put the selected mode\'s controls back where they started"

    const-string v4, "Reset"

    invoke-direct {p0, v1, v2, v4, v0}, Lcom/cloudpad/controller/SettingsActivity;->actionRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 84
    const-string v0, "Racing mode: tilt steering"

    invoke-direct {p0, p1, v0}, Lcom/cloudpad/controller/SettingsActivity;->section(Landroid/widget/LinearLayout;Ljava/lang/String;)V

    .line 85
    new-instance v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->meter:Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;

    .line 86
    iget-object v1, p0, Lcom/cloudpad/controller/SettingsActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v1}, Lcom/cloudpad/controller/TiltSteering;->isAvailable()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->setAvailable(Z)V

    .line 87
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->meter:Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v2, 0x40

    invoke-direct {p0, v2}, Lcom/cloudpad/controller/SettingsActivity;->dp(I)I

    move-result v2

    invoke-direct {v1, v3, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 88
    new-instance v0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda3;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda3;-><init>(Lcom/cloudpad/controller/SettingsActivity;)V

    const-string v1, "Center steering"

    const-string v2, "Hold the phone the way that should mean straight ahead, then tap"

    const-string v3, "Center"

    invoke-direct {p0, v1, v2, v3, v0}, Lcom/cloudpad/controller/SettingsActivity;->actionRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 90
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 91
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->steeringRange()I

    move-result v6

    new-instance v8, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda4;

    invoke-direct {v8, p0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda4;-><init>(Lcom/cloudpad/controller/SettingsActivity;)V

    .line 90
    const-string v2, "Steering range"

    const-string v3, "How far you turn the phone for full lock"

    const/16 v4, 0xa

    const/16 v5, 0x5a

    const-string v7, "\u00b0"

    move-object v1, p0

    invoke-direct/range {v1 .. v8}, Lcom/cloudpad/controller/SettingsActivity;->slider(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 95
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 96
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->steeringDeadzone()I

    move-result v6

    new-instance v8, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda5;

    invoke-direct {v8, p0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda5;-><init>(Lcom/cloudpad/controller/SettingsActivity;)V

    .line 95
    const-string v2, "Steering deadzone"

    const-string v3, "Small turns around straight ahead are ignored"

    const/4 v4, 0x0

    const/16 v5, 0xa

    const-string v7, "\u00b0"

    invoke-direct/range {v1 .. v8}, Lcom/cloudpad/controller/SettingsActivity;->slider(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 100
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 101
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->steeringSmoothing()I

    move-result v6

    new-instance v8, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda6;

    invoke-direct {v8, p0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda6;-><init>(Lcom/cloudpad/controller/SettingsActivity;)V

    .line 100
    const-string v2, "Steering smoothing"

    const-string v3, "Higher is steadier but reacts a little later"

    const/16 v5, 0x5a

    const-string v7, "%"

    invoke-direct/range {v1 .. v8}, Lcom/cloudpad/controller/SettingsActivity;->slider(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 105
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->steeringInvert()Z

    move-result v0

    new-instance v1, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda7;-><init>(Lcom/cloudpad/controller/SettingsActivity;)V

    const-string v2, "Invert steering"

    const/4 v3, 0x0

    invoke-direct {p0, v2, v3, v0, v1}, Lcom/cloudpad/controller/SettingsActivity;->toggle(Ljava/lang/String;Ljava/lang/String;ZLcom/cloudpad/controller/SettingsActivity$BoolSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 110
    const-string v0, "Racing mode: pedals"

    invoke-direct {p0, p1, v0}, Lcom/cloudpad/controller/SettingsActivity;->section(Landroid/widget/LinearLayout;Ljava/lang/String;)V

    .line 111
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 112
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->analogPedals()Z

    move-result v0

    iget-object v1, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda8;

    invoke-direct {v2, v1}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda8;-><init>(Lcom/cloudpad/controller/AppSettings;)V

    .line 111
    const-string v1, "Analog pedals"

    const-string v4, "Slide up a pedal to press harder. Off: any touch is a full press"

    invoke-direct {p0, v1, v4, v0, v2}, Lcom/cloudpad/controller/SettingsActivity;->toggle(Ljava/lang/String;Ljava/lang/String;ZLcom/cloudpad/controller/SettingsActivity$BoolSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 113
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 114
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->pedalDeadzone()I

    move-result v9

    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-static {v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v11, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda9;

    invoke-direct {v11, v0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda9;-><init>(Lcom/cloudpad/controller/AppSettings;)V

    .line 113
    const-string v5, "Pedal deadzone"

    const-string v6, "Bottom part of each pedal that does nothing"

    const/4 v7, 0x0

    const/16 v8, 0x1e

    const-string v10, "%"

    move-object v4, p0

    invoke-direct/range {v4 .. v11}, Lcom/cloudpad/controller/SettingsActivity;->slider(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 115
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 116
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->pedalFullAt()I

    move-result v9

    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-static {v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v11, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda10;

    invoke-direct {v11, v0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda10;-><init>(Lcom/cloudpad/controller/AppSettings;)V

    .line 115
    const-string v5, "Full press at"

    const-string v6, "How high up the pedal counts as 100%"

    const/16 v7, 0x32

    const/16 v8, 0x64

    const-string v10, "%"

    invoke-direct/range {v4 .. v11}, Lcom/cloudpad/controller/SettingsActivity;->slider(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 118
    const-string v0, "Gamepad mode: sticks"

    invoke-direct {p0, p1, v0}, Lcom/cloudpad/controller/SettingsActivity;->section(Landroid/widget/LinearLayout;Ljava/lang/String;)V

    .line 119
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 120
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->floatingSticks()Z

    move-result v0

    iget-object v1, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda16;

    invoke-direct {v2, v1}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda16;-><init>(Lcom/cloudpad/controller/AppSettings;)V

    .line 119
    const-string v1, "Floating sticks"

    const-string v4, "A stick starts wherever your thumb lands"

    invoke-direct {p0, v1, v4, v0, v2}, Lcom/cloudpad/controller/SettingsActivity;->toggle(Ljava/lang/String;Ljava/lang/String;ZLcom/cloudpad/controller/SettingsActivity$BoolSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 121
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 122
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->stickDeadzone()I

    move-result v9

    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-static {v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v11, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda17;

    invoke-direct {v11, v0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda17;-><init>(Lcom/cloudpad/controller/AppSettings;)V

    .line 121
    const-string v5, "Stick deadzone"

    const-string v6, "Small thumb movements near the centre are ignored"

    const/4 v7, 0x0

    const/16 v8, 0x1e

    const-string v10, "%"

    move-object v4, p0

    invoke-direct/range {v4 .. v11}, Lcom/cloudpad/controller/SettingsActivity;->slider(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 123
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 124
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->stickOuterDeadzone()I

    move-result v9

    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-static {v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v11, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda18;

    invoke-direct {v11, v0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda18;-><init>(Lcom/cloudpad/controller/AppSettings;)V

    .line 123
    const-string v5, "Stick outer deadzone"

    const-string v6, "Reach full tilt before the edge of the stick"

    const-string v10, "%"

    invoke-direct/range {v4 .. v11}, Lcom/cloudpad/controller/SettingsActivity;->slider(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Lcom/cloudpad/controller/SettingsActivity$IntSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 126
    const-string v0, "Vibration"

    invoke-direct {p0, p1, v0}, Lcom/cloudpad/controller/SettingsActivity;->section(Landroid/widget/LinearLayout;Ljava/lang/String;)V

    .line 127
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->haptics()Z

    move-result v0

    iget-object v1, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda19;

    invoke-direct {v2, v1}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda19;-><init>(Lcom/cloudpad/controller/AppSettings;)V

    const-string v1, "Vibrate on button press"

    invoke-direct {p0, v1, v3, v0, v2}, Lcom/cloudpad/controller/SettingsActivity;->toggle(Ljava/lang/String;Ljava/lang/String;ZLcom/cloudpad/controller/SettingsActivity$BoolSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 128
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->rumble()Z

    move-result v0

    iget-object v1, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 129
    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda20;

    invoke-direct {v2, v1}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda20;-><init>(Lcom/cloudpad/controller/AppSettings;)V

    .line 128
    const-string v1, "Game rumble"

    const-string v3, "Play the game\'s rumble on the phone"

    invoke-direct {p0, v1, v3, v0, v2}, Lcom/cloudpad/controller/SettingsActivity;->toggle(Ljava/lang/String;Ljava/lang/String;ZLcom/cloudpad/controller/SettingsActivity$BoolSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 131
    const-string v0, "Connection"

    invoke-direct {p0, p1, v0}, Lcom/cloudpad/controller/SettingsActivity;->section(Landroid/widget/LinearLayout;Ljava/lang/String;)V

    .line 132
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    .line 133
    invoke-virtual {v0}, Lcom/cloudpad/controller/AppSettings;->lowLatency()Z

    move-result v0

    iget-object v1, p0, Lcom/cloudpad/controller/SettingsActivity;->settings:Lcom/cloudpad/controller/AppSettings;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda21;

    invoke-direct {v2, v1}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda21;-><init>(Lcom/cloudpad/controller/AppSettings;)V

    .line 132
    const-string v1, "Low-latency Bluetooth"

    const-string v3, "Ask the laptop for a faster link (applies on next connect)"

    invoke-direct {p0, v1, v3, v0, v2}, Lcom/cloudpad/controller/SettingsActivity;->toggle(Ljava/lang/String;Ljava/lang/String;ZLcom/cloudpad/controller/SettingsActivity$BoolSetter;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 134
    new-instance v0, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/cloudpad/controller/SettingsActivity$$ExternalSyntheticLambda1;-><init>(Lcom/cloudpad/controller/SettingsActivity;)V

    const-string v1, "How to connect"

    const-string v2, "Steps for the mode picked under Play on"

    const-string v3, "Show"

    invoke-direct {p0, v1, v2, v3, v0}, Lcom/cloudpad/controller/SettingsActivity;->actionRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 137
    invoke-direct {p0}, Lcom/cloudpad/controller/SettingsActivity;->configureTilt()V

    return-void
.end method

.method protected onPause()V
    .locals 1

    .line 148
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 149
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v0}, Lcom/cloudpad/controller/TiltSteering;->stop()V

    return-void
.end method

.method protected onResume()V
    .locals 1

    .line 142
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 143
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    invoke-virtual {v0}, Lcom/cloudpad/controller/TiltSteering;->start()V

    return-void
.end method

.method public onSteering(FF)V
    .locals 1

    .line 154
    iget-object v0, p0, Lcom/cloudpad/controller/SettingsActivity;->meter:Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;

    invoke-virtual {v0, p1, p2}, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->set(FF)V

    return-void
.end method
