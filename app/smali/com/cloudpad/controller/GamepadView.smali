.class final Lcom/cloudpad/controller/GamepadView;
.super Landroid/view/View;
.source "GamepadView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cloudpad/controller/GamepadView$Tuning;,
        Lcom/cloudpad/controller/GamepadView$Listener;,
        Lcom/cloudpad/controller/GamepadView$Touch;
    }
.end annotation


# static fields
.field private static final COLOR_AMBER:I = -0x2d66de

.field private static final COLOR_BG:I = -0xf2eee9

.field private static final COLOR_BLUE:I = -0xa75901

.field private static final COLOR_DISABLED:I = -0xb7b0a8

.field private static final COLOR_GREEN:I = -0xc046b0

.field private static final COLOR_KNOB:I = -0xd9d3cc

.field private static final COLOR_KNOB_ACTIVE:I = -0xc2bbb3

.field private static final COLOR_OUTLINE:I = -0xcfc9c3

.field private static final COLOR_OUTLINE_STRONG:I = -0xb7b0a8

.field private static final COLOR_RED:I = -0x7aeb7

.field private static final COLOR_SURFACE:I = -0xe9e4de

.field private static final COLOR_SURFACE_PRESSED:I = -0xcfc9c3

.field private static final COLOR_TEXT:I = -0x19120d

.field private static final COLOR_TEXT_DIM:I = -0x746b62

.field private static final LONG_PRESS_MS:J = 0x258L

.field private static final PRESS_THRESHOLD:F = 0.12f

.field static final STATUS_CONNECTED:I = 0x1

.field static final STATUS_ERROR:I = 0x2

.field static final STATUS_WAITING:I = 0x0

.field private static final TOOL_BIGGER:I = 0x1

.field private static final TOOL_CANCEL:I = 0x4

.field private static final TOOL_COUNT:I = 0x6

.field private static final TOOL_DONE:I = 0x5

.field private static final TOOL_HIDE:I = 0x2

.field private static final TOOL_LABELS:[Ljava/lang/String;

.field private static final TOOL_RESET:I = 0x3

.field private static final TOOL_SMALLER:I


# instance fields
.field private final bold:Landroid/graphics/Typeface;

.field private connected:Z

.field private controls:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/cloudpad/controller/Control;",
            ">;"
        }
    .end annotation
.end field

.field private crossCorner:F

.field private final crossFill:Landroid/graphics/Paint;

.field private final crossPath:Landroid/graphics/Path;

.field private final crossStroke:Landroid/graphics/Paint;

.field private final dashStroke:Landroid/graphics/Paint;

.field private final density:F

.field private dragOffsetX:F

.field private dragOffsetY:F

.field private dragPointer:I

.field private editSnapshot:Ljava/lang/String;

.field private editing:Z

.field private final exclusionRects:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/graphics/Rect;",
            ">;"
        }
    .end annotation
.end field

.field private final fill:Landroid/graphics/Paint;

.field private final fontMetrics:Landroid/graphics/Paint$FontMetrics;

.field private final gridPaint:Landroid/graphics/Paint;

.field private heldButtons:I

.field private final listener:Lcom/cloudpad/controller/GamepadView$Listener;

.field private mode:Ljava/lang/String;

.field private final path:Landroid/graphics/Path;

.field private pinchPointer:I

.field private pinchStartDistance:F

.field private pinchStartScale:F

.field private pressedTool:I

.field private safeBottom:I

.field private safeLeft:I

.field private safeRight:I

.field private safeTop:I

.field private final selectStroke:Landroid/graphics/Paint;

.field private selected:Lcom/cloudpad/controller/Control;

.field private final settingsLongPress:Ljava/lang/Runnable;

.field private settingsPress:Lcom/cloudpad/controller/GamepadView$Touch;

.field private state:Lcom/cloudpad/controller/GamepadState;

.field private statusDetail:Ljava/lang/String;

.field private statusLevel:I

.field private final statusRect:Landroid/graphics/RectF;

.field private statusTitle:Ljava/lang/String;

.field private steering:F

.field private steeringAvailable:Z

