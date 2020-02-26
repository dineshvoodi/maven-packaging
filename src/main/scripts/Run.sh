#!bin/sh

APP=maven-packaging

#Reading shell script path
sname=`readlink -f $0`
spath=`dirname $sname`

HOME=`readlink -f $spath/../../`

#Set Application Home
export APPLICATION_HOME=$HOME/live

export JAVA_HOME="$(egrep '^local.java.home=' ${APPLICATION_HOME}/configs/config.properties | sed 's/^local.java.home=/g' | sed 's/\r//g' | sed 's/\n//g')"
export PATH=${JAVA_HOME}/bin:${PATH}

#Set lib to directory holding all jars
export LIB=$APPLICATION_HOME/lib

#Set CONFIG_CLASSPATH to the directory having config files
export CONFIG_CLASSPATH=$APPLICATION_HOME/configs
export LOG_DIR=$APPLICATION_HOME/logs
log4j_config="log4j.xml"
app_args="-Dlog4j.configurations=$log4j_config -Dlogdir=$LOG_DIR -DappName=$APP"

#Set memory args
MEM_ARGS="-Xmx 1024m -Xms256m"

jarfiles=$LIB/'*.jar'

for jarfile in $jarfiles
  do
      if [ -f "$jarfile" ]
        then
            DEPENDENCY_CLASSPATH="$DEPENDENCY_CLASSPATH:$jarfile"
      fi
  done

CMD="java $MEM_ARGS $app_args -cp $CONFIG_CLASSPATH:$DEPENDENCY_CLASSPATH com.learning.java.App"

#Printing command
echo $CMD

#Executing command
$CMD


