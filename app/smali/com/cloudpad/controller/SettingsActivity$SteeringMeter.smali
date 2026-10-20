.class final Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;
.super Landroid/view/View;
.source "SettingsActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cloudpad/controller/SettingsActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "SteeringMeter"
.end annotation


# instance fields
.field private angle:F

.field private available:Z

.field private final density:F

.field private final paint:Landroid/graphics/Paint;

.field private final track:Landroid/graphics/RectF;

.field private value:F


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 3

    .line 346
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 338
    new-instance p1, Landroid/graphics/Paint;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p1, p0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    .line 339
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->track:Landroid/graphics/RectF;

    .line 343
    iput-boolean v0, p0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->available:Z

    .line 347
    invoke-virtual {p0}, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->density:F

    .line 348
    sget-object v0, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 350
    invoke-virtual {p0}, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    const/4 v1, 0x2

    const/high16 v2, 0x41500000    # 13.0f

    .line 349
    invoke-static {v1, v2, v0}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setTextSize(F)V

    return-void
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 16

    move-object/from16 v0, p0

    move-object/from16 v7, p1

    .line 366
    invoke-virtual/range {p0 .. p0}, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->getWidth()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual/range {p0 .. p0}, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->getHeight()I

    move-result v2

    int-to-float v2, v2

    iget v8, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->density:F

    const/high16 v3, 0x41000000    # 8.0f

    mul-float/2addr v3, v8

    const v4, 0x3f1eb852    # 0.62f

    mul-float v9, v2, v4

    const/high16 v2, 0x40000000    # 2.0f

    div-float v10, v1, v2

    const/high16 v4, 0x41100000    # 9.0f

    mul-float v11, v8, v4

    sub-float v4, v10, v11

    .line 370
    iget-boolean v5, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->available:Z

    if-nez v5, :cond_0

    .line 371
    const-string v5, "No tilt sensor on this phone"

    goto :goto_1

    .line 372
    :cond_0
    iget v5, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->value:F

    const/4 v6, 0x0

    cmpl-float v5, v5, v6

    if-nez v5, :cond_1

    .line 373
    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    iget v6, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->angle:F

    invoke-static {v6}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    const-string v12, "Steering test: straight  \u00b7  %.0f\u00b0"

    invoke-static {v5, v12, v6}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    goto :goto_1

    .line 375
    :cond_1
    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    iget v12, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->value:F

    .line 376
    invoke-static {v12}, Ljava/lang/Math;->abs(F)F

    move-result v12

    const/high16 v13, 0x42c80000    # 100.0f

    mul-float/2addr v12, v13

    invoke-static {v12}, Ljava/lang/Math;->round(F)I

    move-result v12

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    iget v13, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->value:F

    cmpg-float v6, v13, v6

    if-gez v6, :cond_2

    const-string v6, "left"

    goto :goto_0

    :cond_2
    const-string v6, "right"

    :goto_0
    iget v13, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->angle:F

    invoke-static {v13}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v13

    filled-new-array {v12, v6, v13}, [Ljava/lang/Object;

    move-result-object v6

    .line 375
    const-string v12, "Steering test: %d%% %s  \u00b7  %.0f\u00b0"

    invoke-static {v5, v12, v6}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 378
    :goto_1
    iget-object v6, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    const v12, -0x746b62

    invoke-virtual {v6, v12}, Landroid/graphics/Paint;->setColor(I)V

    const/high16 v6, 0x41400000    # 12.0f

    mul-float/2addr v6, v8

    sub-float v6, v9, v6

    .line 379
    iget-object v13, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    invoke-virtual {v7, v5, v10, v6, v13}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 381
    iget-object v5, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->track:Landroid/graphics/RectF;

    sub-float/2addr v1, v11

    add-float v13, v9, v3

    invoke-virtual {v5, v11, v9, v1, v13}, Landroid/graphics/RectF;->set(FFFF)V

    .line 382
    iget-object v1, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    const v5, -0xcfc9c3

    invoke-virtual {v1, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 383
    iget-object v1, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->track:Landroid/graphics/RectF;

    div-float v14, v3, v2

    iget-object v2, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v14, v14, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 384
    iget v1, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->value:F

    mul-float/2addr v1, v4

    add-float v15, v10, v1

    .line 385
    iget-object v1, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    const v2, -0xc046b0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 386
    invoke-static {v10, v15}, Ljava/lang/Math;->min(FF)F

    move-result v2

    invoke-static {v10, v15}, Ljava/lang/Math;->max(FF)F

    move-result v4

    iget-object v6, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    move v3, v9

    move v5, v13

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 387
    iget-object v1, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    invoke-virtual {v1, v12}, Landroid/graphics/Paint;->setColor(I)V

    sub-float v2, v10, v8

    const/high16 v1, 0x40800000    # 4.0f

    mul-float/2addr v1, v8

    sub-float v3, v9, v1

    add-float v4, v10, v8

    add-float v5, v13, v1

    .line 388
    iget-object v6, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 389
    iget-object v1, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    const v2, -0x19120d

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    add-float/2addr v9, v14

    .line 390
    iget-object v1, v0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->paint:Landroid/graphics/Paint;

    invoke-virtual {v7, v15, v9, v11, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    return-void
.end method

.method set(FF)V
    .locals 0

    .line 359
    iput p1, p0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->value:F

    .line 360
    iput p2, p0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->angle:F

    .line 361
    invoke-virtual {p0}, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->invalidate()V

    return-void
.end method

.method setAvailable(Z)V
    .locals 0

    .line 354
    iput-boolean p1, p0, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->available:Z

    .line 355
    invoke-virtual {p0}, Lcom/cloudpad/controller/SettingsActivity$SteeringMeter;->invalidate()V

    return-void
.end method
