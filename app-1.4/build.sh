#!/bin/bash
# Build CloudPad: smali project + new Java view (via javac + dx) + web UI assets.
set -e
cd /home/claude/cp2
ANDROID_JAR=/home/claude/tools/sdk/android.jar
APKTOOL="java -jar /home/claude/tools/apktool.jar"
UAS="java -jar /home/claude/tools/uas.jar"
VERSION_CODE=${1:-5}
VERSION_NAME=${2:-1.4.0-layouts}
export JAVA_TOOL_OPTIONS=

rm -rf proj out && mkdir -p out
mkdir -p proj && (cd /home/claude/apk/smali && tar cf - --exclude=./build --exclude=./original .) | (cd proj && tar xf -)

# 1. drop the classes we are replacing with Java
S=proj/smali/com/cloudpad/controller
rm -f $S/GamepadView*.smali $S/Layouts.smali $S/Control.smali

# 3. telemetry from the Bridge (packet type 3) -> Telemetry.onPacket, for USB and Bluetooth
python3 - <<'PY'
import re
S="proj/smali/com/cloudpad/controller/"
p=S+"Protocol.smali"; s=open(p).read()
hook="""    if-eqz p0, :t_skip

    array-length v0, p0

    const/4 v1, 0x1

    if-lt v0, v1, :t_skip

    const/4 v0, 0x0

    aget-byte v0, p0, v0

    const/4 v1, 0x3

    if-ne v0, v1, :t_skip

    invoke-static {p0}, Lcom/cloudpad/controller/Telemetry;->onPacket([B)V

    const/4 p0, 0x0

    return-object p0

    :t_skip
"""
a=".method static parseRumble([B)[I\n    .locals 3\n\n"
assert a in s; s=s.replace(a,a+hook,1); open(p,"w").write(s)
p=S+"BlePeripheral.smali"; s=open(p).read()
a="    :cond_1\n    const/4 v2, 0x2\n\n    if-ne v0, v2, :cond_2\n"
assert s.count(a)==1
b="""    :cond_1
    const/4 v2, 0x3

    if-ne v0, v2, :t_notel

    invoke-static {p2}, Lcom/cloudpad/controller/Telemetry;->onPacket([B)V

    goto :goto_0

    :t_notel
    const/4 v2, 0x2

    if-ne v0, v2, :cond_2
"""
s=s.replace(a,b,1); open(p,"w").write(s)
PY

# 2. MainActivity: let the new view switch the tilt sensor on/off
cat >> $S/MainActivity.smali <<'SMALI'


.method public setTiltActive(Z)V
    .locals 1

    iget-object v0, p0, Lcom/cloudpad/controller/MainActivity;->tilt:Lcom/cloudpad/controller/TiltSteering;

    if-eqz v0, :done

    if-eqz p1, :stop

    invoke-virtual {v0}, Lcom/cloudpad/controller/TiltSteering;->start()V

    return-void

    :stop
    invoke-virtual {v0}, Lcom/cloudpad/controller/TiltSteering;->stop()V

    :done
    return-void
.end method
SMALI

# 3. web UI
mkdir -p proj/assets/pad && cp web/pad/* proj/assets/pad/

# 4. version
sed -i "s/versionCode: .*/versionCode: $VERSION_CODE/; s/versionName: .*/versionName: $VERSION_NAME/" proj/apktool.yml

# 5. Java -> dex
mkdir -p out/classes
javac -nowarn -implicit:none -source 8 -target 8 -cp $ANDROID_JAR -sourcepath stubs -d out/classes java/com/cloudpad/controller/*.java 2>&1 | grep -v "^Note\|warning:" || true
(cd out/classes && jar cf ../view.jar .)
dalvik-exchange --dex --min-sdk-version=26 --output=out/classes2.dex out/view.jar 2>&1 | grep -v JAVA_TOOL || true

# 6. smali -> apk, then add the Java dex
$APKTOOL b proj -o out/unsigned.apk 2>&1 | grep -v "^I:\|W:" || true
(cd out && zip -q unsigned.apk classes2.dex)

# 7. sign + align (debug key, same as previous CloudPad builds)
$UAS -a out/unsigned.apk --allowResign -o out/signed >/dev/null 2>&1
ls -la out/signed/
