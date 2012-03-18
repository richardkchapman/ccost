#!/bin/bash

# Simple graph that shows just the average power by appliance

PNGDIR=/tmp/ccost/png
RRDFILE=/tmp/ccost/powertemp.rrd
TIMESPAN=$1
shift

GENMUL=1
EXPORTMUL=1
CARMUL=1
DRIERMUL=1
FRIDGEMUL=1
TVMUL=1
LIGHTMUL=1
SOCK1MUL=1
SOCK2MUL=1
if [[ $1 == "--nogen" ]]; then
    GENMUL=0
    shift
fi
if [[ $1 == "--noexport" ]]; then
    EXPORTMUL=0
    shift
fi
if [[ $1 == "--nocar" ]]; then
    CARMUL=0
    shift
fi
if [[ $1 == "--nodrier" ]]; then
    DRIERMUL=0
    shift
fi
if [[ $1 == "--nofridge" ]]; then
    FRIDGEMUL=0
    shift
fi
if [[ $1 == "--notv" ]]; then
    TVMUL=0
    shift
fi
if [[ $1 == "--nolighting" ]]; then
    LIGHTMUL=0
    shift
fi
if [[ $1 == "--nosock1" ]]; then
    SOCK1MUL=0
    shift
fi
if [[ $1 == "--nosock2" ]]; then
    SOCK2MUL=0
    shift
fi

rrdtool graph $PNGDIR/use-$TIMESPAN.png \
--start end-$TIMESPAN --width 700 --end now --slope-mode \
--no-legend --vertical-label Watts --lower-limit 0 \
--alt-autoscale-max $* \
DEF:PowerImport=${RRDFILE}:Power:AVERAGE \
DEF:PowerGen=${RRDFILE}:generating:AVERAGE \
DEF:PowerInOut=${RRDFILE}:exporting:AVERAGE \
DEF:PowerCar=${RRDFILE}:app1:AVERAGE \
DEF:PowerDrier=${RRDFILE}:app4:AVERAGE \
DEF:PowerFridge=${RRDFILE}:app5:AVERAGE \
DEF:PowerTV=${RRDFILE}:app6:AVERAGE \
DEF:PowerLights=${RRDFILE}:cct7:AVERAGE \
DEF:PowerSock1=${RRDFILE}:cct8:AVERAGE \
DEF:PowerSock2=${RRDFILE}:cct9:AVERAGE \
CDEF:PowerTotal=PowerImport,PowerGen,ADDNAN  \
CDEF:PowerExpClean=PowerImport,0,GT,0,PowerInOut,0,ADDNAN,IF  \
CDEF:PowerTotalUsed1=PowerTotal,PowerExpClean,-  \
CDEF:PowerTotalUsed=PowerTotalUsed1,0,LT,0,PowerTotalUsed1,IF  \
CDEF:UsePowerTotal=PowerTotalUsed,$GENMUL,* \
CDEF:UseExport=PowerExpClean,$EXPORTMUL,* \
CDEF:UsePowerCar=PowerCar,$CARMUL,* \
CDEF:UsePowerFridge=PowerFridge,$FRIDGEMUL,* \
CDEF:UsePowerDrier=PowerDrier,$DRIERMUL,* \
CDEF:UsePowerTV=PowerTV,$TVMUL,* \
CDEF:UsePowerLights=PowerLights,$LIGHTMUL,* \
CDEF:UsePowerSock1a=PowerSock1,UsePowerDrier,-,$SOCK1MUL,* \
CDEF:UsePowerSock1=UsePowerSock1a,0,LT,0,UsePowerSock1a,IF \
CDEF:UsePowerSock2a=PowerSock2,UsePowerTV,-,$SOCK2MUL,* \
CDEF:UsePowerSock2=UsePowerSock2a,0,LT,0,UsePowerSock2a,IF \
AREA:UsePowerTotal#0000FF:"Average" \
STACK:UseExport#C0FFC0:"Average" \
AREA:UsePowerCar#00c000:"Average" \
STACK:UsePowerFridge#c0ffff:"Average" \
STACK:UsePowerDrier#FF0000:"Average" \
STACK:UsePowerTV#FF00FF:"Average" \
STACK:UsePowerLights#FFFF00:"Average" \
STACK:UsePowerSock1#404040:"Average" \
STACK:UsePowerSock2#C0C0C0:"Average" 
