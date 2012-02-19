#!/bin/bash

# Simple graph that shows just the average power by appliance

PNGDIR=/tmp/ccost/png
RRDFILE=/tmp/ccost/powertemp.rrd
TIMESPAN=$1

rrdtool graph $PNGDIR/use-$TIMESPAN.png \
--start end-$TIMESPAN --width 700 --end now --slope-mode \
--no-legend --vertical-label Watts --lower-limit 0 \
--alt-autoscale-max $2 $3 \
DEF:PowerImport=${RRDFILE}:Power:AVERAGE \
DEF:PowerGen=${RRDFILE}:generating:AVERAGE \
DEF:PowerCar=${RRDFILE}:app1:AVERAGE \
DEF:PowerExport=${RRDFILE}:exporting:AVERAGE \
CDEF:PowerTotal=PowerImport,PowerGen,ADDNAN  \
CDEF:PowerExpClean=PowerExport,0,ADDNAN  \
CDEF:PowerTotalUsed1=PowerTotal,PowerExpClean,-  \
CDEF:PowerTotalUsed=PowerTotalUsed1,0,LT,0,PowerTotalUsed1,IF  \
AREA:PowerTotalUsed#0000FF:"Average" \
STACK:PowerExport#00FF00:"Average" \
AREA:PowerCar#00FFFF:"Average" 
