@echo off
setlocal

rem ### Configurable properties:

rem ## bind address, set the network interface to use for clustering traffic
rem set BIND_ADDR=192.168.1.5
rem set BIND_ADDR=match-interface:en.*
rem set BIND_ADDR=site_local

rem ################# CHANGE THIS ##############################
rem set BIND_ADDR=match-address:192.168.1.*
rem set BIND_ADDR=127.0.0.1
rem ############################################################

set MCAST_ADDR=232.5.5.5
set BIN_DIR=%~dp0

rem Project built with Maven.
set LIB=.;..\target\libs\*
set CLASSES=..\target\classes
set CONF=%BIN_DIR%..\conf

set CP=%CLASSES%;%CONF%;%LIB%

set LOG=-Dlog4j.configurationFile=log4j2.xml

set JG_FLAGS=-Djgroups.udp.mcast_addr=%MCAST_ADDR%
set JG_FLAGS=%JG_FLAGS% -Djava.net.preferIPv4Stack=true

set FLAGS=-server -Xmx600M -Xms600M
set FLAGS=%FLAGS% -XX:CompileThreshold=10000 -XX:ThreadStackSize=64K -XX:SurvivorRatio=8
set FLAGS=%FLAGS% -XX:TargetSurvivorRatio=90 -XX:MaxTenuringThreshold=15
set FLAGS=%FLAGS% -Xshare:off

rem set GC=-XX:+UseParNewGC -XX:+UseConcMarkSweepGC

set JMX=-Dcom.sun.management.jmxremote
set EXPERIMENTAL=%EXPERIMENTAL% -XX:+EliminateLocks

rem set JMC=-XX:+UnlockCommercialFeatures -XX:+FlightRecorder
rem set DEBUG=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8787

echo CP=%CP%

start "Node" java -Dlog_dir=.raft -cp %CP% %DEBUG% %LOG% %GC% %JG_FLAGS% %FLAGS% %EXPERIMENTAL% %JMX% %JMC% %*
