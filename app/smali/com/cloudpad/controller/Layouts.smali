.class final Lcom/cloudpad/controller/Layouts;
.super Ljava/lang/Object;
.source "Layouts.java"


# static fields
.field private static final BLUE:I = -0xa75901

.field private static final GREEN:I = -0xc046b0

.field private static final RED:I = -0x7aeb7

.field private static final YELLOW:I = -0x1c4cbf


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static apply(Ljava/util/List;Ljava/lang/String;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/cloudpad/controller/Control;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 140
    invoke-static {p1}, Lcom/cloudpad/controller/LayoutCodec;->decode(Ljava/lang/String;)Ljava/util/Map;

    move-result-object p1

    .line 141
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cloudpad/controller/Control;

    .line 142
    iget-object v1, v0, Lcom/cloudpad/controller/Control;->key:Ljava/lang/String;

    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cloudpad/controller/LayoutCodec$Entry;

    if-nez v1, :cond_0

    goto :goto_0

    .line 144
    :cond_0
    iget v2, v1, Lcom/cloudpad/controller/LayoutCodec$Entry;->x:F

    const/4 v3, 0x0

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-static {v2, v3, v4}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result v2

    iput v2, v0, Lcom/cloudpad/controller/Control;->userX:F

    .line 145
    iget v2, v1, Lcom/cloudpad/controller/LayoutCodec$Entry;->y:F

    invoke-static {v2, v3, v4}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result v2

    iput v2, v0, Lcom/cloudpad/controller/Control;->userY:F

    .line 146
    iget v2, v1, Lcom/cloudpad/controller/LayoutCodec$Entry;->scale:F

    const/high16 v3, 0x3f000000    # 0.5f

    const/high16 v4, 0x40000000    # 2.0f

    invoke-static {v2, v3, v4}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result v2

    iput v2, v0, Lcom/cloudpad/controller/Control;->scale:F

    .line 147
    iget-boolean v1, v1, Lcom/cloudpad/controller/LayoutCodec$Entry;->hidden:Z

    if-eqz v1, :cond_1

    iget v1, v0, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v2, 0x6

    if-eq v1, v2, :cond_1

    const/4 v1, 0x1

    goto :goto_1

    :cond_1
    const/4 v1, 0x0

    :goto_1
    iput-boolean v1, v0, Lcom/cloudpad/controller/Control;->hidden:Z

    goto :goto_0

    :cond_2
    return-void
.end method

.method static create(Ljava/lang/String;)Ljava/util/List;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lcom/cloudpad/controller/Control;",
            ">;"
        }
    .end annotation

    .line 18
    const-string v0, "racing"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    .line 19
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const/4 v1, 0x7

    const/4 v2, 0x6

    const/4 v3, 0x1

    .line 20
    const-string v4, "Right stick"

    const-string v5, "rstick"

    if-eqz p0, :cond_0

    .line 21
    const-string v6, "BRAKE"

    const v7, -0x7aeb7

    const-string v8, "brake"

    const-string v9, "Brake pedal (LT)"

    invoke-static {v8, v9, v2, v6, v7}, Lcom/cloudpad/controller/Control;->pedal(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;I)Lcom/cloudpad/controller/Control;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 22
    const-string v2, "GAS"

    const v6, -0xc046b0

    const-string v7, "throttle"

    const-string v8, "Throttle pedal (RT)"

    invoke-static {v7, v8, v1, v2, v6}, Lcom/cloudpad/controller/Control;->pedal(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;I)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 23
    invoke-static {}, Lcom/cloudpad/controller/Control;->wheel()Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 24
    invoke-static {v5, v4, v3}, Lcom/cloudpad/controller/Control;->stick(Ljava/lang/String;Ljava/lang/String;I)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cloudpad/controller/Control;->initiallyHidden()Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 26
    :cond_0
    const-string v6, "Left stick"

    const/4 v7, 0x0

    const-string v8, "lstick"

    invoke-static {v8, v6, v7}, Lcom/cloudpad/controller/Control;->stick(Ljava/lang/String;Ljava/lang/String;I)Lcom/cloudpad/controller/Control;

    move-result-object v6

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 27
    invoke-static {v5, v4, v3}, Lcom/cloudpad/controller/Control;->stick(Ljava/lang/String;Ljava/lang/String;I)Lcom/cloudpad/controller/Control;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 28
    const-string v3, "Left trigger"

    const-string v4, "LT"

    const-string v5, "lt"

    invoke-static {v5, v3, v2, v4}, Lcom/cloudpad/controller/Control;->shoulder(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)Lcom/cloudpad/controller/Control;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 29
    const-string v2, "Right trigger"

    const-string v3, "RT"

    const-string v4, "rt"

    invoke-static {v4, v2, v1, v3}, Lcom/cloudpad/controller/Control;->shoulder(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 31
    :goto_0
    invoke-static {}, Lcom/cloudpad/controller/Control;->dpad()Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v1, 0x4

    .line 32
    const-string v2, "LB"

    const-string v3, "lb"

    const-string v4, "Left bumper"

    invoke-static {v3, v4, v1, v2}, Lcom/cloudpad/controller/Control;->shoulder(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v1, 0x5

    .line 33
    const-string v2, "RB"

    const-string v3, "rb"

    const-string v4, "Right bumper"

    invoke-static {v3, v4, v1, v2}, Lcom/cloudpad/controller/Control;->shoulder(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v6, -0xc046b0

    const/4 v7, 0x0

    .line 34
    const-string v2, "a"

    const-string v3, "A button"

    const/4 v4, 0x0

    const-string v5, "A"

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/Control;->button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v6, -0x7aeb7

    .line 35
    const-string v2, "b"

    const-string v3, "B button"

    const/4 v4, 0x1

    const-string v5, "B"

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/Control;->button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v6, -0xa75901

    .line 36
    const-string v2, "x"

    const-string v3, "X button"

    const/4 v4, 0x2

    const-string v5, "X"

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/Control;->button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v6, -0x1c4cbf

    .line 37
    const-string v2, "y"

    const-string v3, "Y button"

    const/4 v4, 0x3

    const-string v5, "Y"

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/Control;->button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v6, 0x0

    const/4 v7, 0x2

    .line 38
    const-string v2, "view"

    const-string v3, "View button"

    const/16 v4, 0x8

    const/4 v5, 0x0

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/Control;->button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v7, 0x3

    .line 39
    const-string v2, "menu"

    const-string v3, "Menu button"

    const/16 v4, 0x9

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/Control;->button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v7, 0x4

    .line 40
    const-string v2, "guide"

    const-string v3, "Guide button"

    const/16 v4, 0x10

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/Control;->button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v7, 0x1

    .line 41
    const-string v2, "l3"

    const-string v3, "Left stick click"

    const/16 v4, 0xa

    const-string v5, "LS"

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/Control;->button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;

    move-result-object v1

    .line 42
    const-string v2, "r3"

    const-string v3, "Right stick click"

    const/16 v4, 0xb

    const-string v5, "RS"

    invoke-static/range {v2 .. v7}, Lcom/cloudpad/controller/Control;->button(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;II)Lcom/cloudpad/controller/Control;

    move-result-object v2

    if-eqz p0, :cond_1

    .line 44
    invoke-virtual {v1}, Lcom/cloudpad/controller/Control;->initiallyHidden()Lcom/cloudpad/controller/Control;

    .line 45
    invoke-virtual {v2}, Lcom/cloudpad/controller/Control;->initiallyHidden()Lcom/cloudpad/controller/Control;

    .line 47
    :cond_1
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 48
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 49
    invoke-static {}, Lcom/cloudpad/controller/Control;->settings()Lcom/cloudpad/controller/Control;

    move-result-object p0

    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object v0
.end method

.method static encode(Ljava/util/List;FF)Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/cloudpad/controller/Control;",
            ">;FF)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 132
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    .line 133
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cloudpad/controller/Control;

    .line 134
    iget-object v2, v1, Lcom/cloudpad/controller/Control;->key:Ljava/lang/String;

    new-instance v3, Lcom/cloudpad/controller/LayoutCodec$Entry;

    iget v4, v1, Lcom/cloudpad/controller/Control;->cx:F

    div-float/2addr v4, p1

    iget v5, v1, Lcom/cloudpad/controller/Control;->cy:F

    div-float/2addr v5, p2

    iget v6, v1, Lcom/cloudpad/controller/Control;->scale:F

    iget-boolean v1, v1, Lcom/cloudpad/controller/Control;->hidden:Z

    invoke-direct {v3, v4, v5, v6, v1}, Lcom/cloudpad/controller/LayoutCodec$Entry;-><init>(FFFZ)V

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 136
    :cond_0
    invoke-static {v0}, Lcom/cloudpad/controller/LayoutCodec;->encode(Ljava/util/Map;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static placeDefaults(Ljava/lang/String;Ljava/util/List;FFFF)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lcom/cloudpad/controller/Control;",
            ">;FFFF)V"
        }
    .end annotation

    sub-float v0, p5, p3

    sub-float v1, p4, p2

    const v2, 0x3ff33333    # 1.9f

    div-float/2addr v1, v2

    .line 58
    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    add-float v1, p2, p4

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    .line 60
    const-string v2, "racing"

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    .line 61
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/cloudpad/controller/Control;

    if-eqz p0, :cond_0

    move v3, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move v7, v0

    move v8, v1

    .line 63
    invoke-static/range {v2 .. v8}, Lcom/cloudpad/controller/Layouts;->placeRacing(Lcom/cloudpad/controller/Control;FFFFFF)V

    goto :goto_0

    :cond_0
    move v3, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move v7, v0

    move v8, v1

    .line 65
    invoke-static/range {v2 .. v8}, Lcom/cloudpad/controller/Layouts;->placeGamepad(Lcom/cloudpad/controller/Control;FFFFFF)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private static placeGamepad(Lcom/cloudpad/controller/Control;FFFFFF)V
    .locals 19

    move-object/from16 v0, p0

    move/from16 v1, p6

    sub-float v2, p4, p2

    const v3, 0x3eeb851f    # 0.46f

    mul-float/2addr v2, v3

    add-float v2, p2, v2

    .line 72
    iget-object v4, v0, Lcom/cloudpad/controller/Control;->key:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v5

    const/4 v6, -0x1

    sparse-switch v5, :sswitch_data_0

    goto/16 :goto_0

    :sswitch_0
    const-string v5, "settings"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    goto/16 :goto_0

    :cond_0
    const/16 v6, 0x10

    goto/16 :goto_0

    :sswitch_1
    const-string v5, "guide"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    goto/16 :goto_0

    :cond_1
    const/16 v6, 0xf

    goto/16 :goto_0

    :sswitch_2
    const-string v5, "view"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    goto/16 :goto_0

    :cond_2
    const/16 v6, 0xe

    goto/16 :goto_0

    :sswitch_3
    const-string v5, "menu"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_3

    goto/16 :goto_0

    :cond_3
    const/16 v6, 0xd

    goto/16 :goto_0

    :sswitch_4
    const-string v5, "dpad"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_4

    goto/16 :goto_0

    :cond_4
    const/16 v6, 0xc

    goto/16 :goto_0

    :sswitch_5
    const-string v5, "rt"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_5

    goto/16 :goto_0

    :cond_5
    const/16 v6, 0xb

    goto/16 :goto_0

    :sswitch_6
    const-string v5, "rb"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_6

    goto/16 :goto_0

    :cond_6
    const/16 v6, 0xa

    goto/16 :goto_0

    :sswitch_7
    const-string v5, "r3"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_7

    goto/16 :goto_0

    :cond_7
    const/16 v6, 0x9

    goto/16 :goto_0

    :sswitch_8
    const-string v5, "lt"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_8

    goto/16 :goto_0

    :cond_8
    const/16 v6, 0x8

    goto/16 :goto_0

    :sswitch_9
    const-string v5, "lb"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_9

    goto :goto_0

    :cond_9
    const/4 v6, 0x7

    goto :goto_0

    :sswitch_a
    const-string v5, "l3"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_a

    goto :goto_0

    :cond_a
    const/4 v6, 0x6

    goto :goto_0

    :sswitch_b
    const-string v5, "y"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_b

    goto :goto_0

    :cond_b
    const/4 v6, 0x5

    goto :goto_0

    :sswitch_c
    const-string v5, "x"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_c

    goto :goto_0

    :cond_c
    const/4 v6, 0x4

    goto :goto_0

    :sswitch_d
    const-string v5, "b"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_d

    goto :goto_0

    :cond_d
    const/4 v6, 0x3

    goto :goto_0

    :sswitch_e
    const-string v5, "a"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_e

    goto :goto_0

    :cond_e
    const/4 v6, 0x2

    goto :goto_0

    :sswitch_f
    const-string v5, "rstick"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_f

    goto :goto_0

    :cond_f
    const/4 v6, 0x1

    goto :goto_0

    :sswitch_10
    const-string v5, "lstick"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_10

    goto :goto_0

    :cond_10
    const/4 v6, 0x0

    :goto_0
    const v4, 0x3de147ae    # 0.11f

    const v5, 0x3e2e147b    # 0.17f

    const v7, 0x3e051eb8    # 0.13f

    const v8, 0x3e4ccccd    # 0.2f

    const v9, 0x3f1eb852    # 0.62f

    const v10, 0x3ee147ae    # 0.44f

    const v11, 0x3e75c28f    # 0.24f

    const v12, 0x3db851ec    # 0.09f

    const v13, 0x3dcccccd    # 0.1f

    const v14, 0x3eb851ec    # 0.36f

    const v15, 0x3e6147ae    # 0.22f

    const v16, 0x3e19999a    # 0.15f

    const v17, 0x3e99999a    # 0.3f

    const v18, 0x3df5c28f    # 0.12f

    packed-switch v6, :pswitch_data_0

    goto/16 :goto_1

    :pswitch_0
    mul-float v2, p5, v13

    sub-float v3, p4, v2

    .line 89
    invoke-static {v0, v1, v3, v2}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_1
    const v3, 0x3d4ccccd    # 0.05f

    mul-float v3, v3, p5

    sub-float/2addr v2, v3

    mul-float v3, p5, v16

    .line 87
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_2
    mul-float v3, p5, v5

    sub-float/2addr v1, v3

    mul-float v3, p5, v4

    .line 86
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_3
    mul-float v3, p5, v5

    add-float/2addr v1, v3

    mul-float v3, p5, v4

    .line 88
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_4
    mul-float v1, p5, v9

    add-float v1, p1, v1

    mul-float v2, p5, v8

    sub-float v2, p4, v2

    mul-float v3, p5, v17

    .line 78
    invoke-static {v0, v1, v2, v3, v3}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto/16 :goto_1

    :pswitch_5
    mul-float v1, p5, v15

    sub-float v1, p3, v1

    mul-float v2, p5, v12

    add-float v2, p2, v2

    mul-float v3, p5, v14

    mul-float v4, p5, v18

    .line 75
    invoke-static {v0, v1, v2, v3, v4}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto/16 :goto_1

    :pswitch_6
    mul-float v1, p5, v15

    sub-float v1, p3, v1

    mul-float v2, p5, v11

    add-float v2, p2, v2

    mul-float v3, p5, v14

    mul-float v4, p5, v18

    .line 76
    invoke-static {v0, v1, v2, v3, v4}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto/16 :goto_1

    :pswitch_7
    mul-float v1, p5, v13

    sub-float v1, p3, v1

    mul-float v2, p5, v18

    sub-float v2, p4, v2

    mul-float v3, p5, v7

    .line 85
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_8
    mul-float v1, p5, v15

    add-float v1, p1, v1

    mul-float v2, p5, v12

    add-float v2, p2, v2

    mul-float v3, p5, v14

    mul-float v4, p5, v18

    .line 73
    invoke-static {v0, v1, v2, v3, v4}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto/16 :goto_1

    :pswitch_9
    mul-float v1, p5, v15

    add-float v1, p1, v1

    mul-float v2, p5, v11

    add-float v2, p2, v2

    mul-float v3, p5, v14

    mul-float v4, p5, v18

    .line 74
    invoke-static {v0, v1, v2, v3, v4}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto :goto_1

    :pswitch_a
    mul-float v1, p5, v13

    add-float v1, p1, v1

    mul-float v2, p5, v18

    sub-float v2, p4, v2

    mul-float v3, p5, v7

    .line 79
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_b
    mul-float v1, p5, v17

    sub-float v1, p3, v1

    const v2, 0x3f19999a    # 0.6f

    mul-float v2, v2, p5

    sub-float v2, p4, v2

    mul-float v3, p5, v16

    .line 80
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_c
    mul-float v1, p5, v10

    sub-float v1, p3, v1

    mul-float v2, p5, v3

    sub-float v2, p4, v2

    mul-float v3, p5, v16

    .line 82
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_d
    const v1, 0x3e23d70a    # 0.16f

    mul-float v1, v1, p5

    sub-float v1, p3, v1

    mul-float v2, p5, v3

    sub-float v2, p4, v2

    mul-float v3, p5, v16

    .line 83
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_e
    mul-float v1, p5, v17

    sub-float v1, p3, v1

    const v2, 0x3ea3d70a    # 0.32f

    mul-float v2, v2, p5

    sub-float v2, p4, v2

    mul-float v3, p5, v16

    .line 81
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_f
    mul-float v1, p5, v9

    sub-float v1, p3, v1

    mul-float v2, p5, v8

    sub-float v2, p4, v2

    mul-float v3, p5, v17

    .line 84
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_10
    mul-float v1, p5, v17

    add-float v1, p1, v1

    mul-float v2, p5, v10

    sub-float v2, p4, v2

    const v3, 0x3eae147b    # 0.34f

    mul-float v3, v3, p5

    .line 77
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    :goto_1
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x4129bc5c -> :sswitch_10
        -0x36eca8a2 -> :sswitch_f
        0x61 -> :sswitch_e
        0x62 -> :sswitch_d
        0x78 -> :sswitch_c
        0x79 -> :sswitch_b
        0xd47 -> :sswitch_a
        0xd76 -> :sswitch_9
        0xd88 -> :sswitch_8
        0xe01 -> :sswitch_7
        0xe30 -> :sswitch_6
        0xe42 -> :sswitch_5
        0x2f25af -> :sswitch_4
        0x33155f -> :sswitch_3
        0x373aa5 -> :sswitch_2
        0x5e23afc -> :sswitch_1
        0x5582bc23 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static placeRacing(Lcom/cloudpad/controller/Control;FFFFFF)V
    .locals 19

    move-object/from16 v0, p0

    move/from16 v1, p6

    .line 96
    iget-object v2, v0, Lcom/cloudpad/controller/Control;->key:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v3

    const/4 v4, -0x1

    sparse-switch v3, :sswitch_data_0

    goto/16 :goto_0

    :sswitch_0
    const-string v3, "throttle"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    goto/16 :goto_0

    :cond_0
    const/16 v4, 0x10

    goto/16 :goto_0

    :sswitch_1
    const-string v3, "settings"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    goto/16 :goto_0

    :cond_1
    const/16 v4, 0xf

    goto/16 :goto_0

    :sswitch_2
    const-string v3, "wheel"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    goto/16 :goto_0

    :cond_2
    const/16 v4, 0xe

    goto/16 :goto_0

    :sswitch_3
    const-string v3, "guide"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_3

    goto/16 :goto_0

    :cond_3
    const/16 v4, 0xd

    goto/16 :goto_0

    :sswitch_4
    const-string v3, "brake"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_4

    goto/16 :goto_0

    :cond_4
    const/16 v4, 0xc

    goto/16 :goto_0

    :sswitch_5
    const-string v3, "view"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_5

    goto/16 :goto_0

    :cond_5
    const/16 v4, 0xb

    goto/16 :goto_0

    :sswitch_6
    const-string v3, "menu"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_6

    goto/16 :goto_0

    :cond_6
    const/16 v4, 0xa

    goto/16 :goto_0

    :sswitch_7
    const-string v3, "dpad"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_7

    goto/16 :goto_0

    :cond_7
    const/16 v4, 0x9

    goto/16 :goto_0

    :sswitch_8
    const-string v3, "rb"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_8

    goto/16 :goto_0

    :cond_8
    const/16 v4, 0x8

    goto/16 :goto_0

    :sswitch_9
    const-string v3, "r3"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_9

    goto :goto_0

    :cond_9
    const/4 v4, 0x7

    goto :goto_0

    :sswitch_a
    const-string v3, "lb"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_a

    goto :goto_0

    :cond_a
    const/4 v4, 0x6

    goto :goto_0

    :sswitch_b
    const-string v3, "l3"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_b

    goto :goto_0

    :cond_b
    const/4 v4, 0x5

    goto :goto_0

    :sswitch_c
    const-string v3, "y"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_c

    goto :goto_0

    :cond_c
    const/4 v4, 0x4

    goto :goto_0

    :sswitch_d
    const-string v3, "x"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_d

    goto :goto_0

    :cond_d
    const/4 v4, 0x3

    goto :goto_0

    :sswitch_e
    const-string v3, "b"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_e

    goto :goto_0

    :cond_e
    const/4 v4, 0x2

    goto :goto_0

    :sswitch_f
    const-string v3, "a"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_f

    goto :goto_0

    :cond_f
    const/4 v4, 0x1

    goto :goto_0

    :sswitch_10
    const-string v3, "rstick"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_10

    goto :goto_0

    :cond_10
    const/4 v4, 0x0

    :goto_0
    const v2, 0x3de147ae    # 0.11f

    const v3, 0x3ed1eb85    # 0.41f

    const v5, 0x3e75c28f    # 0.24f

    const/high16 v6, 0x3f000000    # 0.5f

    const v7, 0x3e0f5c29    # 0.14f

    const v8, 0x3eb851ec    # 0.36f

    const v9, 0x3f147ae1    # 0.58f

    const v10, 0x3e851eb8    # 0.26f

    const v11, 0x3e2e147b    # 0.17f

    const v12, 0x3e19999a    # 0.15f

    const v13, 0x3f051eb8    # 0.52f

    const v14, 0x3dcccccd    # 0.1f

    const v15, 0x3ea8f5c3    # 0.33f

    const v16, 0x3e99999a    # 0.3f

    const v17, 0x3e6147ae    # 0.22f

    const v18, 0x3e051eb8    # 0.13f

    packed-switch v4, :pswitch_data_0

    goto/16 :goto_1

    :pswitch_0
    mul-float v1, p5, v11

    sub-float v1, p3, v1

    mul-float v2, p5, v15

    sub-float v2, p4, v2

    mul-float v3, p5, v10

    mul-float v4, p5, v9

    .line 98
    invoke-static {v0, v1, v2, v3, v4}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto/16 :goto_1

    :pswitch_1
    const v2, 0x3db851ec    # 0.09f

    mul-float v2, v2, p5

    sub-float v2, p4, v2

    mul-float v3, p5, v14

    .line 113
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_2
    const v2, 0x3ebd70a4    # 0.37f

    mul-float v2, v2, p5

    add-float v2, p2, v2

    mul-float v3, p5, v17

    .line 101
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_3
    mul-float v2, p5, v15

    sub-float v2, p4, v2

    mul-float v3, p5, v12

    .line 111
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_4
    mul-float v1, p5, v11

    add-float v1, p1, v1

    mul-float v2, p5, v15

    sub-float v2, p4, v2

    mul-float v3, p5, v10

    mul-float v4, p5, v9

    .line 97
    invoke-static {v0, v1, v2, v3, v4}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto/16 :goto_1

    :pswitch_5
    mul-float v3, p5, v12

    sub-float/2addr v1, v3

    mul-float v3, p5, v16

    sub-float v3, p4, v3

    mul-float v2, v2, p5

    .line 110
    invoke-static {v0, v1, v3, v2}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_6
    mul-float v3, p5, v12

    add-float/2addr v1, v3

    mul-float v3, p5, v16

    sub-float v3, p4, v3

    mul-float v2, v2, p5

    .line 112
    invoke-static {v0, v1, v3, v2}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto/16 :goto_1

    :pswitch_7
    mul-float v1, p5, v6

    add-float v1, p1, v1

    mul-float v2, p5, v17

    sub-float v2, p4, v2

    mul-float v3, p5, v5

    .line 102
    invoke-static {v0, v1, v2, v3, v3}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto/16 :goto_1

    :pswitch_8
    mul-float v1, p5, v17

    sub-float v1, p3, v1

    mul-float v2, p5, v14

    add-float v2, p2, v2

    mul-float v3, p5, v8

    mul-float v4, p5, v7

    .line 100
    invoke-static {v0, v1, v2, v3, v4}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto/16 :goto_1

    :pswitch_9
    mul-float v1, p5, v13

    sub-float v1, p3, v1

    const v2, 0x3f19999a    # 0.6f

    mul-float v2, v2, p5

    sub-float v2, p4, v2

    mul-float v3, p5, v18

    .line 108
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_a
    mul-float v1, p5, v17

    add-float v1, p1, v1

    mul-float v2, p5, v14

    add-float v2, p2, v2

    mul-float v3, p5, v8

    mul-float v4, p5, v7

    .line 99
    invoke-static {v0, v1, v2, v3, v4}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    goto :goto_1

    :pswitch_b
    mul-float v1, p5, v6

    add-float v2, p1, v1

    sub-float v1, p4, v1

    mul-float v3, p5, v18

    .line 103
    invoke-static {v0, v2, v1, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_c
    mul-float v1, p5, v13

    sub-float v1, p3, v1

    mul-float v2, p5, v3

    sub-float v2, p4, v2

    mul-float v3, p5, v18

    .line 104
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_d
    const v1, 0x3f2147ae    # 0.63f

    mul-float v1, v1, p5

    sub-float v1, p3, v1

    mul-float v2, p5, v16

    sub-float v2, p4, v2

    mul-float v3, p5, v18

    .line 106
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_e
    mul-float v1, p5, v3

    sub-float v1, p3, v1

    mul-float v2, p5, v16

    sub-float v2, p4, v2

    mul-float v3, p5, v18

    .line 107
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_f
    mul-float v1, p5, v13

    sub-float v1, p3, v1

    const v2, 0x3e428f5c    # 0.19f

    mul-float v2, v2, p5

    sub-float v2, p4, v2

    mul-float v3, p5, v18

    .line 105
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    goto :goto_1

    :pswitch_10
    const v1, 0x3f4ccccd    # 0.8f

    mul-float v1, v1, p5

    sub-float v1, p3, v1

    const v2, 0x3ecccccd    # 0.4f

    mul-float v2, v2, p5

    add-float v2, p2, v2

    mul-float v3, p5, v5

    .line 109
    invoke-static {v0, v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->round(Lcom/cloudpad/controller/Control;FFF)V

    :goto_1
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x36eca8a2 -> :sswitch_10
        0x61 -> :sswitch_f
        0x62 -> :sswitch_e
        0x78 -> :sswitch_d
        0x79 -> :sswitch_c
        0xd47 -> :sswitch_b
        0xd76 -> :sswitch_a
        0xe01 -> :sswitch_9
        0xe30 -> :sswitch_8
        0x2f25af -> :sswitch_7
        0x33155f -> :sswitch_6
        0x373aa5 -> :sswitch_5
        0x59a4b2b -> :sswitch_4
        0x5e23afc -> :sswitch_3
        0x6bdbb5b -> :sswitch_2
        0x5582bc23 -> :sswitch_1
        0x586b8b2a -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static rect(Lcom/cloudpad/controller/Control;FFFF)V
    .locals 0

    .line 123
    iput p1, p0, Lcom/cloudpad/controller/Control;->defaultX:F

    .line 124
    iput p2, p0, Lcom/cloudpad/controller/Control;->defaultY:F

    .line 125
    iput p3, p0, Lcom/cloudpad/controller/Control;->baseWidth:F

    .line 126
    iput p4, p0, Lcom/cloudpad/controller/Control;->baseHeight:F

    return-void
.end method

.method static resetToDefaults(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/cloudpad/controller/Control;",
            ">;)V"
        }
    .end annotation

    .line 152
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cloudpad/controller/Control;

    const/high16 v1, 0x7fc00000    # Float.NaN

    .line 153
    iput v1, v0, Lcom/cloudpad/controller/Control;->userX:F

    .line 154
    iput v1, v0, Lcom/cloudpad/controller/Control;->userY:F

    const/high16 v1, 0x3f800000    # 1.0f

    .line 155
    iput v1, v0, Lcom/cloudpad/controller/Control;->scale:F

    .line 156
    iget-boolean v1, v0, Lcom/cloudpad/controller/Control;->hiddenByDefault:Z

    iput-boolean v1, v0, Lcom/cloudpad/controller/Control;->hidden:Z

    goto :goto_0

    :cond_0
    return-void
.end method

.method private static round(Lcom/cloudpad/controller/Control;FFF)V
    .locals 0

    .line 119
    invoke-static {p0, p1, p2, p3, p3}, Lcom/cloudpad/controller/Layouts;->rect(Lcom/cloudpad/controller/Control;FFFF)V

    return-void
.end method
