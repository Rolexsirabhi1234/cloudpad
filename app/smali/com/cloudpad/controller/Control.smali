.class final Lcom/cloudpad/controller/Control;
.super Ljava/lang/Object;
.source "Control.java"


# static fields
.field static final BUTTON:I = 0x0

.field static final DPAD:I = 0x3

.field static final MAX_SCALE:F = 2.0f

.field static final MIN_SCALE:F = 0.5f

.field static final PEDAL:I = 0x4

.field static final SETTINGS:I = 0x6

.field static final SHOULDER:I = 0x1

.field static final STICK:I = 0x2

.field private static final STICK_ZONE:F = 1.75f

.field static final STYLE_FACE:I = 0x0

.field static final STYLE_GUIDE:I = 0x4

.field static final STYLE_MENU:I = 0x3

.field static final STYLE_SMALL:I = 0x1

.field static final STYLE_VIEW:I = 0x2

.field static final WHEEL:I = 0x5


# instance fields
.field final accent:I

.field baseHeight:F

.field baseWidth:F

.field final bounds:Landroid/graphics/RectF;

.field cx:F

.field cy:F

.field defaultX:F

.field defaultY:F

.field height:F

.field hidden:Z

.field hiddenByDefault:Z

.field final input:I

.field final key:Ljava/lang/String;

.field final kind:I

.field final label:Ljava/lang/String;

.field mask:I

.field final name:Ljava/lang/String;

.field originX:F

.field originY:F

.field pointerId:I

.field scale:F

.field final style:I

.field userX:F

.field userY:F

.field value:F

.field width:F

.field x:F

.field y:F


# direct methods
.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;II)V
    .locals 1

    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/high16 v0, 0x7fc00000    # Float.NaN

    .line 46
    iput v0, p0, Lcom/cloudpad/controller/Control;->userX:F

    .line 47
    iput v0, p0, Lcom/cloudpad/controller/Control;->userY:F

    const/high16 v0, 0x3f800000    # 1.0f

    .line 48
    iput v0, p0, Lcom/cloudpad/controller/Control;->scale:F

    .line 56
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    const/4 v0, -0x1

    .line 59
    iput v0, p0, Lcom/cloudpad/controller/Control;->pointerId:I

    .line 71
    iput-object p1, p0, Lcom/cloudpad/controller/Control;->key:Ljava/lang/String;

    .line 72
    iput-object p2, p0, Lcom/cloudpad/controller/Control;->name:Ljava/lang/String;

    .line 73
    iput p3, p0, Lcom/cloudpad/controller/Control;->kind:I

    .line 74
    iput p4, p0, Lcom/cloudpad/controller/Control;->input:I

    .line 75
    iput-object p5, p0, Lcom/cloudpad/controller/Control;->label:Ljava/lang/String;

    .line 76
    iput p6, p0, Lcom/cloudpad/controller/Control;->accent:I

    .line 77
    iput p7, p0, Lcom/cloudpad/controller/Control;->style:I

    return-void
.end method

.method static button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;
    .locals 9

    .line 81
    new-instance v8, Lcom/cloudpad/controller/Control;

    const/4 v3, 0x0

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move v4, p2

    move-object v5, p3

    move v6, p4

    move v7, p5

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/Control;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;II)V

    return-object v8
.end method

.method static dpad()Lcom/cloudpad/controller/Control;
    .locals 9

    .line 93
    new-instance v8, Lcom/cloudpad/controller/Control;

    const/4 v6, 0x0

    const/4 v7, 0x0

    const-string v1, "dpad"

    const-string v2, "D-pad"

    const/4 v3, 0x3

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/Control;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;II)V

    return-object v8
.end method

.method static pedal(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;I)Lcom/cloudpad/controller/Control;
    .locals 9

    .line 97
    new-instance v8, Lcom/cloudpad/controller/Control;

    const/4 v3, 0x4

    const/4 v7, 0x0

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move v4, p2

    move-object v5, p3

    move v6, p4

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/Control;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;II)V

    return-object v8
.end method

