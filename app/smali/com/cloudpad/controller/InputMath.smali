.class final Lcom/cloudpad/controller/InputMath;
.super Ljava/lang/Object;
.source "InputMath.java"


# static fields
.field static final MIN_PLANAR_GRAVITY:F = 2.5f

.field static final ROTATION_0:I = 0x0

.field static final ROTATION_180:I = 0x2

.field static final ROTATION_270:I = 0x3

.field static final ROTATION_90:I = 0x1


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static clamp(FFF)F
    .locals 1

    cmpg-float v0, p0, p1

    if-gez v0, :cond_0

    move p0, p1

    goto :goto_0

    :cond_0
    cmpl-float p1, p0, p2

    if-lez p1, :cond_1

    move p0, p2

    :cond_1
    :goto_0
    return p0
.end method

.method static pedal(FFF)F
    .locals 1

    const v0, 0x3d4ccccd    # 0.05f

    add-float/2addr v0, p1

    .line 39
    invoke-static {v0, p2}, Ljava/lang/Math;->max(FF)F

    move-result p2

    sub-float/2addr p0, p1

    sub-float/2addr p2, p1

    div-float/2addr p0, p2

    const/4 p1, 0x0

    const/high16 p2, 0x3f800000    # 1.0f

    .line 40
    invoke-static {p0, p1, p2}, Lcom/cloudpad/controller/InputMath;->clamp(FFF)F

    move-result p0

    return p0
.end method

.method static smooth(FFF)F
    .locals 1

    .line 87
    invoke-static {p0}, Ljava/lang/Float;->isNaN(F)Z

    move-result v0

    if-eqz v0, :cond_0

    return p1

    :cond_0
    sub-float/2addr p1, p0

    const/high16 v0, 0x3f800000    # 1.0f

    sub-float/2addr v0, p2

    mul-float/2addr p1, v0

    add-float/2addr p0, p1

    return p0
.end method

.method static steering(FFF)F
    .locals 3

    .line 76
    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpg-float v1, v0, p1

    const/4 v2, 0x0

    if-gtz v1, :cond_0

    return v2

    :cond_0
    sub-float/2addr v0, p1

    sub-float/2addr p2, p1

    const/high16 p1, 0x3f800000    # 1.0f

    .line 78
    invoke-static {p1, p2}, Ljava/lang/Math;->max(FF)F

    move-result p2

    div-float/2addr v0, p2

    invoke-static {p1, v0}, Ljava/lang/Math;->min(FF)F

    move-result p1

    cmpg-float p0, p0, v2

    if-gez p0, :cond_1

    neg-float p1, p1

    :cond_1
    return p1
.end method

.method static stick(FFFF[F)V
    .locals 6

    float-to-double v0, p0

    float-to-double v2, p1

    .line 25
    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->hypot(DD)D

    move-result-wide v0

    double-to-float v0, v0

    const v1, 0x3d4ccccd    # 0.05f

    add-float/2addr v1, p2

    const/high16 v2, 0x3f800000    # 1.0f

    sub-float p3, v2, p3

    .line 26
    invoke-static {v1, p3}, Ljava/lang/Math;->max(FF)F

    move-result p3

    cmpg-float v1, v0, p2

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x0

    if-lez v1, :cond_1

    cmpl-float v1, v0, v5

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    sub-float v1, v0, p2

    sub-float/2addr p3, p2

    div-float/2addr v1, p3

    .line 32
    invoke-static {v2, v1}, Ljava/lang/Math;->min(FF)F

    move-result p2

    div-float/2addr p0, v0

    mul-float/2addr p0, p2

    .line 33
    aput p0, p4, v4

    div-float/2addr p1, v0

    mul-float/2addr p1, p2

    .line 34
    aput p1, p4, v3

    return-void

    .line 28
    :cond_1
    :goto_0
    aput v5, p4, v4

    .line 29
    aput v5, p4, v3

    return-void
.end method

.method static tiltAngle(FFI)F
    .locals 7

    const/4 v0, 0x1

    if-eq p2, v0, :cond_2

    const/4 v0, 0x2

    if-eq p2, v0, :cond_1

    const/4 v0, 0x3

    if-eq p2, v0, :cond_0

    goto :goto_1

    :cond_0
    neg-float p0, p0

    goto :goto_0

    :cond_1
    neg-float p0, p0

    neg-float p1, p1

    goto :goto_1

    :cond_2
    neg-float p1, p1

    :goto_0
    move v6, p1

    move p1, p0

    move p0, v6

    :goto_1
    float-to-double v0, p0

    float-to-double p0, p1

    .line 70
    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->hypot(DD)D

    move-result-wide v2

    const-wide/high16 v4, 0x4004000000000000L    # 2.5

    cmpg-double p2, v2, v4

    if-gez p2, :cond_3

    const/high16 p0, 0x7fc00000    # Float.NaN

    return p0

    .line 71
    :cond_3
    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide p0

    neg-double p0, p0

    double-to-float p0, p0

    return p0
.end method

.method static wrapDegrees(F)F
    .locals 2

    const/high16 v0, 0x43b40000    # 360.0f

    rem-float/2addr p0, v0

    const/high16 v1, 0x43340000    # 180.0f

    cmpl-float v1, p0, v1

    if-lez v1, :cond_0

    sub-float/2addr p0, v0

    :cond_0
    const/high16 v1, -0x3ccc0000    # -180.0f

    cmpg-float v1, p0, v1

    if-gez v1, :cond_1

    add-float/2addr p0, v0

    :cond_1
    return p0
.end method