.field private final stickOut:[F

.field private final stroke:Landroid/graphics/Paint;

.field private final text:Landroid/text/TextPaint;

.field private final tmp:Landroid/graphics/RectF;

.field private final toolRects:[Landroid/graphics/RectF;

.field private final touches:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray<",
            "Lcom/cloudpad/controller/GamepadView$Touch;",
            ">;"
        }
    .end annotation
.end field

.field private tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

.field private unit:F

.field private final wheelStroke:Landroid/graphics/Paint;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/4 v0, 0x6

    .line 88
    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "\u2212"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "+"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "Hide"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "Reset"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "Cancel"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "Done"

    aput-object v2, v0, v1

    sput-object v0, Lcom/cloudpad/controller/GamepadView;->TOOL_LABELS:[Ljava/lang/String;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;Lcom/cloudpad/controller/GamepadView$Listener;)V
    .locals 13

    .line 160
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 103
    const-string p1, "gamepad"

    iput-object p1, p0, Lcom/cloudpad/controller/GamepadView;->mode:Ljava/lang/String;

    .line 104
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    .line 105
    new-instance p1, Lcom/cloudpad/controller/GamepadView$Tuning;

    invoke-direct {p1}, Lcom/cloudpad/controller/GamepadView$Tuning;-><init>()V

    iput-object p1, p0, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    const/4 p1, 0x1

    .line 107
    iput-boolean p1, p0, Lcom/cloudpad/controller/GamepadView;->steeringAvailable:Z

    .line 109
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcom/cloudpad/controller/GamepadView;->touches:Landroid/util/SparseArray;

    .line 110
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/cloudpad/controller/GamepadView;->statusRect:Landroid/graphics/RectF;

    const/4 v0, 0x0

    .line 111
    iput v0, p0, Lcom/cloudpad/controller/GamepadView;->statusLevel:I

    .line 112
    const-string v1, "Starting\u2026"

    iput-object v1, p0, Lcom/cloudpad/controller/GamepadView;->statusTitle:Ljava/lang/String;

    .line 116
    new-instance v1, Lcom/cloudpad/controller/GamepadState;

    invoke-direct {v1}, Lcom/cloudpad/controller/GamepadState;-><init>()V

    iput-object v1, p0, Lcom/cloudpad/controller/GamepadView;->state:Lcom/cloudpad/controller/GamepadState;

    .line 124
    const-string v1, ""

    iput-object v1, p0, Lcom/cloudpad/controller/GamepadView;->editSnapshot:Ljava/lang/String;

    const/4 v1, -0x1

    .line 125
    iput v1, p0, Lcom/cloudpad/controller/GamepadView;->dragPointer:I

    .line 126
    iput v1, p0, Lcom/cloudpad/controller/GamepadView;->pinchPointer:I

    .line 129
    iput v1, p0, Lcom/cloudpad/controller/GamepadView;->pressedTool:I

    const/4 v1, 0x6

    .line 130
    new-array v2, v1, [Landroid/graphics/RectF;

    iput-object v2, p0, Lcom/cloudpad/controller/GamepadView;->toolRects:[Landroid/graphics/RectF;

    .line 134
    new-instance v2, Lcom/cloudpad/controller/GamepadView$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0}, Lcom/cloudpad/controller/GamepadView$$ExternalSyntheticLambda0;-><init>(Lcom/cloudpad/controller/GamepadView;)V

    iput-object v2, p0, Lcom/cloudpad/controller/GamepadView;->settingsLongPress:Ljava/lang/Runnable;

    .line 141
    new-instance v2, Landroid/graphics/Paint;

    invoke-direct {v2, p1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v2, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    .line 142
    new-instance v3, Landroid/graphics/Paint;

    invoke-direct {v3, p1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v3, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    .line 143
    new-instance v4, Landroid/graphics/Paint;

    invoke-direct {v4, p1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v4, p0, Lcom/cloudpad/controller/GamepadView;->wheelStroke:Landroid/graphics/Paint;

    .line 144
    new-instance v5, Landroid/graphics/Paint;

    invoke-direct {v5, p1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v5, p0, Lcom/cloudpad/controller/GamepadView;->crossFill:Landroid/graphics/Paint;

    .line 145
    new-instance v6, Landroid/graphics/Paint;

    invoke-direct {v6, p1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v6, p0, Lcom/cloudpad/controller/GamepadView;->crossStroke:Landroid/graphics/Paint;

    .line 146
    new-instance v7, Landroid/graphics/Paint;

    invoke-direct {v7, p1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v7, p0, Lcom/cloudpad/controller/GamepadView;->dashStroke:Landroid/graphics/Paint;

    .line 147
    new-instance v8, Landroid/graphics/Paint;

    invoke-direct {v8, p1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v8, p0, Lcom/cloudpad/controller/GamepadView;->selectStroke:Landroid/graphics/Paint;

    .line 148
    new-instance v9, Landroid/graphics/Paint;

    invoke-direct {v9}, Landroid/graphics/Paint;-><init>()V

    iput-object v9, p0, Lcom/cloudpad/controller/GamepadView;->gridPaint:Landroid/graphics/Paint;

    .line 149
    new-instance v10, Landroid/text/TextPaint;

    invoke-direct {v10, p1}, Landroid/text/TextPaint;-><init>(I)V

    iput-object v10, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    .line 150
    new-instance v11, Landroid/graphics/Paint$FontMetrics;

    invoke-direct {v11}, Landroid/graphics/Paint$FontMetrics;-><init>()V

    iput-object v11, p0, Lcom/cloudpad/controller/GamepadView;->fontMetrics:Landroid/graphics/Paint$FontMetrics;

    .line 151
    sget-object v11, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    invoke-static {v11, p1}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v11

    iput-object v11, p0, Lcom/cloudpad/controller/GamepadView;->bold:Landroid/graphics/Typeface;

    .line 152
    new-instance v11, Landroid/graphics/Path;

    invoke-direct {v11}, Landroid/graphics/Path;-><init>()V

    iput-object v11, p0, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    .line 153
    new-instance v11, Landroid/graphics/Path;

    invoke-direct {v11}, Landroid/graphics/Path;-><init>()V

    iput-object v11, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    .line 154
    new-instance v11, Landroid/graphics/RectF;

    invoke-direct {v11}, Landroid/graphics/RectF;-><init>()V

    iput-object v11, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    const/4 v11, 0x2

    .line 155
    new-array v12, v11, [F

    iput-object v12, p0, Lcom/cloudpad/controller/GamepadView;->stickOut:[F

    .line 156
    new-instance v12, Ljava/util/ArrayList;

    invoke-direct {v12}, Ljava/util/ArrayList;-><init>()V

    iput-object v12, p0, Lcom/cloudpad/controller/GamepadView;->exclusionRects:Ljava/util/List;

    const/high16 v12, -0x40800000    # -1.0f

    .line 157
    iput v12, p0, Lcom/cloudpad/controller/GamepadView;->crossCorner:F

    .line 161
    iput-object p2, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    .line 162
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p2

    iget p2, p2, Landroid/util/DisplayMetrics;->density:F

    iput p2, p0, Lcom/cloudpad/controller/GamepadView;->density:F

    .line 163
    sget-object v12, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v12}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 164
    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v3, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    const/high16 v2, 0x40000000    # 2.0f

    mul-float v12, p2, v2

    .line 165
    invoke-virtual {v3, v12}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 166
    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v4, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 167
    sget-object v3, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v4, v3}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 168
    sget-object v3, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v5, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 169
    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v6, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    mul-float/2addr v2, p2

    .line 170
    invoke-virtual {v6, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 171
    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v7, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    const/high16 v2, 0x3fc00000    # 1.5f

    mul-float/2addr v2, p2

    .line 172
    invoke-virtual {v7, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    const v2, -0x66000001

    .line 173
    invoke-virtual {v7, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 174
    new-instance v2, Landroid/graphics/DashPathEffect;

    const/high16 v3, 0x40c00000    # 6.0f

    mul-float/2addr v3, p2

    const/high16 v4, 0x40a00000    # 5.0f

    mul-float/2addr v4, p2

    new-array v5, v11, [F

    aput v3, v5, v0

    aput v4, v5, p1

    const/4 p1, 0x0

    invoke-direct {v2, v5, p1}, Landroid/graphics/DashPathEffect;-><init>([FF)V

    invoke-virtual {v7, v2}, Landroid/graphics/Paint;->setPathEffect(Landroid/graphics/PathEffect;)Landroid/graphics/PathEffect;

    .line 175
    sget-object p1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v8, p1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    const/high16 p1, 0x40400000    # 3.0f

    mul-float/2addr p2, p1

    .line 176
    invoke-virtual {v8, p2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    const p1, -0xa75901

    .line 177
    invoke-virtual {v8, p1}, Landroid/graphics/Paint;->setColor(I)V

    const p1, 0xfffffff

    .line 178
    invoke-virtual {v9, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 179
    sget-object p1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v10, p1}, Landroid/text/TextPaint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    move p1, v0

    :goto_0
    if-ge p1, v1, :cond_0

    .line 180
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->toolRects:[Landroid/graphics/RectF;

    new-instance v2, Landroid/graphics/RectF;

    invoke-direct {v2}, Landroid/graphics/RectF;-><init>()V

    aput-object v2, p2, p1

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 181
    :cond_0
    invoke-virtual {p0, v0}, Lcom/cloudpad/controller/GamepadView;->setHapticFeedbackEnabled(Z)V

    return-void
.end method

.method private addExclusion(Lcom/cloudpad/controller/Control;IZ)V
    .locals 4

    if-eqz p1, :cond_2

    .line 349
    iget-boolean v0, p1, Lcom/cloudpad/controller/Control;->hidden:Z

    if-eqz v0, :cond_0

    goto :goto_0

    .line 350
    :cond_0
    iget v0, p1, Lcom/cloudpad/controller/Control;->cy:F

    float-to-int v0, v0

    if-eqz p3, :cond_1

    .line 352
    iget-object p3, p0, Lcom/cloudpad/controller/GamepadView;->exclusionRects:Ljava/util/List;

    new-instance v1, Landroid/graphics/Rect;

    sub-int v2, v0, p2

    iget-object p1, p1, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->right:F

    float-to-int p1, p1

    add-int/2addr v0, p2

    const/4 p2, 0x0

    invoke-direct {v1, p2, v2, p1, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-interface {p3, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 354
    :cond_1
    iget-object p3, p0, Lcom/cloudpad/controller/GamepadView;->exclusionRects:Ljava/util/List;

    new-instance v1, Landroid/graphics/Rect;

    iget-object p1, p1, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->left:F

    float-to-int p1, p1

    sub-int v2, v0, p2

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v3

    add-int/2addr v0, p2

    invoke-direct {v1, p1, v2, v3, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-interface {p3, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    :goto_0
    return-void
.end method

.method private buttonAt(FFF)Lcom/cloudpad/controller/Control;
    .locals 6

    .line 520
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x0

    const v2, 0x7f7fffff    # Float.MAX_VALUE

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/cloudpad/controller/Control;

    .line 521
    iget-boolean v4, v3, Lcom/cloudpad/controller/Control;->hidden:Z

    if-nez v4, :cond_0

    iget v4, v3, Lcom/cloudpad/controller/Control;->kind:I

    if-eqz v4, :cond_1

    iget v4, v3, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v5, 0x1

    if-eq v4, v5, :cond_1

    goto :goto_0

    .line 522
    :cond_1
    invoke-virtual {v3, p1, p2, p3}, Lcom/cloudpad/controller/Control;->hit(FFF)Z

    move-result v4

    if-nez v4, :cond_2

    goto :goto_0

    .line 523
    :cond_2
    invoke-virtual {v3, p1, p2}, Lcom/cloudpad/controller/Control;->distance2(FF)F

    move-result v4

    cmpg-float v5, v4, v2

    if-gez v5, :cond_0

    move-object v1, v3

    move v2, v4

    goto :goto_0

    :cond_3
    return-object v1
.end method

.method private static clampRange(FFF)F
    .locals 1

    cmpg-float v0, p2, p1

    if-gez v0, :cond_0

    add-float/2addr p1, p2

    const/high16 p0, 0x40000000    # 2.0f

    div-float/2addr p1, p0

    return p1

    :cond_0
    cmpg-float v0, p0, p1

    if-gez v0, :cond_1

    move p0, p1

    goto :goto_0

    :cond_1
    cmpl-float p1, p0, p2

    if-lez p1, :cond_2

    move p0, p2

    :cond_2
    :goto_0
    return p0
.end method

.method private clearTouches()V
    .locals 2

    .line 510
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->touches:Landroid/util/SparseArray;

    invoke-virtual {v0}, Landroid/util/SparseArray;->clear()V

    .line 511
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->settingsLongPress:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Lcom/cloudpad/controller/GamepadView;->removeCallbacks(Ljava/lang/Runnable;)Z

    const/4 v0, 0x0

    .line 512
    iput-object v0, p0, Lcom/cloudpad/controller/GamepadView;->settingsPress:Lcom/cloudpad/controller/GamepadView$Touch;

    .line 513
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cloudpad/controller/Control;

    invoke-virtual {v1}, Lcom/cloudpad/controller/Control;->release()V

    goto :goto_0

    :cond_0
    return-void
.end method

.method private static distance(FFFF)F
    .locals 2

    sub-float/2addr p0, p2

    float-to-double v0, p0

    sub-float/2addr p1, p3

    float-to-double p0, p1

    .line 814
    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->hypot(DD)D

    move-result-wide p0

    double-to-float p0, p0

    return p0
.end method

.method private static dpadMask(Lcom/cloudpad/controller/Control;FF)I
    .locals 5

    .line 582
    iget v0, p0, Lcom/cloudpad/controller/Control;->cx:F

    sub-float/2addr p1, v0

    iget v0, p0, Lcom/cloudpad/controller/Control;->cy:F

    sub-float/2addr p2, v0

    iget p0, p0, Lcom/cloudpad/controller/Control;->width:F

    const/high16 v0, 0x40000000    # 2.0f

    div-float/2addr p0, v0

    const v0, 0x3e3851ec    # 0.18f

    mul-float/2addr p0, v0

    mul-float v0, p1, p1

    mul-float v1, p2, p2

    add-float/2addr v0, v1

    mul-float/2addr p0, p0

    cmpg-float p0, v0, p0

    if-gez p0, :cond_0

    const/4 p0, 0x0

    return p0

    :cond_0
    float-to-double v0, p2

    float-to-double p0, p1

    .line 584
    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide p0

    const-wide/16 v0, 0x0

    cmpg-double p2, p0, v0

    if-gez p2, :cond_1

    const-wide v0, 0x4076800000000000L    # 360.0

    add-double/2addr p0, v0

    :cond_1
    const/16 p2, 0xc

    .line 586
    invoke-static {p2}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result p2

    const/16 v0, 0xd

    invoke-static {v0}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v0

    const/16 v1, 0xe

    .line 587
    invoke-static {v1}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v1

    const/16 v2, 0xf

    invoke-static {v2}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v2

    const-wide/high16 v3, 0x403e000000000000L    # 30.0

    cmpg-double v3, p0, v3

    if-ltz v3, :cond_9

    const-wide v3, 0x4074a00000000000L    # 330.0

    cmpl-double v3, p0, v3

    if-ltz v3, :cond_2

    goto :goto_0

    :cond_2
    const-wide/high16 v3, 0x404e000000000000L    # 60.0

    cmpg-double v3, p0, v3

    if-gez v3, :cond_3

    or-int p0, v2, v0

    return p0

    :cond_3
    const-wide/high16 v3, 0x405e000000000000L    # 120.0

    cmpg-double v3, p0, v3

    if-gez v3, :cond_4

    return v0

    :cond_4
    const-wide v3, 0x4062c00000000000L    # 150.0

    cmpg-double v3, p0, v3

    if-gez v3, :cond_5

    or-int p0, v0, v1

    return p0

    :cond_5
    const-wide v3, 0x406a400000000000L    # 210.0

    cmpg-double v0, p0, v3

    if-gez v0, :cond_6

    return v1

    :cond_6
    const-wide/high16 v3, 0x406e000000000000L    # 240.0

    cmpg-double v0, p0, v3

    if-gez v0, :cond_7

    or-int p0, v1, p2

    return p0

    :cond_7
    const-wide v0, 0x4072c00000000000L    # 300.0

    cmpg-double p0, p0, v0

    if-gez p0, :cond_8

    return p2

    :cond_8
    or-int p0, p2, v2

    return p0

    :cond_9
    :goto_0
    return v2
.end method

.method private drawArrow(Landroid/graphics/Canvas;FFFZF)V
    .locals 2

    .line 982
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 983
    invoke-virtual {p1, p4, p2, p3}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 984
    iget-object p4, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    invoke-virtual {p4}, Landroid/graphics/Path;->reset()V

    .line 985
    iget-object p4, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    sub-float v0, p3, p6

    invoke-virtual {p4, p2, v0}, Landroid/graphics/Path;->moveTo(FF)V

    .line 986
    iget-object p4, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    add-float v0, p2, p6

    const v1, 0x3f19999a    # 0.6f

    mul-float/2addr v1, p6

    add-float/2addr p3, v1

    invoke-virtual {p4, v0, p3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 987
    iget-object p4, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    sub-float/2addr p2, p6

    invoke-virtual {p4, p2, p3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 988
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    invoke-virtual {p2}, Landroid/graphics/Path;->close()V

    .line 989
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    if-eqz p5, :cond_0

    const p3, -0x19120d

    goto :goto_0

    :cond_0
    const p3, -0x746b62

    :goto_0
    invoke-virtual {p2, p3}, Landroid/graphics/Paint;->setColor(I)V

    .line 990
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    iget-object p3, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, p3}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 991
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    return-void
.end method

.method private drawButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 2

    .line 884
    iget v0, p2, Lcom/cloudpad/controller/Control;->style:I

    if-eqz v0, :cond_3

    const/4 v1, 0x2

    if-eq v0, v1, :cond_2

    const/4 v1, 0x3

    if-eq v0, v1, :cond_1

    const/4 v1, 0x4

    if-eq v0, v1, :cond_0

    .line 898
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawSmallButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_0

    .line 895
    :cond_0
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawGuideButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_0

    .line 892
    :cond_1
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawMenuButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_0

    .line 889
    :cond_2
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawViewButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_0

    .line 886
    :cond_3
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawFaceButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    :goto_0
    return-void
.end method

.method private drawControl(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 8

    .line 842
    iget-boolean v0, p2, Lcom/cloudpad/controller/Control;->hidden:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    if-nez v0, :cond_0

    return-void

    .line 844
    :cond_0
    iget-boolean v0, p2, Lcom/cloudpad/controller/Control;->hidden:Z

    if-eqz v0, :cond_1

    const v0, 0x3da3d70a    # 0.08f

    .line 846
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v1, v0

    .line 847
    iget-object v0, p2, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->left:F

    sub-float v3, v0, v1

    iget-object v0, p2, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->top:F

    sub-float v4, v0, v1

    iget-object v0, p2, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->right:F

    add-float v5, v0, v1

    iget-object v0, p2, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->bottom:F

    add-float v6, v0, v1

    const/16 v7, 0x46

    move-object v2, p1

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->saveLayerAlpha(FFFFI)I

    move-result v0

    goto :goto_0

    :cond_1
    const/4 v0, -0x1

    .line 850
    :goto_0
    iget v1, p2, Lcom/cloudpad/controller/Control;->kind:I

    packed-switch v1, :pswitch_data_0

    goto :goto_1

    .line 870
    :pswitch_0
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawSettings(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_1

    .line 867
    :pswitch_1
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawWheel(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_1

    .line 864
    :pswitch_2
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawPedal(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_1

    .line 861
    :pswitch_3
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawDpad(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_1

    .line 858
    :pswitch_4
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawStick(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_1

    .line 855
    :pswitch_5
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawShoulder(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_1

    .line 852
    :pswitch_6
    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    :goto_1
    if-ltz v0, :cond_2

    .line 875
    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->restoreToCount(I)V

    .line 876
    :cond_2
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    if-eqz v0, :cond_3

    invoke-direct {p0, p1, p2}, Lcom/cloudpad/controller/GamepadView;->drawEditOutline(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    :cond_3
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private drawDpad(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 25

    move-object/from16 v7, p0

    move-object/from16 v8, p1

    move-object/from16 v0, p2

    .line 931
    iget v1, v0, Lcom/cloudpad/controller/Control;->width:F

    const/high16 v2, 0x40000000    # 2.0f

    div-float v6, v1, v2

    const v1, 0x3ea3d70a    # 0.32f

    mul-float/2addr v1, v6

    iget v9, v0, Lcom/cloudpad/controller/Control;->cx:F

    iget v10, v0, Lcom/cloudpad/controller/Control;->cy:F

    .line 932
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    invoke-virtual {v2}, Landroid/graphics/Path;->reset()V

    .line 933
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    sub-float v11, v9, v1

    sub-float v3, v10, v6

    invoke-virtual {v2, v11, v3}, Landroid/graphics/Path;->moveTo(FF)V

    .line 934
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    add-float v12, v9, v1

    invoke-virtual {v2, v12, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 935
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    sub-float v13, v10, v1

    invoke-virtual {v2, v12, v13}, Landroid/graphics/Path;->lineTo(FF)V

    .line 936
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    add-float v14, v9, v6

    invoke-virtual {v2, v14, v13}, Landroid/graphics/Path;->lineTo(FF)V

    .line 937
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    add-float v15, v10, v1

    invoke-virtual {v2, v14, v15}, Landroid/graphics/Path;->lineTo(FF)V

    .line 938
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    invoke-virtual {v2, v12, v15}, Landroid/graphics/Path;->lineTo(FF)V

    .line 939
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    add-float v5, v10, v6

    invoke-virtual {v2, v12, v5}, Landroid/graphics/Path;->lineTo(FF)V

    .line 940
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    invoke-virtual {v2, v11, v5}, Landroid/graphics/Path;->lineTo(FF)V

    .line 941
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    invoke-virtual {v2, v11, v15}, Landroid/graphics/Path;->lineTo(FF)V

    .line 942
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    sub-float v4, v9, v6

    invoke-virtual {v2, v4, v15}, Landroid/graphics/Path;->lineTo(FF)V

    .line 943
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    invoke-virtual {v2, v4, v13}, Landroid/graphics/Path;->lineTo(FF)V

    .line 944
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    invoke-virtual {v2, v11, v13}, Landroid/graphics/Path;->lineTo(FF)V

    .line 945
    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    invoke-virtual {v2}, Landroid/graphics/Path;->close()V

    const v2, 0x3ee66666    # 0.45f

    mul-float/2addr v1, v2

    .line 947
    iget v2, v7, Lcom/cloudpad/controller/GamepadView;->crossCorner:F

    cmpl-float v2, v1, v2

    if-eqz v2, :cond_0

    .line 948
    iput v1, v7, Lcom/cloudpad/controller/GamepadView;->crossCorner:F

    .line 949
    new-instance v2, Landroid/graphics/CornerPathEffect;

    invoke-direct {v2, v1}, Landroid/graphics/CornerPathEffect;-><init>(F)V

    .line 950
    iget-object v1, v7, Lcom/cloudpad/controller/GamepadView;->crossFill:Landroid/graphics/Paint;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setPathEffect(Landroid/graphics/PathEffect;)Landroid/graphics/PathEffect;

    .line 951
    iget-object v1, v7, Lcom/cloudpad/controller/GamepadView;->crossStroke:Landroid/graphics/Paint;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setPathEffect(Landroid/graphics/PathEffect;)Landroid/graphics/PathEffect;

    .line 953
    :cond_0
    iget-object v1, v7, Lcom/cloudpad/controller/GamepadView;->crossFill:Landroid/graphics/Paint;

    const v2, -0xe9e4de

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 954
    iget-object v1, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    iget-object v2, v7, Lcom/cloudpad/controller/GamepadView;->crossFill:Landroid/graphics/Paint;

    invoke-virtual {v8, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 956
    iget v2, v0, Lcom/cloudpad/controller/Control;->mask:I

    const/16 v0, 0xc

    .line 957
    invoke-static {v0}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v0

    and-int/2addr v0, v2

    const/4 v1, 0x1

    const/16 v16, 0x0

    if-eqz v0, :cond_1

    move/from16 v17, v1

    goto :goto_0

    :cond_1
    move/from16 v17, v16

    :goto_0
    const/16 v0, 0xd

    .line 958
    invoke-static {v0}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v0

    and-int/2addr v0, v2

    if-eqz v0, :cond_2

    move/from16 v18, v1

    goto :goto_1

    :cond_2
    move/from16 v18, v16

    :goto_1
    const/16 v0, 0xe

    .line 959
    invoke-static {v0}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v0

    and-int/2addr v0, v2

    if-eqz v0, :cond_3

    move/from16 v19, v1

    goto :goto_2

    :cond_3
    move/from16 v19, v16

    :goto_2
    const/16 v0, 0xf

    .line 960
    invoke-static {v0}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v0

    and-int/2addr v0, v2

    if-eqz v0, :cond_4

    move/from16 v16, v1

    :cond_4
    const v1, -0xcfc9c3

    if-eqz v2, :cond_9

    .line 962
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->save()I

    .line 963
    iget-object v0, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    invoke-virtual {v8, v0}, Landroid/graphics/Canvas;->clipPath(Landroid/graphics/Path;)Z

    .line 964
    iget-object v0, v7, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    if-eqz v17, :cond_5

    .line 965
    iget-object v0, v7, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    move-object/from16 v20, v0

    move-object/from16 v0, p1

    move/from16 v21, v1

    move v1, v11

    move/from16 v22, v2

    move v2, v3

    move v3, v12

    move/from16 v23, v4

    move v4, v10

    move/from16 v24, v5

    move-object/from16 v5, v20

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    goto :goto_3

    :cond_5
    move/from16 v21, v1

    move/from16 v22, v2

    move/from16 v23, v4

    move/from16 v24, v5

    :goto_3
    if-eqz v18, :cond_6

    .line 966
    iget-object v5, v7, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    move v1, v11

    move v2, v10

    move v3, v12

    move/from16 v4, v24

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    :cond_6
    if-eqz v19, :cond_7

    .line 967
    iget-object v5, v7, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    move/from16 v1, v23

    move v2, v13

    move v3, v9

    move v4, v15

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    :cond_7
    if-eqz v16, :cond_8

    .line 968
    iget-object v5, v7, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    move v1, v9

    move v2, v13

    move v3, v14

    move v4, v15

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 969
    :cond_8
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->restore()V

    goto :goto_4

    :cond_9
    move/from16 v21, v1

    move/from16 v22, v2

    .line 971
    :goto_4
    iget-object v0, v7, Lcom/cloudpad/controller/GamepadView;->crossStroke:Landroid/graphics/Paint;

    if-eqz v22, :cond_a

    const v1, -0xb7b0a8

    goto :goto_5

    :cond_a
    move/from16 v1, v21

    :goto_5
    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 972
    iget-object v0, v7, Lcom/cloudpad/controller/GamepadView;->crossPath:Landroid/graphics/Path;

    iget-object v1, v7, Lcom/cloudpad/controller/GamepadView;->crossStroke:Landroid/graphics/Paint;

    invoke-virtual {v8, v0, v1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    const v0, 0x3f28f5c3    # 0.66f

    mul-float v11, v6, v0

    const v0, 0x3e051eb8    # 0.13f

    mul-float v12, v6, v0

    sub-float v3, v10, v11

    const/4 v4, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v9

    move/from16 v5, v17

    move v6, v12

    .line 975
    invoke-direct/range {v0 .. v6}, Lcom/cloudpad/controller/GamepadView;->drawArrow(Landroid/graphics/Canvas;FFFZF)V

    add-float v2, v9, v11

    const/high16 v4, 0x42b40000    # 90.0f

    move v3, v10

    move/from16 v5, v16

    .line 976
    invoke-direct/range {v0 .. v6}, Lcom/cloudpad/controller/GamepadView;->drawArrow(Landroid/graphics/Canvas;FFFZF)V

    add-float v3, v10, v11

    const/high16 v4, 0x43340000    # 180.0f

    move v2, v9

    move/from16 v5, v18

    .line 977
    invoke-direct/range {v0 .. v6}, Lcom/cloudpad/controller/GamepadView;->drawArrow(Landroid/graphics/Canvas;FFFZF)V

    sub-float v2, v9, v11

    const/high16 v4, 0x43870000    # 270.0f

    move v3, v10

    move/from16 v5, v19

    .line 978
    invoke-direct/range {v0 .. v6}, Lcom/cloudpad/controller/GamepadView;->drawArrow(Landroid/graphics/Canvas;FFFZF)V

    return-void
.end method

.method private drawEditOutline(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 4

    .line 1174
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    if-ne p2, v0, :cond_0

    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->selectStroke:Landroid/graphics/Paint;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->dashStroke:Landroid/graphics/Paint;

    :goto_0
    const v1, 0x3c449ba6    # 0.012f

    .line 1175
    iget v2, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v2, v1

    .line 1176
    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->isRound()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1177
    iget v1, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v3, p2, Lcom/cloudpad/controller/Control;->cy:F

    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result p2

    add-float/2addr p2, v2

    invoke-virtual {p1, v1, v3, p2, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    goto :goto_1

    .line 1179
    :cond_1
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    iget-object p2, p2, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    invoke-virtual {v1, p2}, Landroid/graphics/RectF;->set(Landroid/graphics/RectF;)V

    .line 1180
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    neg-float v1, v2

    invoke-virtual {p2, v1, v1}, Landroid/graphics/RectF;->inset(FF)V

    .line 1181
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    invoke-virtual {p2}, Landroid/graphics/RectF;->width()F

    move-result p2

    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v1

    invoke-static {p2, v1}, Ljava/lang/Math;->min(FF)F

    move-result p2

    const/high16 v1, 0x3e800000    # 0.25f

    mul-float/2addr p2, v1

    .line 1182
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    invoke-virtual {p1, v1, p2, p2, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    :goto_1
    return-void
.end method

.method private drawFaceButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 9

    .line 995
    invoke-direct {p0, p2}, Lcom/cloudpad/controller/GamepadView;->pressed(Lcom/cloudpad/controller/Control;)Z

    move-result v0

    .line 996
    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v6

    .line 997
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    if-eqz v0, :cond_0

    iget v2, p2, Lcom/cloudpad/controller/Control;->accent:I

    goto :goto_0

    :cond_0
    const v2, -0xe9e4de

    :goto_0
    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 998
    iget v1, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v2, p2, Lcom/cloudpad/controller/Control;->cy:F

    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v6, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 999
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    iget v2, p2, Lcom/cloudpad/controller/Control;->accent:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 1000
    iget v1, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v2, p2, Lcom/cloudpad/controller/Control;->cy:F

    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v6, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1001
    iget-object v3, p2, Lcom/cloudpad/controller/Control;->label:Ljava/lang/String;

    iget v4, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v5, p2, Lcom/cloudpad/controller/Control;->cy:F

    if-eqz v0, :cond_1

    const p2, -0xf2eee9

    goto :goto_1

    :cond_1
    iget p2, p2, Lcom/cloudpad/controller/Control;->accent:I

    :goto_1
    move v7, p2

    iget-object v8, p0, Lcom/cloudpad/controller/GamepadView;->bold:Landroid/graphics/Typeface;

    move-object v1, p0

    move-object v2, p1

    invoke-direct/range {v1 .. v8}, Lcom/cloudpad/controller/GamepadView;->drawLabel(Landroid/graphics/Canvas;Ljava/lang/String;FFFILandroid/graphics/Typeface;)V

    return-void
.end method

.method private drawGrid(Landroid/graphics/Canvas;)V
    .locals 8

    const v0, 0x3dcccccd    # 0.1f

    .line 1168
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v1, v0

    move v0, v1

    .line 1169
    :goto_0
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    cmpg-float v2, v0, v2

    if-gez v2, :cond_0

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getHeight()I

    move-result v2

    int-to-float v6, v2

    iget-object v7, p0, Lcom/cloudpad/controller/GamepadView;->gridPaint:Landroid/graphics/Paint;

    const/4 v4, 0x0

    move-object v2, p1

    move v3, v0

    move v5, v0

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    add-float/2addr v0, v1

    goto :goto_0

    :cond_0
    move v0, v1

    .line 1170
    :goto_1
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getHeight()I

    move-result v2

    int-to-float v2, v2

    cmpg-float v2, v0, v2

    if-gez v2, :cond_1

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v2

    int-to-float v5, v2

    iget-object v7, p0, Lcom/cloudpad/controller/GamepadView;->gridPaint:Landroid/graphics/Paint;

    const/4 v3, 0x0

    move-object v2, p1

    move v4, v0

    move v6, v0

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    add-float/2addr v0, v1

    goto :goto_1

    :cond_1
    return-void
.end method

.method private drawGuideButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 7

    .line 1047
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->connected:Z

    if-eqz v0, :cond_0

    const v0, -0xc046b0

    goto :goto_0

    :cond_0
    const v0, -0xb7b0a8

    :goto_0
    invoke-direct {p0, p1, p2, v0}, Lcom/cloudpad/controller/GamepadView;->drawRoundBase(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;I)V

    .line 1048
    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v0

    const v1, 0x3ed70a3d    # 0.42f

    mul-float/2addr v0, v1

    .line 1049
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-direct {p0, p2}, Lcom/cloudpad/controller/GamepadView;->pressed(Lcom/cloudpad/controller/Control;)Z

    move-result v2

    if-eqz v2, :cond_1

    const v2, -0x19120d

    goto :goto_1

    :cond_1
    const v2, -0x746b62

    :goto_1
    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 1050
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    invoke-virtual {v1}, Landroid/graphics/Path;->reset()V

    .line 1051
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    iget v2, p2, Lcom/cloudpad/controller/Control;->cx:F

    sub-float/2addr v2, v0

    iget v3, p2, Lcom/cloudpad/controller/Control;->cy:F

    const v4, 0x3d4ccccd    # 0.05f

    mul-float/2addr v4, v0

    sub-float/2addr v3, v4

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->moveTo(FF)V

    .line 1052
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    iget v2, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v3, p2, Lcom/cloudpad/controller/Control;->cy:F

    const v5, 0x3f733333    # 0.95f

    mul-float/2addr v5, v0

    sub-float/2addr v3, v5

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 1053
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    iget v2, p2, Lcom/cloudpad/controller/Control;->cx:F

    add-float/2addr v2, v0

    iget v3, p2, Lcom/cloudpad/controller/Control;->cy:F

    sub-float/2addr v3, v4

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 1054
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    iget v2, p2, Lcom/cloudpad/controller/Control;->cx:F

    const v3, 0x3f3851ec    # 0.72f

    mul-float/2addr v3, v0

    sub-float/2addr v2, v3

    iget v4, p2, Lcom/cloudpad/controller/Control;->cy:F

    const v5, 0x3e99999a    # 0.3f

    mul-float/2addr v5, v0

    sub-float/2addr v4, v5

    invoke-virtual {v1, v2, v4}, Landroid/graphics/Path;->moveTo(FF)V

    .line 1055
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    iget v2, p2, Lcom/cloudpad/controller/Control;->cx:F

    sub-float/2addr v2, v3

    iget v4, p2, Lcom/cloudpad/controller/Control;->cy:F

    const v6, 0x3f59999a    # 0.85f

    mul-float/2addr v0, v6

    add-float/2addr v4, v0

    invoke-virtual {v1, v2, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 1056
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    iget v2, p2, Lcom/cloudpad/controller/Control;->cx:F

    add-float/2addr v2, v3

    iget v4, p2, Lcom/cloudpad/controller/Control;->cy:F

    add-float/2addr v4, v0

    invoke-virtual {v1, v2, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 1057
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    iget v1, p2, Lcom/cloudpad/controller/Control;->cx:F

    add-float/2addr v1, v3

    iget p2, p2, Lcom/cloudpad/controller/Control;->cy:F

    sub-float/2addr p2, v5

    invoke-virtual {v0, v1, p2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 1058
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->path:Landroid/graphics/Path;

    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, v0}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    return-void
.end method

.method private drawLabel(Landroid/graphics/Canvas;Ljava/lang/String;FFFILandroid/graphics/Typeface;)V
    .locals 1

    if-nez p2, :cond_0

    return-void

    .line 1220
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {v0, p7}, Landroid/text/TextPaint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 1221
    iget-object p7, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {p7, p5}, Landroid/text/TextPaint;->setTextSize(F)V

    .line 1222
    iget-object p5, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {p5, p6}, Landroid/text/TextPaint;->setColor(I)V

    .line 1223
    iget-object p5, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    iget-object p6, p0, Lcom/cloudpad/controller/GamepadView;->fontMetrics:Landroid/graphics/Paint$FontMetrics;

    invoke-virtual {p5, p6}, Landroid/text/TextPaint;->getFontMetrics(Landroid/graphics/Paint$FontMetrics;)F

    .line 1224
    iget-object p5, p0, Lcom/cloudpad/controller/GamepadView;->fontMetrics:Landroid/graphics/Paint$FontMetrics;

    iget p5, p5, Landroid/graphics/Paint$FontMetrics;->ascent:F

    iget-object p6, p0, Lcom/cloudpad/controller/GamepadView;->fontMetrics:Landroid/graphics/Paint$FontMetrics;

    iget p6, p6, Landroid/graphics/Paint$FontMetrics;->descent:F

    add-float/2addr p5, p6

    const/high16 p6, 0x40000000    # 2.0f

    div-float/2addr p5, p6

    sub-float/2addr p4, p5

    iget-object p5, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {p1, p2, p3, p4, p5}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    return-void
.end method

.method private drawMenuButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 10

    const v0, -0xcfc9c3

    .line 1037
    invoke-direct {p0, p1, p2, v0}, Lcom/cloudpad/controller/GamepadView;->drawRoundBase(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;I)V

    .line 1038
    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v0

    const v1, 0x3ed70a3d    # 0.42f

    mul-float/2addr v0, v1

    const v1, 0x3f1eb852    # 0.62f

    mul-float/2addr v1, v0

    .line 1039
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-direct {p0, p2}, Lcom/cloudpad/controller/GamepadView;->pressed(Lcom/cloudpad/controller/Control;)Z

    move-result v3

    if-eqz v3, :cond_0

    const v3, -0x19120d

    goto :goto_0

    :cond_0
    const v3, -0x746b62

    :goto_0
    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    const/4 v2, -0x1

    :goto_1
    const/4 v3, 0x1

    if-gt v2, v3, :cond_1

    .line 1041
    iget v3, p2, Lcom/cloudpad/controller/Control;->cx:F

    sub-float v5, v3, v0

    iget v3, p2, Lcom/cloudpad/controller/Control;->cy:F

    int-to-float v4, v2

    mul-float/2addr v4, v1

    add-float v6, v3, v4

    iget v3, p2, Lcom/cloudpad/controller/Control;->cx:F

    add-float v7, v3, v0

    iget v3, p2, Lcom/cloudpad/controller/Control;->cy:F

    add-float v8, v3, v4

    iget-object v9, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    move-object v4, p1

    invoke-virtual/range {v4 .. v9}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method private drawPedal(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 16

    move-object/from16 v8, p0

    move-object/from16 v9, p1

    move-object/from16 v10, p2

    .line 1063
    iget-object v11, v10, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    .line 1064
    invoke-virtual {v11}, Landroid/graphics/RectF;->width()F

    move-result v0

    invoke-virtual {v11}, Landroid/graphics/RectF;->height()F

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    const v6, 0x3e4ccccd    # 0.2f

    mul-float v7, v0, v6

    .line 1065
    iget v0, v10, Lcom/cloudpad/controller/Control;->pointerId:I

    const/4 v1, 0x1

    if-ltz v0, :cond_0

    move v12, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    move v12, v0

    .line 1066
    :goto_0
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    const v2, -0xe9e4de

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 1067
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {v9, v11, v7, v7, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 1068
    iget v0, v10, Lcom/cloudpad/controller/Control;->value:F

    const/4 v13, 0x0

    cmpl-float v0, v0, v13

    if-lez v0, :cond_1

    .line 1069
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->save()I

    .line 1070
    iget v0, v11, Landroid/graphics/RectF;->left:F

    iget v2, v11, Landroid/graphics/RectF;->bottom:F

    invoke-virtual {v11}, Landroid/graphics/RectF;->height()F

    move-result v3

    iget v4, v10, Lcom/cloudpad/controller/Control;->value:F

    mul-float/2addr v3, v4

    sub-float/2addr v2, v3

    iget v3, v11, Landroid/graphics/RectF;->right:F

    iget v4, v11, Landroid/graphics/RectF;->bottom:F

    invoke-virtual {v9, v0, v2, v3, v4}, Landroid/graphics/Canvas;->clipRect(FFFF)Z

    .line 1071
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    iget v2, v10, Lcom/cloudpad/controller/Control;->accent:I

    const v3, 0xffffff

    and-int/2addr v2, v3

    const/high16 v3, 0x59000000

    or-int/2addr v2, v3

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 1072
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {v9, v11, v7, v7, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 1073
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->restore()V

    .line 1075
    :cond_1
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    const v2, 0x1fffffff

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 1076
    invoke-virtual {v11}, Landroid/graphics/RectF;->width()F

    move-result v0

    const v2, 0x3e6147ae    # 0.22f

    mul-float v14, v0, v2

    move v15, v1

    :goto_1
    const/4 v0, 0x5

    if-gt v15, v0, :cond_2

    .line 1078
    iget v0, v11, Landroid/graphics/RectF;->top:F

    invoke-virtual {v11}, Landroid/graphics/RectF;->height()F

    move-result v1

    int-to-float v2, v15

    const v3, 0x3df5c28f    # 0.12f

    mul-float/2addr v2, v3

    add-float/2addr v2, v6

    mul-float/2addr v1, v2

    add-float v4, v0, v1

    .line 1079
    iget v0, v11, Landroid/graphics/RectF;->left:F

    add-float v1, v0, v14

    iget v0, v11, Landroid/graphics/RectF;->right:F

    sub-float v3, v0, v14

    iget-object v5, v8, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    move v2, v4

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    add-int/lit8 v15, v15, 0x1

    goto :goto_1

    .line 1081
    :cond_2
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    iget-boolean v0, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->analogPedals:Z

    if-eqz v0, :cond_3

    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    iget v0, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->pedalFullAt:F

    const v1, 0x3f7eb852    # 0.995f

    cmpg-float v0, v0, v1

    if-gez v0, :cond_3

    .line 1082
    iget v0, v11, Landroid/graphics/RectF;->bottom:F

    invoke-virtual {v11}, Landroid/graphics/RectF;->height()F

    move-result v1

    iget-object v2, v8, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    iget v2, v2, Lcom/cloudpad/controller/GamepadView$Tuning;->pedalFullAt:F

    mul-float/2addr v1, v2

    sub-float v4, v0, v1

    .line 1083
    iget v0, v11, Landroid/graphics/RectF;->left:F

    const/high16 v1, 0x3f000000    # 0.5f

    mul-float/2addr v14, v1

    add-float v1, v0, v14

    iget v0, v11, Landroid/graphics/RectF;->right:F

    sub-float v3, v0, v14

    iget-object v5, v8, Lcom/cloudpad/controller/GamepadView;->dashStroke:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    move v2, v4

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 1085
    :cond_3
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    if-eqz v12, :cond_4

    iget v1, v10, Lcom/cloudpad/controller/Control;->accent:I

    goto :goto_2

    :cond_4
    const v1, -0xcfc9c3

    :goto_2
    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 1086
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {v9, v11, v7, v7, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 1087
    iget-object v2, v10, Lcom/cloudpad/controller/Control;->label:Ljava/lang/String;

    invoke-virtual {v11}, Landroid/graphics/RectF;->centerX()F

    move-result v3

    iget v0, v11, Landroid/graphics/RectF;->top:F

    invoke-virtual {v11}, Landroid/graphics/RectF;->height()F

    move-result v1

    const v4, 0x3db851ec    # 0.09f

    mul-float/2addr v1, v4

    add-float v4, v0, v1

    invoke-virtual {v11}, Landroid/graphics/RectF;->width()F

    move-result v0

    mul-float v5, v0, v6

    iget v6, v10, Lcom/cloudpad/controller/Control;->accent:I

    iget-object v7, v8, Lcom/cloudpad/controller/GamepadView;->bold:Landroid/graphics/Typeface;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/GamepadView;->drawLabel(Landroid/graphics/Canvas;Ljava/lang/String;FFFILandroid/graphics/Typeface;)V

    .line 1088
    iget v0, v10, Lcom/cloudpad/controller/Control;->value:F

    cmpl-float v0, v0, v13

    if-lez v0, :cond_5

    .line 1089
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, v10, Lcom/cloudpad/controller/Control;->value:F

    const/high16 v2, 0x42c80000    # 100.0f

    mul-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "%"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v11}, Landroid/graphics/RectF;->centerX()F

    move-result v3

    iget v0, v11, Landroid/graphics/RectF;->bottom:F

    invoke-virtual {v11}, Landroid/graphics/RectF;->height()F

    move-result v1

    const v4, 0x3da3d70a    # 0.08f

    mul-float/2addr v1, v4

    sub-float v4, v0, v1

    .line 1090
    invoke-virtual {v11}, Landroid/graphics/RectF;->width()F

    move-result v0

    const v1, 0x3e2e147b    # 0.17f

    mul-float v5, v0, v1

    const v6, -0x19120d

    iget-object v7, v8, Lcom/cloudpad/controller/GamepadView;->bold:Landroid/graphics/Typeface;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    .line 1089
    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/GamepadView;->drawLabel(Landroid/graphics/Canvas;Ljava/lang/String;FFFILandroid/graphics/Typeface;)V

    :cond_5
    return-void
.end method

.method private drawRoundBase(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;I)V
    .locals 5

    .line 1015
    invoke-direct {p0, p2}, Lcom/cloudpad/controller/GamepadView;->pressed(Lcom/cloudpad/controller/Control;)Z

    move-result v0

    .line 1016
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    if-eqz v0, :cond_0

    const v2, -0xcfc9c3

    goto :goto_0

    :cond_0
    const v2, -0xe9e4de

    :goto_0
    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 1017
    iget v1, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v2, p2, Lcom/cloudpad/controller/Control;->cy:F

    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v3

    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1018
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    if-eqz v0, :cond_1

    const p3, -0x746b62

    :cond_1
    invoke-virtual {v1, p3}, Landroid/graphics/Paint;->setColor(I)V

    .line 1019
    iget p3, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v0, p2, Lcom/cloudpad/controller/Control;->cy:F

    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result p2

    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, p3, v0, p2, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    return-void
.end method

.method private drawSettings(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 8

    .line 1119
    iget v0, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v1, p2, Lcom/cloudpad/controller/Control;->cy:F

    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result p2

    .line 1120
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    const v3, -0x746b62

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    const/4 v2, 0x0

    :goto_0
    const/16 v3, 0x8

    if-ge v2, v3, :cond_0

    .line 1122
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    int-to-float v3, v2

    const/high16 v4, 0x42340000    # 45.0f

    mul-float/2addr v3, v4

    .line 1123
    invoke-virtual {p1, v3, v0, v1}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 1124
    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    const v4, 0x3e23d70a    # 0.16f

    mul-float/2addr v4, p2

    sub-float v5, v0, v4

    sub-float v6, v1, p2

    add-float/2addr v4, v0

    const v7, 0x3f0ccccd    # 0.55f

    mul-float/2addr v7, p2

    sub-float v7, v1, v7

    invoke-virtual {v3, v5, v6, v4, v7}, Landroid/graphics/RectF;->set(FFFF)V

    .line 1125
    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    const v4, 0x3d75c28f    # 0.06f

    mul-float/2addr v4, p2

    iget-object v5, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v3, v4, v4, v5}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 1126
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    const v2, 0x3f28f5c3    # 0.66f

    mul-float/2addr v2, p2

    .line 1128
    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1129
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    const v3, -0xf2eee9

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    const v2, 0x3e8f5c29    # 0.28f

    mul-float/2addr p2, v2

    .line 1130
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, p2, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    return-void
.end method

.method private drawShoulder(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 13

    .line 904
    invoke-direct {p0, p2}, Lcom/cloudpad/controller/GamepadView;->pressed(Lcom/cloudpad/controller/Control;)Z

    move-result v0

    .line 905
    iget-object v1, p2, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v1

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    .line 906
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    const v3, -0xcfc9c3

    if-eqz v0, :cond_0

    move v4, v3

    goto :goto_0

    :cond_0
    const v4, -0xe9e4de

    :goto_0
    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setColor(I)V

    .line 907
    iget-object v2, p2, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v2, v1, v1, v4}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 908
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    const v4, -0x746b62

    if-eqz v0, :cond_1

    move v3, v4

    :cond_1
    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 909
    iget-object v2, p2, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, v2, v1, v1, v3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 910
    iget-object v7, p2, Lcom/cloudpad/controller/Control;->label:Ljava/lang/String;

    iget v8, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v9, p2, Lcom/cloudpad/controller/Control;->cy:F

    iget-object p2, p2, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    invoke-virtual {p2}, Landroid/graphics/RectF;->height()F

    move-result p2

    const v1, 0x3ed70a3d    # 0.42f

    mul-float v10, p2, v1

    if-eqz v0, :cond_2

    const v4, -0x19120d

    :cond_2
    move v11, v4

    iget-object v12, p0, Lcom/cloudpad/controller/GamepadView;->bold:Landroid/graphics/Typeface;

    move-object v5, p0

    move-object v6, p1

    invoke-direct/range {v5 .. v12}, Lcom/cloudpad/controller/GamepadView;->drawLabel(Landroid/graphics/Canvas;Ljava/lang/String;FFFILandroid/graphics/Typeface;)V

    return-void
.end method

.method private drawSmallButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 10

    .line 1005
    invoke-direct {p0, p2}, Lcom/cloudpad/controller/GamepadView;->pressed(Lcom/cloudpad/controller/Control;)Z

    move-result v2

    .line 1006
    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v3

    .line 1007
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    const v5, -0xcfc9c3

    if-eqz v2, :cond_0

    move v6, v5

    goto :goto_0

    :cond_0
    const v6, -0xe9e4de

    :goto_0
    invoke-virtual {v4, v6}, Landroid/graphics/Paint;->setColor(I)V

    .line 1008
    iget v4, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v6, p2, Lcom/cloudpad/controller/Control;->cy:F

    iget-object v7, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v4, v6, v3, v7}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1009
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    const v6, -0x746b62

    if-eqz v2, :cond_1

    move v5, v6

    :cond_1
    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 1010
    iget v4, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v5, p2, Lcom/cloudpad/controller/Control;->cy:F

    iget-object v7, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, v4, v5, v3, v7}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1011
    iget-object v4, p2, Lcom/cloudpad/controller/Control;->label:Ljava/lang/String;

    iget v5, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget v7, p2, Lcom/cloudpad/controller/Control;->cy:F

    const v0, 0x3f3851ec    # 0.72f

    mul-float v8, v3, v0

    if-eqz v2, :cond_2

    const v0, -0x19120d

    move v6, v0

    :cond_2
    iget-object v9, p0, Lcom/cloudpad/controller/GamepadView;->bold:Landroid/graphics/Typeface;

    move-object v0, p0

    move-object v1, p1

    move-object v2, v4

    move v3, v5

    move v4, v7

    move v5, v8

    move-object v7, v9

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/GamepadView;->drawLabel(Landroid/graphics/Canvas;Ljava/lang/String;FFFILandroid/graphics/Typeface;)V

    return-void
.end method

.method private drawStatus(Landroid/graphics/Canvas;)V
    .locals 12

    .line 1134
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->statusRect:Landroid/graphics/RectF;

    invoke-virtual {v0}, Landroid/graphics/RectF;->width()F

    move-result v0

    const/4 v1, 0x0

    cmpg-float v1, v0, v1

    if-gtz v1, :cond_0

    return-void

    .line 1136
    :cond_0
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    const v2, 0x3d54fdf4    # 0.052f

    mul-float/2addr v2, v1

    const v3, 0x3d1374bc    # 0.036f

    mul-float/2addr v1, v3

    const v3, 0x3e6147ae    # 0.22f

    mul-float/2addr v3, v2

    const v4, 0x3ecccccd    # 0.4f

    mul-float/2addr v4, v2

    .line 1139
    iget-object v5, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    iget-object v6, p0, Lcom/cloudpad/controller/GamepadView;->bold:Landroid/graphics/Typeface;

    invoke-virtual {v5, v6}, Landroid/text/TextPaint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 1140
    iget-object v5, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {v5, v2}, Landroid/text/TextPaint;->setTextSize(F)V

    .line 1141
    iget-object v5, p0, Lcom/cloudpad/controller/GamepadView;->statusTitle:Ljava/lang/String;

    iget-object v6, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    const/high16 v7, 0x40000000    # 2.0f

    mul-float v8, v3, v7

    sub-float v9, v0, v8

    sub-float/2addr v9, v4

    sget-object v10, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-static {v5, v6, v9, v10}, Landroid/text/TextUtils;->ellipsize(Ljava/lang/CharSequence;Landroid/text/TextPaint;FLandroid/text/TextUtils$TruncateAt;)Ljava/lang/CharSequence;

    move-result-object v5

    .line 1142
    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    .line 1143
    iget-object v6, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {v6, v5}, Landroid/text/TextPaint;->measureText(Ljava/lang/String;)F

    move-result v6

    .line 1144
    iget-object v9, p0, Lcom/cloudpad/controller/GamepadView;->statusRect:Landroid/graphics/RectF;

    iget v9, v9, Landroid/graphics/RectF;->top:F

    const v10, 0x3f933333    # 1.15f

    mul-float/2addr v2, v10

    add-float/2addr v9, v2

    .line 1145
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->statusRect:Landroid/graphics/RectF;

    invoke-virtual {v2}, Landroid/graphics/RectF;->centerX()F

    move-result v2

    add-float/2addr v6, v8

    add-float/2addr v6, v4

    div-float/2addr v6, v7

    sub-float/2addr v2, v6

    .line 1147
    iget v6, p0, Lcom/cloudpad/controller/GamepadView;->statusLevel:I

    const/4 v10, 0x1

    if-ne v6, v10, :cond_1

    const v6, -0xc046b0

    goto :goto_0

    :cond_1
    const/4 v10, 0x2

    if-ne v6, v10, :cond_2

    const v6, -0x7aeb7

    goto :goto_0

    :cond_2
    const v6, -0x2d66de

    .line 1149
    :goto_0
    iget-object v10, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {v10, v6}, Landroid/graphics/Paint;->setColor(I)V

    .line 1150
    iget-object v6, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    iget-object v10, p0, Lcom/cloudpad/controller/GamepadView;->fontMetrics:Landroid/graphics/Paint$FontMetrics;

    invoke-virtual {v6, v10}, Landroid/text/TextPaint;->getFontMetrics(Landroid/graphics/Paint$FontMetrics;)F

    add-float v6, v2, v3

    .line 1151
    iget-object v10, p0, Lcom/cloudpad/controller/GamepadView;->fontMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v10, v10, Landroid/graphics/Paint$FontMetrics;->ascent:F

    iget-object v11, p0, Lcom/cloudpad/controller/GamepadView;->fontMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v11, v11, Landroid/graphics/Paint$FontMetrics;->descent:F

    add-float/2addr v10, v11

    div-float/2addr v10, v7

    add-float/2addr v10, v9

    iget-object v7, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v6, v10, v3, v7}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1153
    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    const v6, -0x19120d

    invoke-virtual {v3, v6}, Landroid/text/TextPaint;->setColor(I)V

    .line 1154
    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    sget-object v6, Landroid/graphics/Paint$Align;->LEFT:Landroid/graphics/Paint$Align;

    invoke-virtual {v3, v6}, Landroid/text/TextPaint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    add-float/2addr v2, v8

    add-float/2addr v2, v4

    .line 1155
    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {p1, v5, v2, v9, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 1156
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    sget-object v3, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v2, v3}, Landroid/text/TextPaint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 1158
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->statusDetail:Ljava/lang/String;

    if-eqz v2, :cond_3

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_3

    .line 1159
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    sget-object v3, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    invoke-virtual {v2, v3}, Landroid/text/TextPaint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 1160
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {v2, v1}, Landroid/text/TextPaint;->setTextSize(F)V

    .line 1161
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    const v3, -0x746b62

    invoke-virtual {v2, v3}, Landroid/text/TextPaint;->setColor(I)V

    .line 1162
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->statusDetail:Ljava/lang/String;

    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    sget-object v4, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-static {v2, v3, v0, v4}, Landroid/text/TextUtils;->ellipsize(Ljava/lang/CharSequence;Landroid/text/TextPaint;FLandroid/text/TextUtils$TruncateAt;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1163
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->statusRect:Landroid/graphics/RectF;

    invoke-virtual {v2}, Landroid/graphics/RectF;->centerX()F

    move-result v2

    const v3, 0x3fd9999a    # 1.7f

    mul-float/2addr v1, v3

    add-float/2addr v9, v1

    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {p1, v0, v2, v9, v1}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    :cond_3
    return-void
.end method

.method private drawStick(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 7

    .line 914
    iget v0, p2, Lcom/cloudpad/controller/Control;->pointerId:I

    if-ltz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_1

    .line 915
    iget v1, p2, Lcom/cloudpad/controller/Control;->originX:F

    goto :goto_1

    :cond_1
    iget v1, p2, Lcom/cloudpad/controller/Control;->cx:F

    :goto_1
    if-eqz v0, :cond_2

    iget v2, p2, Lcom/cloudpad/controller/Control;->originY:F

    goto :goto_2

    :cond_2
    iget v2, p2, Lcom/cloudpad/controller/Control;->cy:F

    :goto_2
    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v3

    .line 916
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    const v5, -0xe9e4de

    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 917
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 918
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    const v5, -0xb7b0a8

    if-eqz v0, :cond_3

    move v6, v5

    goto :goto_3

    :cond_3
    const v6, -0xcfc9c3

    :goto_3
    invoke-virtual {v4, v6}, Landroid/graphics/Paint;->setColor(I)V

    .line 919
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 921
    iget v4, p2, Lcom/cloudpad/controller/Control;->x:F

    mul-float/2addr v4, v3

    add-float/2addr v1, v4

    iget p2, p2, Lcom/cloudpad/controller/Control;->y:F

    mul-float/2addr p2, v3

    add-float/2addr v2, p2

    const p2, 0x3ef5c28f    # 0.48f

    mul-float/2addr v3, p2

    .line 922
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    if-eqz v0, :cond_4

    const v4, -0xc2bbb3

    goto :goto_4

    :cond_4
    const v4, -0xd9d3cc

    :goto_4
    invoke-virtual {p2, v4}, Landroid/graphics/Paint;->setColor(I)V

    .line 923
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, p2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 924
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    if-eqz v0, :cond_5

    const v5, -0xc046b0

    :cond_5
    invoke-virtual {p2, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 925
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, p2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 926
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    const v0, 0x22ffffff

    invoke-virtual {p2, v0}, Landroid/graphics/Paint;->setColor(I)V

    const p2, 0x3f1eb852    # 0.62f

    mul-float/2addr v3, p2

    .line 927
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, p2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    return-void
.end method

.method private drawToolbar(Landroid/graphics/Canvas;)V
    .locals 16

    move-object/from16 v8, p0

    move-object/from16 v9, p1

    .line 1187
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    const/4 v10, 0x1

    const/4 v11, 0x0

    if-eqz v0, :cond_0

    move v12, v10

    goto :goto_0

    :cond_0
    move v12, v11

    :goto_0
    move v13, v11

    :goto_1
    const/high16 v0, 0x40000000    # 2.0f

    const v1, -0x19120d

    const/4 v2, 0x6

    if-ge v13, v2, :cond_b

    .line 1189
    iget-object v3, v8, Lcom/cloudpad/controller/GamepadView;->toolRects:[Landroid/graphics/RectF;

    aget-object v3, v3, v13

    const/4 v4, 0x3

    const/4 v5, 0x2

    if-ge v13, v4, :cond_2

    if-eqz v12, :cond_1

    if-ne v13, v5, :cond_2

    .line 1190
    iget-object v4, v8, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget v4, v4, Lcom/cloudpad/controller/Control;->kind:I

    if-eq v4, v2, :cond_1

    goto :goto_2

    :cond_1
    move v2, v11

    goto :goto_3

    :cond_2
    :goto_2
    move v2, v10

    :goto_3
    const/4 v4, 0x5

    if-ne v13, v4, :cond_3

    move v4, v10

    goto :goto_4

    :cond_3
    move v4, v11

    .line 1193
    :goto_4
    invoke-virtual {v3}, Landroid/graphics/RectF;->height()F

    move-result v6

    div-float/2addr v6, v0

    .line 1194
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    if-eqz v4, :cond_4

    const v7, -0xc046b0

    goto :goto_5

    :cond_4
    iget v7, v8, Lcom/cloudpad/controller/GamepadView;->pressedTool:I

    if-ne v7, v13, :cond_5

    const v7, -0xcfc9c3

    goto :goto_5

    :cond_5
    const v7, -0xe9e4de

    :goto_5
    invoke-virtual {v0, v7}, Landroid/graphics/Paint;->setColor(I)V

    .line 1195
    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {v9, v3, v6, v6, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    const v0, -0xb7b0a8

    if-nez v4, :cond_6

    .line 1197
    iget-object v7, v8, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {v7, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 1198
    iget-object v7, v8, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {v9, v3, v6, v6, v7}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    :cond_6
    if-ne v13, v5, :cond_7

    if-eqz v12, :cond_7

    .line 1200
    iget-object v5, v8, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget-boolean v5, v5, Lcom/cloudpad/controller/Control;->hidden:Z

    if-eqz v5, :cond_7

    const-string v5, "Show"

    goto :goto_6

    :cond_7
    sget-object v5, Lcom/cloudpad/controller/GamepadView;->TOOL_LABELS:[Ljava/lang/String;

    aget-object v5, v5, v13

    .line 1201
    :goto_6
    invoke-virtual {v3}, Landroid/graphics/RectF;->height()F

    move-result v6

    if-gt v13, v10, :cond_8

    const v7, 0x3f1eb852    # 0.62f

    goto :goto_7

    :cond_8
    const v7, 0x3eb851ec    # 0.36f

    :goto_7
    mul-float/2addr v6, v7

    if-eqz v4, :cond_a

    const v0, -0xf2eee9

    :cond_9
    move v7, v0

    goto :goto_8

    :cond_a
    if-eqz v2, :cond_9

    move v7, v1

    .line 1203
    :goto_8
    invoke-virtual {v3}, Landroid/graphics/RectF;->centerX()F

    move-result v4

    invoke-virtual {v3}, Landroid/graphics/RectF;->centerY()F

    move-result v14

    iget-object v15, v8, Lcom/cloudpad/controller/GamepadView;->bold:Landroid/graphics/Typeface;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v2, v5

    move v3, v4

    move v4, v14

    move v5, v6

    move v6, v7

    move-object v7, v15

    invoke-direct/range {v0 .. v7}, Lcom/cloudpad/controller/GamepadView;->drawLabel(Landroid/graphics/Canvas;Ljava/lang/String;FFFILandroid/graphics/Typeface;)V

    add-int/lit8 v13, v13, 0x1

    goto/16 :goto_1

    :cond_b
    if-eqz v12, :cond_d

    .line 1206
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, v8, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget-object v3, v3, Lcom/cloudpad/controller/Control;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " \u00b7 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v8, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget v3, v3, Lcom/cloudpad/controller/Control;->scale:F

    const/high16 v4, 0x42c80000    # 100.0f

    mul-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "%"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v8, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget-boolean v3, v3, Lcom/cloudpad/controller/Control;->hidden:Z

    if-eqz v3, :cond_c

    const-string v3, " \u00b7 hidden"

    goto :goto_9

    :cond_c
    const-string v3, ""

    :goto_9
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_a

    .line 1207
    :cond_d
    const-string v2, "Drag a control to move it \u00b7 pinch or \u2212 / + to resize \u00b7 Hide removes it"

    .line 1208
    :goto_a
    iget-object v3, v8, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    sget-object v4, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    invoke-virtual {v3, v4}, Landroid/text/TextPaint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 1209
    iget-object v3, v8, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    const v4, 0x3d1374bc    # 0.036f

    iget v5, v8, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v5, v4

    invoke-virtual {v3, v5}, Landroid/text/TextPaint;->setTextSize(F)V

    .line 1210
    iget-object v3, v8, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    if-eqz v12, :cond_e

    goto :goto_b

    :cond_e
    const v1, -0x746b62

    :goto_b
    invoke-virtual {v3, v1}, Landroid/text/TextPaint;->setColor(I)V

    .line 1211
    invoke-virtual/range {p0 .. p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v1

    int-to-float v1, v1

    const v3, 0x3f6147ae    # 0.88f

    iget v4, v8, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v4, v3

    sub-float/2addr v1, v4

    const/4 v3, 0x0

    cmpl-float v3, v1, v3

    if-lez v3, :cond_f

    .line 1213
    iget-object v3, v8, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    sget-object v4, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-static {v2, v3, v1, v4}, Landroid/text/TextUtils;->ellipsize(Ljava/lang/CharSequence;Landroid/text/TextPaint;FLandroid/text/TextUtils$TruncateAt;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1214
    invoke-virtual/range {p0 .. p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    div-float/2addr v2, v0

    iget-object v0, v8, Lcom/cloudpad/controller/GamepadView;->toolRects:[Landroid/graphics/RectF;

    aget-object v0, v0, v11

    iget v0, v0, Landroid/graphics/RectF;->bottom:F

    const v3, 0x3d851eb8    # 0.065f

    iget v4, v8, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v4, v3

    add-float/2addr v0, v4

    iget-object v3, v8, Lcom/cloudpad/controller/GamepadView;->text:Landroid/text/TextPaint;

    invoke-virtual {v9, v1, v2, v0, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    :cond_f
    return-void
.end method

.method private drawViewButton(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 9

    const v0, -0xcfc9c3

    .line 1024
    invoke-direct {p0, p1, p2, v0}, Lcom/cloudpad/controller/GamepadView;->drawRoundBase(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;I)V

    .line 1025
    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v1

    const v2, 0x3eae147b    # 0.34f

    mul-float/2addr v1, v2

    const v2, 0x3eb33333    # 0.35f

    mul-float/2addr v2, v1

    const/high16 v3, 0x3e800000    # 0.25f

    mul-float/2addr v3, v1

    .line 1026
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-direct {p0, p2}, Lcom/cloudpad/controller/GamepadView;->pressed(Lcom/cloudpad/controller/Control;)Z

    move-result v5

    if-eqz v5, :cond_0

    const v5, -0x19120d

    goto :goto_0

    :cond_0
    const v5, -0x746b62

    :goto_0
    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 1027
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    iget v5, p2, Lcom/cloudpad/controller/Control;->cx:F

    sub-float/2addr v5, v1

    sub-float/2addr v5, v2

    iget v6, p2, Lcom/cloudpad/controller/Control;->cy:F

    sub-float/2addr v6, v1

    sub-float/2addr v6, v2

    iget v7, p2, Lcom/cloudpad/controller/Control;->cx:F

    add-float/2addr v7, v1

    sub-float/2addr v7, v2

    iget v8, p2, Lcom/cloudpad/controller/Control;->cy:F

    add-float/2addr v8, v1

    sub-float/2addr v8, v2

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/graphics/RectF;->set(FFFF)V

    .line 1028
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v3, v3, v4}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 1029
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    const/high16 v4, 0x40000000    # 2.0f

    mul-float/2addr v2, v4

    invoke-virtual {v1, v2, v2}, Landroid/graphics/RectF;->offset(FF)V

    .line 1030
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-direct {p0, p2}, Lcom/cloudpad/controller/GamepadView;->pressed(Lcom/cloudpad/controller/Control;)Z

    move-result p2

    if-eqz p2, :cond_1

    goto :goto_1

    :cond_1
    const v0, -0xe9e4de

    :goto_1
    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 1031
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, v3, v3, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 1032
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->tmp:Landroid/graphics/RectF;

    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, v3, v3, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    return-void
.end method

.method private drawWheel(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V
    .locals 10

    .line 1096
    invoke-virtual {p2}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v0

    iget v7, p2, Lcom/cloudpad/controller/Control;->cx:F

    iget p2, p2, Lcom/cloudpad/controller/Control;->cy:F

    const v1, 0x3f333333    # 0.7f

    mul-float v8, v0, v1

    .line 1097
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    const v2, -0xe9e4de

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 1098
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v7, p2, v0, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1099
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    const v2, -0xcfc9c3

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 1100
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->stroke:Landroid/graphics/Paint;

    invoke-virtual {p1, v7, p2, v0, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1101
    iget-boolean v1, p0, Lcom/cloudpad/controller/GamepadView;->steeringAvailable:Z

    if-eqz v1, :cond_0

    const v1, -0x746b62

    goto :goto_0

    :cond_0
    const v1, -0xb7b0a8

    :goto_0
    move v9, v1

    .line 1102
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->wheelStroke:Landroid/graphics/Paint;

    const v2, 0x3e051eb8    # 0.13f

    mul-float/2addr v2, v0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 1103
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->wheelStroke:Landroid/graphics/Paint;

    invoke-virtual {v1, v9}, Landroid/graphics/Paint;->setColor(I)V

    .line 1104
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 1105
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->steering:F

    const/high16 v2, 0x42b40000    # 90.0f

    mul-float/2addr v1, v2

    invoke-virtual {p1, v1, v7, p2}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 1106
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->wheelStroke:Landroid/graphics/Paint;

    invoke-virtual {p1, v7, p2, v8, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    sub-float v2, v7, v8

    add-float v4, v7, v8

    .line 1107
    iget-object v6, p0, Lcom/cloudpad/controller/GamepadView;->wheelStroke:Landroid/graphics/Paint;

    move-object v1, p1

    move v3, p2

    move v5, p2

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    add-float v5, p2, v8

    .line 1108
    iget-object v6, p0, Lcom/cloudpad/controller/GamepadView;->wheelStroke:Landroid/graphics/Paint;

    move v2, v7

    move v4, v7

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 1109
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {v1, v9}, Landroid/graphics/Paint;->setColor(I)V

    const v1, 0x3e4ccccd    # 0.2f

    mul-float/2addr v1, v0

    .line 1110
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v7, p2, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1111
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    const v2, -0xc046b0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    sub-float v1, p2, v8

    const v2, 0x3dcccccd    # 0.1f

    mul-float/2addr v2, v0

    .line 1112
    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->fill:Landroid/graphics/Paint;

    invoke-virtual {p1, v7, v1, v2, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1113
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 1114
    iget-boolean v1, p0, Lcom/cloudpad/controller/GamepadView;->steeringAvailable:Z

    if-eqz v1, :cond_1

    const-string v1, "Tap to center"

    goto :goto_1

    :cond_1
    const-string v1, "No tilt sensor"

    :goto_1
    move-object v3, v1

    add-float/2addr p2, v0

    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    const v1, 0x3d23d70a    # 0.04f

    mul-float/2addr v1, v0

    add-float v5, p2, v1

    const p2, 0x3d03126f    # 0.032f

    mul-float v6, v0, p2

    const p2, -0x746b62

    sget-object v8, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    move-object v1, p0

    move-object v2, p1

    move v4, v7

    move v7, p2

    invoke-direct/range {v1 .. v8}, Lcom/cloudpad/controller/GamepadView;->drawLabel(Landroid/graphics/Canvas;Ljava/lang/String;FFFILandroid/graphics/Typeface;)V

    return-void
.end method

.method private editControlAt(FF)Lcom/cloudpad/controller/Control;
    .locals 9

    const v0, 0x3ca3d70a    # 0.02f

    .line 784
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v1, v0

    const/4 v0, 0x0

    const v2, 0x7f7fffff    # Float.MAX_VALUE

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    const/4 v5, 0x2

    if-ge v4, v5, :cond_5

    if-nez v0, :cond_5

    .line 788
    iget-object v5, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_0
    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/cloudpad/controller/Control;

    .line 789
    invoke-static {v6}, Lcom/cloudpad/controller/GamepadView;->isBackground(Lcom/cloudpad/controller/Control;)Z

    move-result v7

    const/4 v8, 0x1

    if-ne v4, v8, :cond_1

    goto :goto_2

    :cond_1
    move v8, v3

    :goto_2
    if-eq v7, v8, :cond_2

    goto :goto_1

    .line 790
    :cond_2
    invoke-virtual {v6, p1, p2, v1}, Lcom/cloudpad/controller/Control;->shapeHit(FFF)Z

    move-result v7

    if-nez v7, :cond_3

    goto :goto_1

    .line 791
    :cond_3
    invoke-virtual {v6, p1, p2}, Lcom/cloudpad/controller/Control;->distance2(FF)F

    move-result v7

    cmpg-float v8, v7, v2

    if-gez v8, :cond_0

    move-object v0, v6

    move v2, v7

    goto :goto_1

    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_5
    return-object v0
.end method

.method private find(Ljava/lang/String;)Lcom/cloudpad/controller/Control;
    .locals 3

    .line 359
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cloudpad/controller/Control;

    .line 360
    iget-object v2, v1, Lcom/cloudpad/controller/Control;->key:Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v1

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method private finishEditing()V
    .locals 2

    const/4 v0, 0x0

    .line 758
    iput-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    const/4 v1, 0x0

    .line 759
    iput-object v1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    .line 760
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->resetEditGesture()V

    .line 761
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->updateGestureExclusion()V

    .line 762
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->updateState()V

    .line 763
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    invoke-interface {v1, v0}, Lcom/cloudpad/controller/GamepadView$Listener;->onEditingChanged(Z)V

    .line 764
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    return-void
.end method

.method private grabStick(Lcom/cloudpad/controller/Control;IFF)V
    .locals 3

    .line 553
    iput p2, p1, Lcom/cloudpad/controller/Control;->pointerId:I

    .line 554
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    iget-boolean p2, p2, Lcom/cloudpad/controller/GamepadView$Tuning;->floatingSticks:Z

    if-eqz p2, :cond_0

    .line 556
    invoke-virtual {p1}, Lcom/cloudpad/controller/Control;->radius()F

    move-result p2

    const v0, 0x3f666666    # 0.9f

    mul-float/2addr p2, v0

    .line 557
    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->safeLeft:I

    int-to-float v0, v0

    add-float/2addr v0, p2

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v1

    iget v2, p0, Lcom/cloudpad/controller/GamepadView;->safeRight:I

    sub-int/2addr v1, v2

    int-to-float v1, v1

    sub-float/2addr v1, p2

    invoke-static {p3, v0, v1}, Lcom/cloudpad/controller/GamepadView;->clampRange(FFF)F

    move-result v0

    iput v0, p1, Lcom/cloudpad/controller/Control;->originX:F

    .line 558
    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->safeTop:I

    int-to-float v0, v0

    add-float/2addr v0, p2

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getHeight()I

    move-result v1

    iget v2, p0, Lcom/cloudpad/controller/GamepadView;->safeBottom:I

    sub-int/2addr v1, v2

    int-to-float v1, v1

    sub-float/2addr v1, p2

    invoke-static {p4, v0, v1}, Lcom/cloudpad/controller/GamepadView;->clampRange(FFF)F

    move-result p2

    iput p2, p1, Lcom/cloudpad/controller/Control;->originY:F

    goto :goto_0

    .line 560
    :cond_0
    iget p2, p1, Lcom/cloudpad/controller/Control;->cx:F

    iput p2, p1, Lcom/cloudpad/controller/Control;->originX:F

    .line 561
    iget p2, p1, Lcom/cloudpad/controller/Control;->cy:F

    iput p2, p1, Lcom/cloudpad/controller/Control;->originY:F

    .line 563
    :goto_0
    invoke-direct {p0, p1, p3, p4}, Lcom/cloudpad/controller/GamepadView;->moveStick(Lcom/cloudpad/controller/Control;FF)V

    return-void
.end method

.method private static isBackground(Lcom/cloudpad/controller/Control;)Z
    .locals 2

    .line 838
    iget v0, p0, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v1, 0x4

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v1, 0x3

    if-eq v0, v1, :cond_1

    iget p0, p0, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v0, 0x5

    if-ne p0, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method

.method private isRacing()Z
    .locals 2

    .line 366
    const-string v0, "racing"

    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->mode:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method private layoutControls()V
    .locals 10

    .line 312
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getHeight()I

    move-result v1

    if-eqz v0, :cond_1

    if-nez v1, :cond_0

    goto :goto_0

    .line 314
    :cond_0
    iget v2, p0, Lcom/cloudpad/controller/GamepadView;->safeLeft:I

    int-to-float v2, v2

    iget v3, p0, Lcom/cloudpad/controller/GamepadView;->safeTop:I

    int-to-float v9, v3

    iget v3, p0, Lcom/cloudpad/controller/GamepadView;->safeRight:I

    sub-int/2addr v0, v3

    int-to-float v0, v0

    iget v3, p0, Lcom/cloudpad/controller/GamepadView;->safeBottom:I

    sub-int/2addr v1, v3

    int-to-float v8, v1

    sub-float v1, v8, v9

    sub-float v3, v0, v2

    const v4, 0x3ff33333    # 1.9f

    div-float/2addr v3, v4

    .line 315
    invoke-static {v1, v3}, Ljava/lang/Math;->min(FF)F

    move-result v1

    iput v1, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    .line 316
    iget-object v3, p0, Lcom/cloudpad/controller/GamepadView;->mode:Ljava/lang/String;

    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    move v5, v2

    move v6, v9

    move v7, v0

    invoke-static/range {v3 .. v8}, Lcom/cloudpad/controller/Layouts;->placeDefaults(Ljava/lang/String;Ljava/util/List;FFFF)V

    .line 317
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->resolveAll()V

    .line 318
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    const v3, 0x3ee147ae    # 0.44f

    mul-float/2addr v3, v1

    .line 319
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->statusRect:Landroid/graphics/RectF;

    add-float v5, v2, v3

    const v6, 0x3ca3d70a    # 0.02f

    mul-float/2addr v6, v1

    add-float/2addr v6, v9

    sub-float v3, v0, v3

    const v7, 0x3e6147ae    # 0.22f

    mul-float/2addr v1, v7

    add-float/2addr v1, v9

    invoke-virtual {v4, v5, v6, v3, v1}, Landroid/graphics/RectF;->set(FFFF)V

    .line 320
    invoke-direct {p0, v2, v9, v0}, Lcom/cloudpad/controller/GamepadView;->layoutToolbar(FFF)V

    .line 321
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->updateGestureExclusion()V

    :cond_1
    :goto_0
    return-void
.end method

.method private layoutToolbar(FFF)V
    .locals 7

    .line 329
    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    const v1, 0x3e19999a    # 0.15f

    mul-float/2addr v1, v0

    const v2, 0x3dcccccd    # 0.1f

    mul-float/2addr v2, v0

    const v3, 0x3ca3d70a    # 0.02f

    mul-float/2addr v3, v0

    const v4, 0x3d75c28f    # 0.06f

    mul-float/2addr v4, v0

    const/high16 v5, 0x40c00000    # 6.0f

    mul-float/2addr v5, v1

    const/high16 v6, 0x40800000    # 4.0f

    mul-float/2addr v6, v3

    add-float/2addr v5, v6

    add-float/2addr v5, v4

    add-float/2addr p1, p3

    sub-float/2addr p1, v5

    const/high16 p3, 0x40000000    # 2.0f

    div-float/2addr p1, p3

    const p3, 0x3cf5c28f    # 0.03f

    mul-float/2addr v0, p3

    add-float/2addr p2, v0

    const/4 p3, 0x0

    :goto_0
    const/4 v0, 0x6

    if-ge p3, v0, :cond_1

    .line 333
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->toolRects:[Landroid/graphics/RectF;

    aget-object v0, v0, p3

    add-float v5, p1, v1

    add-float v6, p2, v2

    invoke-virtual {v0, p1, p2, v5, v6}, Landroid/graphics/RectF;->set(FFFF)V

    const/4 v0, 0x2

    if-ne p3, v0, :cond_0

    move v0, v4

    goto :goto_1

    :cond_0
    move v0, v3

    :goto_1
    add-float/2addr v0, v1

    add-float/2addr p1, v0

    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method private moveSelected(FF)V
    .locals 4

    .line 802
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getHeight()I

    move-result v1

    .line 803
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    int-to-float v0, v0

    const/4 v3, 0x0

    invoke-static {p1, v3, v0}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result p1

    div-float/2addr p1, v0

    iput p1, v2, Lcom/cloudpad/controller/Control;->userX:F

    .line 804
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    int-to-float v1, v1

    invoke-static {p2, v3, v1}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result p2

    div-float/2addr p2, v1

    iput p2, p1, Lcom/cloudpad/controller/Control;->userY:F

    .line 805
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    invoke-virtual {p1, v0, v1}, Lcom/cloudpad/controller/Control;->resolve(FF)V

    return-void
.end method

.method private moveStick(Lcom/cloudpad/controller/Control;FF)V
    .locals 3

    .line 567
    invoke-virtual {p1}, Lcom/cloudpad/controller/Control;->radius()F

    move-result v0

    .line 568
    iget v1, p1, Lcom/cloudpad/controller/Control;->originX:F

    sub-float/2addr p2, v1

    div-float/2addr p2, v0

    iget v1, p1, Lcom/cloudpad/controller/Control;->originY:F

    sub-float/2addr p3, v1

    div-float/2addr p3, v0

    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    iget v0, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->stickDeadzone:F

    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    iget v1, v1, Lcom/cloudpad/controller/GamepadView$Tuning;->stickOuterDeadzone:F

    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->stickOut:[F

    invoke-static {p2, p3, v0, v1, v2}, Lcom/cloudpad/controller/InputMath;->stick(FFFF[F)V

    .line 570
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->stickOut:[F

    const/4 p3, 0x0

    aget p2, p2, p3

    iput p2, p1, Lcom/cloudpad/controller/Control;->x:F

    .line 571
    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->stickOut:[F

    const/4 p3, 0x1

    aget p2, p2, p3

    iput p2, p1, Lcom/cloudpad/controller/Control;->y:F

    return-void
.end method

.method private onEditTouch(Landroid/view/MotionEvent;)V
    .locals 5

    .line 656
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    if-eqz v0, :cond_9

    const/4 v1, 0x1

    if-eq v0, v1, :cond_8

    const/4 v1, 0x2

    const/4 v2, -0x1

    if-eq v0, v1, :cond_3

    const/4 v1, 0x3

    if-eq v0, v1, :cond_2

    const/4 v1, 0x5

    if-eq v0, v1, :cond_9

    const/4 v1, 0x6

    if-eq v0, v1, :cond_0

    goto/16 :goto_0

    .line 699
    :cond_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v0

    .line 700
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->pinchPointer:I

    if-ne v0, v1, :cond_1

    .line 701
    iput v2, p0, Lcom/cloudpad/controller/GamepadView;->pinchPointer:I

    .line 702
    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->dragPointer:I

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v0

    if-ltz v0, :cond_c

    .line 703
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    if-eqz v1, :cond_c

    .line 704
    iget v1, v1, Lcom/cloudpad/controller/Control;->cx:F

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    sub-float/2addr v1, v2

    iput v1, p0, Lcom/cloudpad/controller/GamepadView;->dragOffsetX:F

    .line 705
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget v1, v1, Lcom/cloudpad/controller/Control;->cy:F

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result p1

    sub-float/2addr v1, p1

    iput v1, p0, Lcom/cloudpad/controller/GamepadView;->dragOffsetY:F

    goto/16 :goto_0

    .line 707
    :cond_1
    iget p1, p0, Lcom/cloudpad/controller/GamepadView;->dragPointer:I

    if-ne v0, p1, :cond_c

    .line 708
    iput v2, p0, Lcom/cloudpad/controller/GamepadView;->dragPointer:I

    .line 709
    iput v2, p0, Lcom/cloudpad/controller/GamepadView;->pinchPointer:I

    goto/16 :goto_0

    .line 721
    :cond_2
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->resetEditGesture()V

    goto/16 :goto_0

    .line 686
    :cond_3
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    if-eqz v0, :cond_c

    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->dragPointer:I

    if-gez v0, :cond_4

    goto/16 :goto_0

    .line 687
    :cond_4
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v0

    if-gez v0, :cond_5

    goto/16 :goto_0

    .line 689
    :cond_5
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->pinchPointer:I

    if-ltz v1, :cond_6

    invoke-virtual {p1, v1}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v2

    :cond_6
    if-ltz v2, :cond_7

    .line 691
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getY(I)F

    move-result p1

    invoke-static {v1, v0, v3, p1}, Lcom/cloudpad/controller/GamepadView;->distance(FFFF)F

    move-result p1

    .line 692
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->pinchStartScale:F

    mul-float/2addr v1, p1

    iget p1, p0, Lcom/cloudpad/controller/GamepadView;->pinchStartDistance:F

    div-float/2addr v1, p1

    invoke-direct {p0, v0, v1}, Lcom/cloudpad/controller/GamepadView;->setScale(Lcom/cloudpad/controller/Control;F)V

    goto/16 :goto_0

    .line 694
    :cond_7
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    iget v2, p0, Lcom/cloudpad/controller/GamepadView;->dragOffsetX:F

    add-float/2addr v1, v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result p1

    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->dragOffsetY:F

    add-float/2addr p1, v0

    invoke-direct {p0, v1, p1}, Lcom/cloudpad/controller/GamepadView;->moveSelected(FF)V

    goto/16 :goto_0

    .line 714
    :cond_8
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    .line 715
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->pressedTool:I

    .line 716
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->resetEditGesture()V

    if-ltz v1, :cond_c

    .line 717
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result p1

    invoke-direct {p0, v2, p1}, Lcom/cloudpad/controller/GamepadView;->toolAt(FF)I

    move-result p1

    if-ne p1, v1, :cond_c

    invoke-direct {p0, v1}, Lcom/cloudpad/controller/GamepadView;->runTool(I)V

    goto :goto_0

    .line 659
    :cond_9
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    .line 660
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v1

    .line 661
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    .line 662
    invoke-direct {p0, v2, v0}, Lcom/cloudpad/controller/GamepadView;->toolAt(FF)I

    move-result v3

    if-ltz v3, :cond_a

    .line 664
    iget p1, p0, Lcom/cloudpad/controller/GamepadView;->dragPointer:I

    if-gez p1, :cond_c

    iput v3, p0, Lcom/cloudpad/controller/GamepadView;->pressedTool:I

    goto :goto_0

    .line 667
    :cond_a
    iget v3, p0, Lcom/cloudpad/controller/GamepadView;->dragPointer:I

    if-gez v3, :cond_b

    .line 668
    invoke-direct {p0, v2, v0}, Lcom/cloudpad/controller/GamepadView;->editControlAt(FF)Lcom/cloudpad/controller/Control;

    move-result-object p1

    iput-object p1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    if-eqz p1, :cond_c

    .line 670
    iput v1, p0, Lcom/cloudpad/controller/GamepadView;->dragPointer:I

    .line 671
    iget p1, p1, Lcom/cloudpad/controller/Control;->cx:F

    sub-float/2addr p1, v2

    iput p1, p0, Lcom/cloudpad/controller/GamepadView;->dragOffsetX:F

    .line 672
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget p1, p1, Lcom/cloudpad/controller/Control;->cy:F

    sub-float/2addr p1, v0

    iput p1, p0, Lcom/cloudpad/controller/GamepadView;->dragOffsetY:F

    goto :goto_0

    .line 674
    :cond_b
    iget v4, p0, Lcom/cloudpad/controller/GamepadView;->pinchPointer:I

    if-gez v4, :cond_c

    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    if-eqz v4, :cond_c

    .line 676
    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v3

    if-ltz v3, :cond_c

    .line 678
    iput v1, p0, Lcom/cloudpad/controller/GamepadView;->pinchPointer:I

    .line 679
    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->getY(I)F

    move-result p1

    invoke-static {v1, p1, v2, v0}, Lcom/cloudpad/controller/GamepadView;->distance(FFFF)F

    move-result p1

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0, p1}, Ljava/lang/Math;->max(FF)F

    move-result p1

    iput p1, p0, Lcom/cloudpad/controller/GamepadView;->pinchStartDistance:F

    .line 680
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget p1, p1, Lcom/cloudpad/controller/Control;->scale:F

    iput p1, p0, Lcom/cloudpad/controller/GamepadView;->pinchStartScale:F

    .line 726
    :cond_c
    :goto_0
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    return-void
.end method

.method private pedalValue(Lcom/cloudpad/controller/Control;F)F
    .locals 1

    .line 575
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    iget-boolean v0, v0, Lcom/cloudpad/controller/GamepadView$Tuning;->analogPedals:Z

    if-nez v0, :cond_0

    const/high16 p1, 0x3f800000    # 1.0f

    return p1

    .line 576
    :cond_0
    iget-object v0, p1, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->bottom:F

    sub-float/2addr v0, p2

    iget-object p1, p1, Lcom/cloudpad/controller/Control;->bounds:Landroid/graphics/RectF;

    invoke-virtual {p1}, Landroid/graphics/RectF;->height()F

    move-result p1

    div-float/2addr v0, p1

    .line 577
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    iget p1, p1, Lcom/cloudpad/controller/GamepadView$Tuning;->pedalDeadzone:F

    iget-object p2, p0, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    iget p2, p2, Lcom/cloudpad/controller/GamepadView$Tuning;->pedalFullAt:F

    invoke-static {v0, p1, p2}, Lcom/cloudpad/controller/InputMath;->pedal(FFF)F

    move-result p1

    return p1
.end method

.method private pointerDown(IFF)V
    .locals 4

    .line 412
    new-instance v0, Lcom/cloudpad/controller/GamepadView$Touch;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/cloudpad/controller/GamepadView$Touch;-><init>(Lcom/cloudpad/controller/GamepadView$1;)V

    .line 413
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->touches:Landroid/util/SparseArray;

    invoke-virtual {v1, p1, v0}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    const v1, 0x3ca3d70a    # 0.02f

    .line 414
    iget v2, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v2, v1

    .line 415
    invoke-direct {p0, p2, p3, v2}, Lcom/cloudpad/controller/GamepadView;->buttonAt(FFF)Lcom/cloudpad/controller/Control;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 417
    iput-object v1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->control:Lcom/cloudpad/controller/Control;

    const/4 p1, 0x1

    .line 418
    iput-boolean p1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->onButtons:Z

    return-void

    .line 421
    :cond_0
    invoke-direct {p0, p2, p3, v2}, Lcom/cloudpad/controller/GamepadView;->targetAt(FFF)Lcom/cloudpad/controller/Control;

    move-result-object v1

    if-nez v1, :cond_1

    .line 423
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->statusRect:Landroid/graphics/RectF;

    invoke-virtual {p1, p2, p3}, Landroid/graphics/RectF;->contains(FF)Z

    move-result p1

    iput-boolean p1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->onStatus:Z

    return-void

    .line 426
    :cond_1
    iput-object v1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->control:Lcom/cloudpad/controller/Control;

    .line 427
    iget v2, v1, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v3, 0x2

    if-eq v2, v3, :cond_5

    const/4 v3, 0x3

    if-eq v2, v3, :cond_4

    const/4 p2, 0x4

    if-eq v2, p2, :cond_3

    const/4 p1, 0x6

    if-eq v2, p1, :cond_2

    goto :goto_0

    .line 440
    :cond_2
    iput-object v0, p0, Lcom/cloudpad/controller/GamepadView;->settingsPress:Lcom/cloudpad/controller/GamepadView$Touch;

    .line 441
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->settingsLongPress:Ljava/lang/Runnable;

    const-wide/16 p2, 0x258

    invoke-virtual {p0, p1, p2, p3}, Lcom/cloudpad/controller/GamepadView;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    .line 436
    :cond_3
    iput p1, v1, Lcom/cloudpad/controller/Control;->pointerId:I

    .line 437
    invoke-direct {p0, v1, p3}, Lcom/cloudpad/controller/GamepadView;->pedalValue(Lcom/cloudpad/controller/Control;F)F

    move-result p1

    iput p1, v1, Lcom/cloudpad/controller/Control;->value:F

    goto :goto_0

    .line 432
    :cond_4
    iput p1, v1, Lcom/cloudpad/controller/Control;->pointerId:I

    .line 433
    invoke-static {v1, p2, p3}, Lcom/cloudpad/controller/GamepadView;->dpadMask(Lcom/cloudpad/controller/Control;FF)I

    move-result p1

    iput p1, v1, Lcom/cloudpad/controller/Control;->mask:I

    goto :goto_0

    .line 429
    :cond_5
    invoke-direct {p0, v1, p1, p2, p3}, Lcom/cloudpad/controller/GamepadView;->grabStick(Lcom/cloudpad/controller/Control;IFF)V

    :goto_0
    return-void
.end method

.method private pointerMove(IFF)V
    .locals 3

    .line 449
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->touches:Landroid/util/SparseArray;

    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cloudpad/controller/GamepadView$Touch;

    if-nez v0, :cond_0

    return-void

    .line 451
    :cond_0
    iget-boolean v1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->onButtons:Z

    if-eqz v1, :cond_3

    const p1, 0x3ca3d70a    # 0.02f

    .line 453
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v1, p1

    invoke-direct {p0, p2, p3, v1}, Lcom/cloudpad/controller/GamepadView;->buttonAt(FFF)Lcom/cloudpad/controller/Control;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 455
    iput-object p1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->control:Lcom/cloudpad/controller/Control;

    goto :goto_0

    .line 456
    :cond_1
    iget-object p1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->control:Lcom/cloudpad/controller/Control;

    if-eqz p1, :cond_2

    iget-object p1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->control:Lcom/cloudpad/controller/Control;

    const v1, 0x3da3d70a    # 0.08f

    iget v2, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v2, v1

    invoke-virtual {p1, p2, p3, v2}, Lcom/cloudpad/controller/Control;->hit(FFF)Z

    move-result p1

    if-nez p1, :cond_2

    const/4 p1, 0x0

    .line 457
    iput-object p1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->control:Lcom/cloudpad/controller/Control;

    :cond_2
    :goto_0
    return-void

    .line 461
    :cond_3
    iget-object v0, v0, Lcom/cloudpad/controller/GamepadView$Touch;->control:Lcom/cloudpad/controller/Control;

    if-nez v0, :cond_4

    return-void

    .line 463
    :cond_4
    iget v1, v0, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v2, 0x2

    if-eq v1, v2, :cond_8

    const/4 v2, 0x3

    if-eq v1, v2, :cond_7

    const/4 v2, 0x4

    if-eq v1, v2, :cond_6

    const/4 p1, 0x6

    if-eq v1, p1, :cond_5

    goto :goto_1

    .line 474
    :cond_5
    invoke-virtual {v0}, Lcom/cloudpad/controller/Control;->radius()F

    move-result p1

    invoke-virtual {v0, p2, p3, p1}, Lcom/cloudpad/controller/Control;->hit(FFF)Z

    move-result p1

    if-nez p1, :cond_9

    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->settingsLongPress:Ljava/lang/Runnable;

    invoke-virtual {p0, p1}, Lcom/cloudpad/controller/GamepadView;->removeCallbacks(Ljava/lang/Runnable;)Z

    goto :goto_1

    .line 471
    :cond_6
    iget p2, v0, Lcom/cloudpad/controller/Control;->pointerId:I

    if-ne p2, p1, :cond_9

    invoke-direct {p0, v0, p3}, Lcom/cloudpad/controller/GamepadView;->pedalValue(Lcom/cloudpad/controller/Control;F)F

    move-result p1

    iput p1, v0, Lcom/cloudpad/controller/Control;->value:F

    goto :goto_1

    .line 468
    :cond_7
    iget v1, v0, Lcom/cloudpad/controller/Control;->pointerId:I

    if-ne v1, p1, :cond_9

    invoke-static {v0, p2, p3}, Lcom/cloudpad/controller/GamepadView;->dpadMask(Lcom/cloudpad/controller/Control;FF)I

    move-result p1

    iput p1, v0, Lcom/cloudpad/controller/Control;->mask:I

    goto :goto_1

    .line 465
    :cond_8
    iget v1, v0, Lcom/cloudpad/controller/Control;->pointerId:I

    if-ne v1, p1, :cond_9

    invoke-direct {p0, v0, p2, p3}, Lcom/cloudpad/controller/GamepadView;->moveStick(Lcom/cloudpad/controller/Control;FF)V

    :cond_9
    :goto_1
    return-void
.end method

.method private pointerUp(IFF)V
    .locals 4

    .line 482
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->touches:Landroid/util/SparseArray;

    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cloudpad/controller/GamepadView$Touch;

    .line 483
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->touches:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->remove(I)V

    if-nez v0, :cond_0

    return-void

    .line 485
    :cond_0
    iget-object v1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->control:Lcom/cloudpad/controller/Control;

    if-eqz v1, :cond_7

    .line 486
    iget-boolean v2, v0, Lcom/cloudpad/controller/GamepadView$Touch;->onButtons:Z

    if-eqz v2, :cond_1

    goto :goto_1

    .line 490
    :cond_1
    iget v2, v1, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v3, 0x2

    if-eq v2, v3, :cond_5

    const/4 v3, 0x3

    if-eq v2, v3, :cond_5

    const/4 v3, 0x4

    if-eq v2, v3, :cond_5

    const/4 p1, 0x5

    if-eq v2, p1, :cond_4

    const/4 p1, 0x6

    if-eq v2, p1, :cond_2

    goto :goto_0

    .line 500
    :cond_2
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->settingsLongPress:Ljava/lang/Runnable;

    invoke-virtual {p0, p1}, Lcom/cloudpad/controller/GamepadView;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 501
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->settingsPress:Lcom/cloudpad/controller/GamepadView$Touch;

    if-ne p1, v0, :cond_3

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/cloudpad/controller/GamepadView;->settingsPress:Lcom/cloudpad/controller/GamepadView$Touch;

    .line 502
    :cond_3
    iget-boolean p1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->consumed:Z

    if-nez p1, :cond_6

    invoke-virtual {v1}, Lcom/cloudpad/controller/Control;->radius()F

    move-result p1

    invoke-virtual {v1, p2, p3, p1}, Lcom/cloudpad/controller/Control;->hit(FFF)Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    invoke-interface {p1}, Lcom/cloudpad/controller/GamepadView$Listener;->onSettingsTapped()V

    goto :goto_0

    :cond_4
    const p1, 0x3d23d70a    # 0.04f

    .line 497
    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v0, p1

    invoke-virtual {v1, p2, p3, v0}, Lcom/cloudpad/controller/Control;->hit(FFF)Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    invoke-interface {p1}, Lcom/cloudpad/controller/GamepadView$Listener;->onSteeringCenterTapped()V

    goto :goto_0

    .line 494
    :cond_5
    iget p2, v1, Lcom/cloudpad/controller/Control;->pointerId:I

    if-ne p2, p1, :cond_6

    invoke-virtual {v1}, Lcom/cloudpad/controller/Control;->release()V

    :cond_6
    :goto_0
    return-void

    .line 487
    :cond_7
    :goto_1
    iget-boolean p1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->onStatus:Z

    if-eqz p1, :cond_8

    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->statusRect:Landroid/graphics/RectF;

    invoke-virtual {p1, p2, p3}, Landroid/graphics/RectF;->contains(FF)Z

    move-result p1

    if-eqz p1, :cond_8

    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    invoke-interface {p1}, Lcom/cloudpad/controller/GamepadView$Listener;->onStatusTapped()V

    :cond_8
    return-void
.end method

.method private pressed(Lcom/cloudpad/controller/Control;)Z
    .locals 1

    .line 880
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->state:Lcom/cloudpad/controller/GamepadState;

    iget p1, p1, Lcom/cloudpad/controller/Control;->input:I

    invoke-virtual {v0, p1}, Lcom/cloudpad/controller/GamepadState;->isPressed(I)Z

    move-result p1

    return p1
.end method

.method private resetEditGesture()V
    .locals 1

    const/4 v0, -0x1

    .line 768
    iput v0, p0, Lcom/cloudpad/controller/GamepadView;->dragPointer:I

    .line 769
    iput v0, p0, Lcom/cloudpad/controller/GamepadView;->pinchPointer:I

    .line 770
    iput v0, p0, Lcom/cloudpad/controller/GamepadView;->pressedTool:I

    return-void
.end method

.method private resolveAll()V
    .locals 4

    .line 325
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cloudpad/controller/Control;

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getHeight()I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {v1, v2, v3}, Lcom/cloudpad/controller/Control;->resolve(FF)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method private runTool(I)V
    .locals 3

    const/high16 v0, 0x3f800000    # 1.0f

    const/high16 v1, 0x41200000    # 10.0f

    if-eqz p1, :cond_5

    const/4 v2, 0x1

    if-eq p1, v2, :cond_4

    const/4 v0, 0x2

    if-eq p1, v0, :cond_3

    const/4 v0, 0x3

    if-eq p1, v0, :cond_2

    const/4 v0, 0x4

    if-eq p1, v0, :cond_1

    const/4 v0, 0x5

    if-eq p1, v0, :cond_0

    goto :goto_0

    .line 747
    :cond_0
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getHeight()I

    move-result v1

    int-to-float v1, v1

    invoke-static {p1, v0, v1}, Lcom/cloudpad/controller/Layouts;->encode(Ljava/util/List;FF)Ljava/lang/String;

    move-result-object p1

    .line 748
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->finishEditing()V

    .line 749
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->mode:Ljava/lang/String;

    invoke-interface {v0, v1, p1}, Lcom/cloudpad/controller/GamepadView$Listener;->onLayoutSaved(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 744
    :cond_1
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->cancelEditing()V

    goto :goto_0

    .line 741
    :cond_2
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    invoke-interface {p1}, Lcom/cloudpad/controller/GamepadView$Listener;->onLayoutResetRequested()V

    goto :goto_0

    .line 738
    :cond_3
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    if-eqz p1, :cond_6

    iget p1, p1, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v0, 0x6

    if-eq p1, v0, :cond_6

    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    iget-boolean v0, p1, Lcom/cloudpad/controller/Control;->hidden:Z

    xor-int/2addr v0, v2

    iput-boolean v0, p1, Lcom/cloudpad/controller/Control;->hidden:Z

    goto :goto_0

    .line 735
    :cond_4
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    if-eqz p1, :cond_6

    iget v2, p1, Lcom/cloudpad/controller/Control;->scale:F

    mul-float/2addr v2, v1

    add-float/2addr v2, v0

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v0

    int-to-float v0, v0

    div-float/2addr v0, v1

    invoke-direct {p0, p1, v0}, Lcom/cloudpad/controller/GamepadView;->setScale(Lcom/cloudpad/controller/Control;F)V

    goto :goto_0

    .line 732
    :cond_5
    iget-object p1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    if-eqz p1, :cond_6

    iget v2, p1, Lcom/cloudpad/controller/Control;->scale:F

    mul-float/2addr v2, v1

    sub-float/2addr v2, v0

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v0

    int-to-float v0, v0

    div-float/2addr v0, v1

    invoke-direct {p0, p1, v0}, Lcom/cloudpad/controller/GamepadView;->setScale(Lcom/cloudpad/controller/Control;F)V

    :cond_6
    :goto_0
    return-void
.end method

.method private setScale(Lcom/cloudpad/controller/Control;F)V
    .locals 2

    const/high16 v0, 0x3f000000    # 0.5f

    const/high16 v1, 0x40000000    # 2.0f

    .line 809
    invoke-static {p2, v0, v1}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result p2

    iput p2, p1, Lcom/cloudpad/controller/Control;->scale:F

    .line 810
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result p2

    int-to-float p2, p2

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getHeight()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p1, p2, v0}, Lcom/cloudpad/controller/Control;->resolve(FF)V

    return-void
.end method

.method private targetAt(FFF)Lcom/cloudpad/controller/Control;
    .locals 9

    const/4 v0, 0x0

    const v1, 0x7f7fffff    # Float.MAX_VALUE

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    const/4 v4, 0x2

    if-ge v3, v4, :cond_8

    if-nez v0, :cond_8

    .line 537
    iget-object v5, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_0
    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_7

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/cloudpad/controller/Control;

    .line 538
    iget-boolean v7, v6, Lcom/cloudpad/controller/Control;->hidden:Z

    if-nez v7, :cond_0

    iget v7, v6, Lcom/cloudpad/controller/Control;->pointerId:I

    if-ltz v7, :cond_1

    goto :goto_1

    .line 539
    :cond_1
    iget v7, v6, Lcom/cloudpad/controller/Control;->kind:I

    if-eqz v7, :cond_0

    iget v7, v6, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v8, 0x1

    if-ne v7, v8, :cond_2

    goto :goto_1

    .line 540
    :cond_2
    iget v7, v6, Lcom/cloudpad/controller/Control;->kind:I

    if-ne v7, v4, :cond_3

    move v7, v8

    goto :goto_2

    :cond_3
    move v7, v2

    :goto_2
    if-ne v3, v8, :cond_4

    goto :goto_3

    :cond_4
    move v8, v2

    :goto_3
    if-eq v7, v8, :cond_5

    goto :goto_1

    .line 541
    :cond_5
    invoke-virtual {v6, p1, p2, p3}, Lcom/cloudpad/controller/Control;->hit(FFF)Z

    move-result v7

    if-nez v7, :cond_6

    goto :goto_1

    .line 542
    :cond_6
    invoke-virtual {v6, p1, p2}, Lcom/cloudpad/controller/Control;->distance2(FF)F

    move-result v7

    cmpg-float v8, v7, v1

    if-gez v8, :cond_0

    move-object v0, v6

    move v1, v7

    goto :goto_1

    :cond_7
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_8
    return-object v0
.end method

.method private toolAt(FF)I
    .locals 4

    const v0, 0x3c23d70a    # 0.01f

    .line 774
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    mul-float/2addr v1, v0

    const/4 v0, 0x0

    :goto_0
    const/4 v2, 0x6

    if-ge v0, v2, :cond_1

    .line 776
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->toolRects:[Landroid/graphics/RectF;

    aget-object v2, v2, v0

    .line 777
    iget v3, v2, Landroid/graphics/RectF;->left:F

    sub-float/2addr v3, v1

    cmpl-float v3, p1, v3

    if-ltz v3, :cond_0

    iget v3, v2, Landroid/graphics/RectF;->right:F

    add-float/2addr v3, v1

    cmpg-float v3, p1, v3

    if-gtz v3, :cond_0

    iget v3, v2, Landroid/graphics/RectF;->top:F

    sub-float/2addr v3, v1

    cmpl-float v3, p2, v3

    if-ltz v3, :cond_0

    iget v2, v2, Landroid/graphics/RectF;->bottom:F

    add-float/2addr v2, v1

    cmpg-float v2, p2, v2

    if-gtz v2, :cond_0

    return v0

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    const/4 p1, -0x1

    return p1
.end method

.method private updateGestureExclusion()V
    .locals 3

    .line 340
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-ge v0, v1, :cond_0

    return-void

    .line 341
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->exclusionRects:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    const/high16 v0, 0x42c80000    # 100.0f

    .line 342
    iget v1, p0, Lcom/cloudpad/controller/GamepadView;->density:F

    mul-float/2addr v1, v0

    float-to-int v0, v1

    .line 343
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->isRacing()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "brake"

    goto :goto_0

    :cond_1
    const-string v1, "lstick"

    :goto_0
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/GamepadView;->find(Ljava/lang/String;)Lcom/cloudpad/controller/Control;

    move-result-object v1

    const/4 v2, 0x1

    invoke-direct {p0, v1, v0, v2}, Lcom/cloudpad/controller/GamepadView;->addExclusion(Lcom/cloudpad/controller/Control;IZ)V

    .line 344
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->isRacing()Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "throttle"

    goto :goto_1

    :cond_2
    const-string v1, "a"

    :goto_1
    invoke-direct {p0, v1}, Lcom/cloudpad/controller/GamepadView;->find(Ljava/lang/String;)Lcom/cloudpad/controller/Control;

    move-result-object v1

    const/4 v2, 0x0

    invoke-direct {p0, v1, v0, v2}, Lcom/cloudpad/controller/GamepadView;->addExclusion(Lcom/cloudpad/controller/Control;IZ)V

    .line 345
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->exclusionRects:Ljava/util/List;

    invoke-virtual {p0, v0}, Lcom/cloudpad/controller/GamepadView;->setSystemGestureExclusionRects(Ljava/util/List;)V

    return-void
.end method

.method private updateState()V
    .locals 12

    .line 601
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    const/4 v1, 0x6

    const/4 v2, 0x0

    const/4 v3, 0x0

    if-nez v0, :cond_b

    move v0, v2

    .line 602
    :goto_0
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->touches:Landroid/util/SparseArray;

    invoke-virtual {v4}, Landroid/util/SparseArray;->size()I

    move-result v4

    if-ge v2, v4, :cond_2

    .line 603
    iget-object v4, p0, Lcom/cloudpad/controller/GamepadView;->touches:Landroid/util/SparseArray;

    invoke-virtual {v4, v2}, Landroid/util/SparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/cloudpad/controller/GamepadView$Touch;

    iget-object v4, v4, Lcom/cloudpad/controller/GamepadView$Touch;->control:Lcom/cloudpad/controller/Control;

    if-eqz v4, :cond_1

    .line 604
    iget v5, v4, Lcom/cloudpad/controller/Control;->kind:I

    if-eqz v5, :cond_0

    iget v5, v4, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v6, 0x1

    if-ne v5, v6, :cond_1

    .line 605
    :cond_0
    iget v4, v4, Lcom/cloudpad/controller/Control;->input:I

    invoke-static {v4}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v4

    or-int/2addr v0, v4

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 608
    :cond_2
    iget-object v2, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    move v4, v3

    move v5, v4

    move v6, v5

    move v7, v6

    move v8, v7

    :cond_3
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_9

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/cloudpad/controller/Control;

    .line 609
    iget-boolean v10, v9, Lcom/cloudpad/controller/Control;->hidden:Z

    if-eqz v10, :cond_4

    goto :goto_1

    .line 610
    :cond_4
    iget v10, v9, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v11, 0x2

    if-ne v10, v11, :cond_6

    .line 611
    iget v10, v9, Lcom/cloudpad/controller/Control;->input:I

    if-nez v10, :cond_5

    .line 612
    iget v3, v9, Lcom/cloudpad/controller/Control;->x:F

    .line 613
    iget v4, v9, Lcom/cloudpad/controller/Control;->y:F

    goto :goto_1

    .line 615
    :cond_5
    iget v5, v9, Lcom/cloudpad/controller/Control;->x:F

    .line 616
    iget v6, v9, Lcom/cloudpad/controller/Control;->y:F

    goto :goto_1

    .line 618
    :cond_6
    iget v10, v9, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v11, 0x3

    if-ne v10, v11, :cond_7

    .line 619
    iget v9, v9, Lcom/cloudpad/controller/Control;->mask:I

    or-int/2addr v0, v9

    goto :goto_1

    .line 620
    :cond_7
    iget v10, v9, Lcom/cloudpad/controller/Control;->kind:I

    const/4 v11, 0x4

    if-ne v10, v11, :cond_3

    .line 621
    iget v10, v9, Lcom/cloudpad/controller/Control;->input:I

    if-ne v10, v1, :cond_8

    .line 622
    iget v9, v9, Lcom/cloudpad/controller/Control;->value:F

    invoke-static {v7, v9}, Ljava/lang/Math;->max(FF)F

    move-result v7

    goto :goto_1

    .line 624
    :cond_8
    iget v9, v9, Lcom/cloudpad/controller/Control;->value:F

    invoke-static {v8, v9}, Ljava/lang/Math;->max(FF)F

    move-result v8

    goto :goto_1

    .line 628
    :cond_9
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->isRacing()Z

    move-result v2

    if-eqz v2, :cond_a

    iget v3, p0, Lcom/cloudpad/controller/GamepadView;->steering:F

    :cond_a
    move v2, v0

    move v0, v3

    move v3, v7

    goto :goto_2

    :cond_b
    move v0, v3

    move v4, v0

    move v5, v4

    move v6, v5

    move v8, v6

    .line 631
    :goto_2
    invoke-static {v1}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v7

    and-int/2addr v7, v2

    const/high16 v9, 0x3f800000    # 1.0f

    if-eqz v7, :cond_c

    move v3, v9

    :cond_c
    const/4 v7, 0x7

    .line 632
    invoke-static {v7}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v10

    and-int/2addr v10, v2

    if-eqz v10, :cond_d

    move v8, v9

    :cond_d
    const v9, 0x3df5c28f    # 0.12f

    cmpl-float v10, v3, v9

    if-ltz v10, :cond_e

    .line 633
    invoke-static {v1}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v1

    or-int/2addr v1, v2

    goto :goto_3

    :cond_e
    move v1, v2

    :goto_3
    cmpl-float v9, v8, v9

    if-ltz v9, :cond_f

    .line 634
    invoke-static {v7}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result v7

    or-int/2addr v1, v7

    .line 636
    :cond_f
    iget v7, p0, Lcom/cloudpad/controller/GamepadView;->heldButtons:I

    not-int v7, v7

    and-int/2addr v7, v2

    .line 637
    iput v2, p0, Lcom/cloudpad/controller/GamepadView;->heldButtons:I

    .line 638
    new-instance v2, Lcom/cloudpad/controller/GamepadState;

    invoke-direct {v2}, Lcom/cloudpad/controller/GamepadState;-><init>()V

    .line 639
    iput v1, v2, Lcom/cloudpad/controller/GamepadState;->buttons:I

    .line 640
    iput v0, v2, Lcom/cloudpad/controller/GamepadState;->lx:F

    .line 641
    iput v4, v2, Lcom/cloudpad/controller/GamepadState;->ly:F

    .line 642
    iput v5, v2, Lcom/cloudpad/controller/GamepadState;->rx:F

    .line 643
    iput v6, v2, Lcom/cloudpad/controller/GamepadState;->ry:F

    .line 644
    iput v3, v2, Lcom/cloudpad/controller/GamepadState;->lt:F

    .line 645
    iput v8, v2, Lcom/cloudpad/controller/GamepadState;->rt:F

    .line 646
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->state:Lcom/cloudpad/controller/GamepadState;

    invoke-virtual {v2, v0}, Lcom/cloudpad/controller/GamepadState;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_10

    .line 647
    iput-object v2, p0, Lcom/cloudpad/controller/GamepadView;->state:Lcom/cloudpad/controller/GamepadState;

    .line 648
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    invoke-interface {v0, v2}, Lcom/cloudpad/controller/GamepadView$Listener;->onGamepadState(Lcom/cloudpad/controller/GamepadState;)V

    :cond_10
    if-eqz v7, :cond_11

    .line 650
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    invoke-interface {v0, v7}, Lcom/cloudpad/controller/GamepadView$Listener;->onButtonsPressed(I)V

    :cond_11
    return-void
.end method


# virtual methods
.method cancelEditing()V
    .locals 2

    .line 267
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    if-nez v0, :cond_0

    return-void

    .line 268
    :cond_0
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-static {v0}, Lcom/cloudpad/controller/Layouts;->resetToDefaults(Ljava/util/List;)V

    .line 269
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->editSnapshot:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/cloudpad/controller/Layouts;->apply(Ljava/util/List;Ljava/lang/String;)V

    .line 270
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->resolveAll()V

    .line 271
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->finishEditing()V

    return-void
.end method

.method getState()Lcom/cloudpad/controller/GamepadState;
    .locals 1

    .line 223
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->state:Lcom/cloudpad/controller/GamepadState;

    return-object v0
.end method

.method isEditing()Z
    .locals 1

    .line 249
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    return v0
.end method

.method synthetic lambda$new$0$com-cloudpad-controller-GamepadView()V
    .locals 2

    .line 135
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->settingsPress:Lcom/cloudpad/controller/GamepadView$Touch;

    if-eqz v0, :cond_0

    iget-boolean v1, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    if-nez v1, :cond_0

    const/4 v1, 0x1

    .line 136
    iput-boolean v1, v0, Lcom/cloudpad/controller/GamepadView$Touch;->consumed:Z

    .line 137
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->startEditing()V

    :cond_0
    return-void
.end method

.method public onApplyWindowInsets(Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 5

    .line 291
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 292
    invoke-virtual {p1}, Landroid/view/WindowInsets;->getDisplayCutout()Landroid/view/DisplayCutout;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 294
    invoke-virtual {v0}, Landroid/view/DisplayCutout;->getSafeInsetLeft()I

    move-result v1

    .line 295
    invoke-virtual {v0}, Landroid/view/DisplayCutout;->getSafeInsetTop()I

    move-result v2

    .line 296
    invoke-virtual {v0}, Landroid/view/DisplayCutout;->getSafeInsetRight()I

    move-result v3

    .line 297
    invoke-virtual {v0}, Landroid/view/DisplayCutout;->getSafeInsetBottom()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    move v0, v1

    move v2, v0

    move v3, v2

    .line 300
    :goto_0
    iget v4, p0, Lcom/cloudpad/controller/GamepadView;->safeLeft:I

    if-ne v1, v4, :cond_1

    iget v4, p0, Lcom/cloudpad/controller/GamepadView;->safeTop:I

    if-ne v2, v4, :cond_1

    iget v4, p0, Lcom/cloudpad/controller/GamepadView;->safeRight:I

    if-ne v3, v4, :cond_1

    iget v4, p0, Lcom/cloudpad/controller/GamepadView;->safeBottom:I

    if-eq v0, v4, :cond_2

    .line 301
    :cond_1
    iput v1, p0, Lcom/cloudpad/controller/GamepadView;->safeLeft:I

    .line 302
    iput v2, p0, Lcom/cloudpad/controller/GamepadView;->safeTop:I

    .line 303
    iput v3, p0, Lcom/cloudpad/controller/GamepadView;->safeRight:I

    .line 304
    iput v0, p0, Lcom/cloudpad/controller/GamepadView;->safeBottom:I

    .line 305
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->layoutControls()V

    .line 306
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    .line 308
    :cond_2
    invoke-super {p0, p1}, Landroid/view/View;->onApplyWindowInsets(Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    move-result-object p1

    return-object p1
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 3

    const v0, -0xf2eee9

    .line 821
    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 822
    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    if-gtz v0, :cond_0

    return-void

    .line 823
    :cond_0
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    if-eqz v0, :cond_1

    .line 824
    invoke-direct {p0, p1}, Lcom/cloudpad/controller/GamepadView;->drawGrid(Landroid/graphics/Canvas;)V

    goto :goto_0

    .line 826
    :cond_1
    invoke-direct {p0, p1}, Lcom/cloudpad/controller/GamepadView;->drawStatus(Landroid/graphics/Canvas;)V

    .line 828
    :goto_0
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cloudpad/controller/Control;

    .line 829
    invoke-static {v1}, Lcom/cloudpad/controller/GamepadView;->isBackground(Lcom/cloudpad/controller/Control;)Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-direct {p0, p1, v1}, Lcom/cloudpad/controller/GamepadView;->drawControl(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_1

    .line 831
    :cond_3
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_4
    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cloudpad/controller/Control;

    .line 832
    invoke-static {v1}, Lcom/cloudpad/controller/GamepadView;->isBackground(Lcom/cloudpad/controller/Control;)Z

    move-result v2

    if-nez v2, :cond_4

    invoke-direct {p0, p1, v1}, Lcom/cloudpad/controller/GamepadView;->drawControl(Landroid/graphics/Canvas;Lcom/cloudpad/controller/Control;)V

    goto :goto_2

    .line 834
    :cond_5
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    if-eqz v0, :cond_6

    invoke-direct {p0, p1}, Lcom/cloudpad/controller/GamepadView;->drawToolbar(Landroid/graphics/Canvas;)V

    :cond_6
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    .line 285
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->layoutControls()V

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 5

    .line 373
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 374
    invoke-direct {p0, p1}, Lcom/cloudpad/controller/GamepadView;->onEditTouch(Landroid/view/MotionEvent;)V

    return v1

    .line 377
    :cond_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    if-eqz v0, :cond_5

    if-eq v0, v1, :cond_4

    const/4 v2, 0x2

    if-eq v0, v2, :cond_3

    const/4 v2, 0x3

    if-eq v0, v2, :cond_2

    const/4 v2, 0x5

    if-eq v0, v2, :cond_5

    const/4 v2, 0x6

    if-eq v0, v2, :cond_1

    return v1

    .line 390
    :cond_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    .line 391
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result p1

    invoke-direct {p0, v2, v3, p1}, Lcom/cloudpad/controller/GamepadView;->pointerUp(IFF)V

    goto :goto_1

    .line 401
    :cond_2
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->clearTouches()V

    goto :goto_1

    :cond_3
    const/4 v0, 0x0

    .line 385
    :goto_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v2

    if-ge v0, v2, :cond_6

    .line 386
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    invoke-direct {p0, v2, v3, v4}, Lcom/cloudpad/controller/GamepadView;->pointerMove(IFF)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 395
    :cond_4
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    .line 396
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result p1

    invoke-direct {p0, v2, v3, p1}, Lcom/cloudpad/controller/GamepadView;->pointerUp(IFF)V

    .line 397
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->clearTouches()V

    goto :goto_1

    .line 380
    :cond_5
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    .line 381
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result p1

    invoke-direct {p0, v2, v3, p1}, Lcom/cloudpad/controller/GamepadView;->pointerDown(IFF)V

    .line 406
    :cond_6
    :goto_1
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->updateState()V

    .line 407
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    return v1
.end method

.method releaseAll()V
    .locals 0

    .line 242
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->clearTouches()V

    .line 243
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->resetEditGesture()V

    .line 244
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->updateState()V

    .line 245
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    return-void
.end method

.method resetLayout()V
    .locals 1

    .line 276
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-static {v0}, Lcom/cloudpad/controller/Layouts;->resetToDefaults(Ljava/util/List;)V

    .line 277
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->resolveAll()V

    .line 278
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    return-void
.end method

.method setConnected(Z)V
    .locals 1

    .line 227
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->connected:Z

    if-eq v0, p1, :cond_0

    .line 228
    iput-boolean p1, p0, Lcom/cloudpad/controller/GamepadView;->connected:Z

    .line 229
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    :cond_0
    return-void
.end method

.method setMode(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 188
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->settingsLongPress:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Lcom/cloudpad/controller/GamepadView;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 189
    iget-object v0, p0, Lcom/cloudpad/controller/GamepadView;->touches:Landroid/util/SparseArray;

    invoke-virtual {v0}, Landroid/util/SparseArray;->clear()V

    const/4 v0, 0x0

    .line 190
    iput-object v0, p0, Lcom/cloudpad/controller/GamepadView;->settingsPress:Lcom/cloudpad/controller/GamepadView$Touch;

    const/4 v1, 0x0

    .line 191
    iput-boolean v1, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    .line 192
    iput-object v0, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    .line 193
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->resetEditGesture()V

    .line 194
    iput-object p1, p0, Lcom/cloudpad/controller/GamepadView;->mode:Ljava/lang/String;

    .line 195
    invoke-static {p1}, Lcom/cloudpad/controller/Layouts;->create(Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    .line 196
    invoke-static {p1, p2}, Lcom/cloudpad/controller/Layouts;->apply(Ljava/util/List;Ljava/lang/String;)V

    .line 197
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->layoutControls()V

    .line 198
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->updateState()V

    .line 199
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    return-void
.end method

.method setStatus(ILjava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 234
    iput p1, p0, Lcom/cloudpad/controller/GamepadView;->statusLevel:I

    if-eqz p2, :cond_0

    goto :goto_0

    .line 235
    :cond_0
    const-string p2, ""

    :goto_0
    iput-object p2, p0, Lcom/cloudpad/controller/GamepadView;->statusTitle:Ljava/lang/String;

    .line 236
    iput-object p3, p0, Lcom/cloudpad/controller/GamepadView;->statusDetail:Ljava/lang/String;

    .line 237
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    return-void
.end method

.method setSteering(F)V
    .locals 1

    .line 214
    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->steering:F

    cmpl-float v0, p1, v0

    if-nez v0, :cond_0

    return-void

    .line 215
    :cond_0
    iput p1, p0, Lcom/cloudpad/controller/GamepadView;->steering:F

    .line 216
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->isRacing()Z

    move-result p1

    if-eqz p1, :cond_1

    .line 217
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->updateState()V

    .line 218
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    :cond_1
    return-void
.end method

.method setSteeringAvailable(Z)V
    .locals 0

    .line 208
    iput-boolean p1, p0, Lcom/cloudpad/controller/GamepadView;->steeringAvailable:Z

    .line 209
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    return-void
.end method

.method setTuning(Lcom/cloudpad/controller/GamepadView$Tuning;)V
    .locals 0

    .line 203
    iput-object p1, p0, Lcom/cloudpad/controller/GamepadView;->tuning:Lcom/cloudpad/controller/GamepadView$Tuning;

    .line 204
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    return-void
.end method

.method startEditing()V
    .locals 4

    .line 254
    iget-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    if-nez v0, :cond_1

    iget v0, p0, Lcom/cloudpad/controller/GamepadView;->unit:F

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    if-gtz v0, :cond_0

    goto :goto_0

    .line 255
    :cond_0
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->clearTouches()V

    const/4 v0, 0x1

    .line 256
    iput-boolean v0, p0, Lcom/cloudpad/controller/GamepadView;->editing:Z

    const/4 v1, 0x0

    .line 257
    iput-object v1, p0, Lcom/cloudpad/controller/GamepadView;->selected:Lcom/cloudpad/controller/Control;

    .line 258
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->resetEditGesture()V

    .line 259
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->controls:Ljava/util/List;

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->getHeight()I

    move-result v3

    int-to-float v3, v3

    invoke-static {v1, v2, v3}, Lcom/cloudpad/controller/Layouts;->encode(Ljava/util/List;FF)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cloudpad/controller/GamepadView;->editSnapshot:Ljava/lang/String;

    .line 260
    invoke-direct {p0}, Lcom/cloudpad/controller/GamepadView;->updateState()V

    .line 261
    iget-object v1, p0, Lcom/cloudpad/controller/GamepadView;->listener:Lcom/cloudpad/controller/GamepadView$Listener;

    invoke-interface {v1, v0}, Lcom/cloudpad/controller/GamepadView$Listener;->onEditingChanged(Z)V

    .line 262
    invoke-virtual {p0}, Lcom/cloudpad/controller/GamepadView;->invalidate()V

    :cond_1
    :goto_0
    return-void
.end method
