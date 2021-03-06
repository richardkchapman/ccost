#!/bin/bash

# Simple graph that shows just the average power by source

PNGDIR=/tmp/ccost/png
RRDFILE=/tmp/ccost/powertemp.rrd
TIMESPAN=$1
rrdtool graph $PNGDIR/source-$TIMESPAN.png \
--start end-$TIMESPAN --width 700 --end now --slope-mode \
--no-legend --vertical-label Watts --lower-limit 0 \
--alt-autoscale-max $2 $3 \
DEF:PowerImport=${RRDFILE}:Power:AVERAGE \
DEF:PowerGenRaw=${RRDFILE}:generating:AVERAGE \
DEF:PowerInOut=${RRDFILE}:exporting:AVERAGE \
CDEF:PowerInOutClean=PowerInOut,0,ADDNAN  \
CDEF:PowerExport=PowerImport,0,GT,0,PowerInOut,IF  \
CDEF:PowerGenClean=PowerGenRaw,0,ADDNAN  \
CDEF:PowerGenUse1=PowerGenClean,PowerExport,-  \
CDEF:PowerGen=PowerGenUse1,0,LT,0,PowerGenUse1,IF  \
AREA:PowerGen#00FF00:"Average" \
STACK:PowerImport#0000FF:"Average" \
AREA:PowerGen#00FF00:"Average" \
STACK:PowerExport#00FF0040:"Average" 
