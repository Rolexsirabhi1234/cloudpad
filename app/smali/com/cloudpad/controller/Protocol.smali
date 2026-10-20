.class final Lcom/cloudpad/controller/Protocol;
.super Ljava/lang/Object;
.source "Protocol.java"


# static fields
.field static final CCCD_UUID:Ljava/util/UUID;

.field static final INPUT_UUID:Ljava/util/UUID;

.field static final IN_PONG:B = 0x2t

.field static final IN_STATE:B = 0x1t

.field static final MAX_RUMBLE_MS:I = 0x1388

.field static final OUTPUT_UUID:Ljava/util/UUID;

.field static final OUT_PING:B = 0x2t

.field static final OUT_RUMBLE:B = 0x1t

.field static final SERVICE_UUID:Ljava/util/UUID;

.field static final STATE_LENGTH:I = 0xf


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 12
    const-string v0, "4c1b0001-7e36-4f0a-9b5d-2a8e6c3f1d70"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lcom/cloudpad/controller/Protocol;->SERVICE_UUID:Ljava/util/UUID;

    .line 14
    const-string v0, "4c1b0002-7e36-4f0a-9b5d-2a8e6c3f1d70"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lcom/cloudpad/controller/Protocol;->INPUT_UUID:Ljava/util/UUID;

    .line 16
    const-string v0, "4c1b0003-7e36-4f0a-9b5d-2a8e6c3f1d70"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lcom/cloudpad/controller/Protocol;->OUTPUT_UUID:Ljava/util/UUID;

    .line 18
    const-string v0, "00002902-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lcom/cloudpad/controller/Protocol;->CCCD_UUID:Ljava/util/UUID;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 10
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

.method static encodeState(Lcom/cloudpad/controller/GamepadState;I)[B
    .locals 5

    const/16 v0, 0xf

    .line 34
    new-array v0, v0, [B

    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 35
    aput-byte v2, v0, v1

    int-to-byte p1, p1

    .line 36
    aput-byte p1, v0, v2

    .line 37
    iget p1, p0, Lcom/cloudpad/controller/GamepadState;->buttons:I

    const v1, 0x1ffff

    and-int/2addr p1, v1

    const/4 v1, 0x2

    int-to-byte v2, p1

    .line 38
    aput-byte v2, v0, v1

    shr-int/lit8 v1, p1, 0x8

    int-to-byte v1, v1

    const/4 v2, 0x3

    .line 39
    aput-byte v1, v0, v2

    shr-int/lit8 p1, p1, 0x10

    int-to-byte p1, p1

    const/4 v1, 0x4

    .line 40
    aput-byte p1, v0, v1

    const/4 p1, 0x5

    .line 41
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->lx:F

    invoke-static {v0, p1, v1}, Lcom/cloudpad/controller/Protocol;->putAxis([BIF)V

    const/4 p1, 0x7

    .line 42
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->ly:F

    invoke-static {v0, p1, v1}, Lcom/cloudpad/controller/Protocol;->putAxis([BIF)V

    const/16 p1, 0x9

    .line 43
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->rx:F

    invoke-static {v0, p1, v1}, Lcom/cloudpad/controller/Protocol;->putAxis([BIF)V

    const/16 p1, 0xb

    .line 44
    iget v1, p0, Lcom/cloudpad/controller/GamepadState;->ry:F

    invoke-static {v0, p1, v1}, Lcom/cloudpad/controller/Protocol;->putAxis([BIF)V

    .line 45
    iget p1, p0, Lcom/cloudpad/controller/GamepadState;->lt:F

    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {p1, v1, v2}, Lcom/cloudpad/controller/Protocol;->clamp(FFF)F

    move-result p1

    const/high16 v3, 0x437f0000    # 255.0f

    mul-float/2addr p1, v3

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    int-to-byte p1, p1

    const/16 v4, 0xd

    aput-byte p1, v0, v4

    .line 46
    iget p0, p0, Lcom/cloudpad/controller/GamepadState;->rt:F

    invoke-static {p0, v1, v2}, Lcom/cloudpad/controller/Protocol;->clamp(FFF)F

    move-result p0

    mul-float/2addr p0, v3

    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result p0

    int-to-byte p0, p0

    const/16 p1, 0xe

    aput-byte p0, v0, p1

    return-object v0
.end method

.method static parseRumble([B)[I
    .locals 3

    if-eqz p0, :cond_1

    .line 59
    array-length v0, p0

    const/4 v1, 0x5

    if-lt v0, v1, :cond_1

    const/4 v0, 0x0

    aget-byte v0, p0, v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x3

    .line 60
    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    const/4 v2, 0x4

    aget-byte v2, p0, v2

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v0, v2

    .line 61
    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    const/4 v2, 0x2

    aget-byte p0, p0, v2

    and-int/lit16 p0, p0, 0xff

    const/16 v2, 0x1388

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    filled-new-array {v1, p0, v0}, [I

    move-result-object p0

    return-object p0

    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method static pong(B)[B
    .locals 3

    const/4 v0, 0x2

    .line 51
    new-array v1, v0, [B

    const/4 v2, 0x0

    aput-byte v0, v1, v2

    const/4 v0, 0x1

    aput-byte p0, v1, v0

    return-object v1
.end method

.method private static putAxis([BIF)V
    .locals 2

    const/high16 v0, -0x40800000    # -1.0f

    const/high16 v1, 0x3f800000    # 1.0f

    .line 65
    invoke-static {p2, v0, v1}, Lcom/cloudpad/controller/Protocol;->clamp(FFF)F

    move-result p2

    const v0, 0x46fffe00    # 32767.0f

    mul-float/2addr p2, v0

    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p2

    int-to-byte v0, p2

    .line 66
    aput-byte v0, p0, p1

    add-int/lit8 p1, p1, 0x1

    shr-int/lit8 p2, p2, 0x8

    int-to-byte p2, p2

    .line 67
    aput-byte p2, p0, p1

    return-void
.end method