.method static settings()Lcom/cloudpad/controller/Control;
    .locals 9

    .line 105
    new-instance v8, Lcom/cloudpad/controller/Control;

    const/4 v6, 0x0

    const/4 v7, 0x0

    const-string v1, "settings"

    const-string v2, "Settings button"

    const/4 v3, 0x6

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/Control;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;II)V

    return-object v8
.end method

.method static shoulder(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)Lcom/cloudpad/controller/Control;
    .locals 9

    .line 85
    new-instance v8, Lcom/cloudpad/controller/Control;

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v3, 0x1

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/Control;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;II)V

    return-object v8
.end method

.method static stick(Ljava/lang/String;Ljava/lang/String;I)Lcom/cloudpad/controller/Control;
    .locals 9

    .line 89
    new-instance v8, Lcom/cloudpad/controller/Control;

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v3, 0x2

    const/4 v5, 0x0

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move v4, p2

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/Control;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;II)V

    return-object v8
.end method

.method static wheel()Lcom/cloudpad/controller/Control;
    .locals 9

    .line 101
    new-instance v8, Lcom/cloudpad/controller/Control;

    const/4 v6, 0x0

    const/4 v7, 0x0

    const-string v1, "wheel"

    const-string v2, "Steering indicator"

    const/4 v3, 0x5

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/Control;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;II)V

    return-object v8
.end method

.method private within(FFF)Z
    .locals 0

    .line 168
    invoke-virtual {p0, p1, p2}, Lcom/cloudpad/controller/Control;->distance2(FF)F

    move-result p1

    mul-float/2addr p3, p3

    cmpg-float p1, p1, p3

    if-gtz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method


# virtual methods
.method distance2(FF)F
    .locals 1

    .line 151
    iget v0, p0, Lcom/cloudpad/controller/Control;->cx:F

    sub-float/2addr p1, v0

    .line 152
    iget v0, p0, Lcom/cloudpad/controller/Control;->cy:F

    sub-float/2addr p2, v0

    mul-float/2addr p1, p1

    mul-float/2addr p2, p2

    add-float/2addr p1, p2

    return p1
.end method

.method hit(FFF)Z
    .locals 2

    .line 139
    iget v0, p0, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/cloudpad/controller/Control;->radius()F

    move-result p3

    const/high16 v0, 0x3fe00000    # 1.75f

    mul-float/2addr p3, v0

    invoke-direct {p0, p1, p2, p3}, Lcom/cloudpad/controller/Control;->within(FFF)Z

    move-result p1

    return p1

    .line 140
    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lcom/cloudpad/controller/Control;->shapeHit(FFF)Z

    move-result p1

    return p1
.end method

.method initiallyHidden()Lcom/cloudpad/controller/Control;
    .locals 1

    const/4 v0, 0x1

    .line 109
    iput-boolean v0, p0, Lcom/cloudpad/controller/Control;->hiddenByDefault:Z

    .line 110
    iput-boolean v0, p0, Lcom/cloudpad/controller/Control;->hidden:Z

    return-object p0
.end method

.method isRound()Z
    .locals 2

    .line 115
    iget v0, p0, Lcom/cloudpad/controller/Control;->kind:I

    if-eqz v0, :cond_1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    const/4 v1, 0x5

    if-eq v0, v1, :cond_1

    const/4 v1, 0x6

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method radius()F
    .locals 2

    .line 119
    iget v0, p0, Lcom/cloudpad/controller/Control;->width:F

    iget v1, p0, Lcom/cloudpad/controller/Control;->height:F

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    return v0
.end method

.method release()V
    .locals 2

    const/4 v0, -0x1

    .line 158
    iput v0, p0, Lcom/cloudpad/controller/Control;->pointerId:I

    const/4 v0, 0x0

    .line 159
    iput v0, p0, Lcom/cloudpad/controller/Control;->x:F

    .line 160
    iput v0, p0, Lcom/cloudpad/controller/Control;->y:F

    const/4 v1, 0x0

    .line 161
    iput v1, p0, Lcom/cloudpad/controller/Control;->mask:I

    .line 162
    iput v0, p0, Lcom/cloudpad/controller/Control;->value:F

    .line 163
    iget v0, p0, Lcom/cloudpad/controller/Control;->cx:F

    iput v0, p0, Lcom/cloudpad/controller/Control;->originX:F

    .line 164
    iget v0, p0, Lcom/cloudpad/controller/Control;->cy:F

    iput v0, p0, Lcom/cloudpad/controller/Control;->originY:F

    return-void
