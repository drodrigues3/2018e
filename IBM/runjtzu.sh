#!/bin/sh
echo "IBM Time Zone Update Utility for Java (JTZU) Version 1.7.18e"

Exit(){

   echo "End of Java Time Zone Updater Tool."

#  Get back to the JTZU Home directory
   cd $JTZU_HOME
   exit
}


# JTZU_HOME to the current directory
JTZU_HOME=`pwd`
echo "JTZU Home: $JTZU_HOME"

# check JTZU.jar file
if [ ! -f "$JTZU_HOME/JTZU.jar" ]
then
    echo "The Java Time Zone Updater tool (JTZU.jar) doesn't exist."
    Exit
else
    echo "Set the variables using the script $JTZU_HOME/runjtzuenv.sh"
    . $JTZU_HOME/runjtzuenv.sh
fi

#Criei esse linha para nao precisar ficar alterando no arquivo de configuracao runjtzuenv
if [ ! -z "$1" -a "$1" == "apply" ];then
        DISCOVERONLY=false
fi

# check temporary directory
if [ ! -d "$JTZU_HOME/Temp" ]
then
   mkdir "$JTZU_HOME/Temp"
fi

if [ -n "$JAVA_HOME" ]
then
    JAVA="$JAVA_HOME/bin/java"
else
    JAVA="`which java 2>/dev/null`"		#ibm@155595
    if [ -z "$JAVA" ]
    then
        JAVA="`whence java 2>/dev/null`"
    fi
fi

if [ ! -x "$JAVA" ]
then
    echo "Java executable not found - Please set your PATH or edit JAVA_HOME in runjtzuenv.sh"
    Exit
fi

# check TimeZoneInfo directory
if [ -d "$JTZU_HOME/TimeZoneInfo" ]
then
   # change the directory to TimeZoneInfo from the current directory
   cd $JTZU_HOME/TimeZoneInfo

   # Run the JTZU tool
   echo "Launching the Java Time Zone Updater Tool."
   "$JAVA" -cp "$JTZU_HOME/JTZU.jar" -Dnogui=$NOGUI -Ddiscoveronly=$DISCOVERONLY -Dsilentpatch=$SILENTPATCH -Dbackwardcompatibility=$BACKWARDCOMPATIBILITY JTZUMain
else
   echo "The TimeZone Information doesn't exist."
   Exit
fi
