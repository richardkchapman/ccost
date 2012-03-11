#!/bin/bash

# Simple graph that shows just the average power by appliance

PNGDIR=/tmp/ccost/png
RRDFILE=/tmp/ccost/powertemp.rrd
TIMESPAN=$1
shift

GENMUL=1
CARMUL=1
DRIERMUL=1
FRIDGEMUL=1
TVMUL=1
if [[ $1 == "--nogen" ]]; then
    GENMUL=0
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

rrdtool graph $PNGDIR/use-$TIMESPAN.png \
--start end-$TIMESPAN --width 700 --end now --slope-mode \
--no-legend --vertical-label Watts --lower-limit 0 \
--alt-autoscale-max $* \
--right-axis 1.3:0 \
--right-axis-label "Pounds/Year" \
DEF:PowerImport=${RRDFILE}:Power:AVERAGE \
DEF:PowerGen=${RRDFILE}:generating:AVERAGE \
DEF:PowerExport=${RRDFILE}:exporting:AVERAGE \
DEF:PowerCar=${RRDFILE}:app1:AVERAGE \
DEF:PowerDrier=${RRDFILE}:app4:AVERAGE \
DEF:PowerFridge=${RRDFILE}:app5:AVERAGE \
DEF:PowerTV=${RRDFILE}:app6:AVERAGE \
CDEF:PowerTotal=PowerImport,PowerGen,ADDNAN  \
CDEF:PowerExpClean=PowerExport,0,ADDNAN  \
CDEF:PowerTotalUsed1=PowerTotal,PowerExpClean,-  \
CDEF:PowerTotalUsed=PowerTotalUsed1,0,LT,0,PowerTotalUsed1,IF  \
CDEF:UsePowerTotal=PowerTotalUsed,$GENMUL,* \
CDEF:UseExport=PowerExport,$GENMUL,* \
CDEF:UsePowerCar=PowerCar,$CARMUL,* \
CDEF:UsePowerFridge=PowerFridge,$FRIDGEMUL,* \
CDEF:UsePowerDrier=PowerDrier,$DRIERMUL,* \
CDEF:UsePowerTV=PowerTV,$TVMUL,* \
AREA:UsePowerTotal#0000FF:"Average" \
STACK:UseExport#00FF00:"Average" \
AREA:UsePowerCar#00FFFF:"Average" \
STACK:UsePowerFridge#FFFF00:"Average" \
STACK:UsePowerDrier#FF0000:"Average" \
STACK:UsePowerTV#FF00FF:"Average" 