.end method

.method resolve(FF)V
    .locals 6

    .line 124
    iget v0, p0, Lcom/cloudpad/controller/Control;->baseWidth:F

    iget v1, p0, Lcom/cloudpad/controller/Control;->scale:F

    mul-float/2addr v0, v1

    iput v0, p0, Lcom/cloudpad/controller/Control;->width:F

    .line 125
    iget v0, p0, Lcom/cloudpad/controller/Control;->baseHeight:F

    mul-float/2addr v0, v1

    iput v0, p0, Lcom/cloudpad/controller/Control;->height:F

    .line 126
    iget v0, p0, Lcom/cloudpad/controller/Control;->userX:F

    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/cloudpad/controller/Control;->defaultX:F

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/cloudpad/controller/Control;->userX:F

    mul-float/2addr v0, p1

    .line 127
    :goto_0
    iget v1, p0, Lcom/cloudpad/controller/Control;->userY:F

    invoke-static {v1}, Ljava/lang/Float;->isNaN(F)Z

    move-result v1

    if-eqz v1, :cond_1

    iget v1, p0, Lcom/cloudpad/controller/Control;->defaultY:F

    goto :goto_1

    :cond_1
    iget v1, p0, Lcom/cloudpad/controller/Control;->userY:F

    mul-float/2addr v1, p2

    :goto_1
    const/4 v2, 0x0

    .line 128
    invoke-static {v0, v2, p1}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result p1

    iput p1, p0, Lcom/cloudpad/controller/Control;->cx:F

    .line 129
    invoke-static {v1, v2, p2}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result p1

    iput p1, p0, Lcom/cloudpad/controller/Control;->cy:F

    .line 130
    iget-object p2, p0, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget v0, p0, Lcom/cloudpad/controller/Control;->cx:F

    iget v1, p0, Lcom/cloudpad/controller/Control;->width:F

    const/high16 v2, 0x40000000    # 2.0f

    div-float v3, v1, v2

    sub-float v3, v0, v3

    iget v4, p0, Lcom/cloudpad/controller/Control;->height:F

    div-float v5, v4, v2

    sub-float v5, p1, v5

    div-float/2addr v1, v2

    add-float/2addr v0, v1

    div-float/2addr v4, v2

    add-float/2addr p1, v4

    invoke-virtual {p2, v3, v5, v0, p1}, Landroid/graphics/RectF;->set(FFFF)V

    .line 131
    iget p1, p0, Lcom/cloudpad/controller/Control;->pointerId:I

    if-gez p1, :cond_2

    .line 132
    iget p1, p0, Lcom/cloudpad/controller/Control;->cx:F

    iput p1, p0, Lcom/cloudpad/controller/Control;->originX:F

    .line 133
    iget p1, p0, Lcom/cloudpad/controller/Control;->cy:F

    iput p1, p0, Lcom/cloudpad/controller/Control;->originY:F

    :cond_2
    return-void
.end method

.method shapeHit(FFF)Z
    .locals 1

    .line 145
    invoke-virtual {p0}, Lcom/cloudpad/controller/Control;->isRound()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v0

    add-float/2addr v0, p3

    invoke-direct {p0, p1, p2, v0}, Lcom/cloudpad/controller/Control;->within(FFF)Z

    move-result p1

    return p1

    .line 146
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->left:F

    sub-float/2addr v0, p3

    cmpl-float v0, p1, v0

    if-ltz v0, :cond_1

    iget-object v0, p0, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->right:F

    add-float/2addr v0, p3

    cmpg-float p1, p1, v0

    if-gtz p1, :cond_1

    iget-object p1, p0, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->top:F

    sub-float/2addr p1, p3

    cmpl-float p1, p2, p1

    if-ltz p1, :cond_1

    iget-object p1, p0, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->bottom:F

    add-float/2addr p1, p3

    cmpg-float p1, p2, p1

    if-gtz p1, :cond_1

    const/4 p1, 0x1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    :goto_0
    return p1
.end method
