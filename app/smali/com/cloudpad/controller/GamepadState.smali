.class final Lcom/cloudpad/controller/GamepadState;
.super Ljava/lang/Object;
.source "GamepadState.java"


# static fields
.field static final A:I = 0x0

.field static final B:I = 0x1

.field static final BUTTON_COUNT:I = 0x11

.field static final DOWN:I = 0xd

.field static final GUIDE:I = 0x10

.field static final L3:I = 0xa

.field static final LB:I = 0x4

.field static final LEFT:I = 0xe

.field static final LT:I = 0x6

.field static final MENU:I = 0x9

.field static final R3:I = 0xb

.field static final RB:I = 0x5

.field static final RIGHT:I = 0xf

.field static final RT:I = 0x7

.field static final UP:I = 0xc

.field static final VIEW:I = 0x8

.field static final X:I = 0x2

.field static final Y:I = 0x3


# instance fields
.field buttons:I

.field lt:F

.field lx:F

.field ly:F

.field rt:F

.field rx:F

.field ry:F


# direct methods
.method constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static bit(I)I
    .locals 1

    const/4 v0, 0x1

    shl-int p0, v0, p0

    return p0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 45
    :cond_0
    instance-of v1, p1, Lcom/cloudpad/controller/GamepadState;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 46
    :cond_1
    check-cast p1, Lcom/cloudpad/controller/GamepadState;

    .line 47
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->buttons:I

    iget v3, p1, Lcom/cloudpad/controller/GamepadState;->buttons:I

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->lx:F

    iget v3, p1, Lcom/cloudpad/controller/GamepadState;->lx:F

    .line 48
    invoke-static {v1, v3}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-nez v1, :cond_2

    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->ly:F

    iget v3, p1, Lcom/cloudpad/controller/GamepadState;->ly:F

    invoke-static {v1, v3}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-nez v1, :cond_2

    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->rx:F

    iget v3, p1, Lcom/cloudpad/controller/GamepadState;->rx:F

    .line 49
    invoke-static {v1, v3}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-nez v1, :cond_2

    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->ry:F

    iget v3, p1, Lcom/cloudpad/controller/GamepadState;->ry:F

    invoke-static {v1, v3}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-nez v1, :cond_2

    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->lt:F

    iget v3, p1, Lcom/cloudpad/controller/GamepadState;->lt:F

    .line 50
    invoke-static {v1, v3}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-nez v1, :cond_2

    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->rt:F

    iget p1, p1, Lcom/cloudpad/controller/GamepadState;->rt:F

    invoke-static {v1, p1}, Ljava/lang/Float;->compare(FF)I

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    move v0, v2

    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 2

    .line 55
    iget v0, p0, Lcom/cloudpad/controller/GamepadState;->buttons:I

    mul-int/lit8 v0, v0, 0x1f

    .line 56
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->lx:F

    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    .line 57
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->ly:F

    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    .line 58
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->rx:F

    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    .line 59
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->ry:F

    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    .line 60
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->lt:F

    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    .line 61
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->rt:F

    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method

.method isPressed(I)Z
    .locals 1

    .line 39
    iget v0, p0, Lcom/cloudpad/controller/GamepadState;->buttons:I

    invoke-static {p1}, Lcom/cloudpad/controller/GamepadState;->bit(I)I

    move-result p1

    and-int/2addr p1, v0

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method
