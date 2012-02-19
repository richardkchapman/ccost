#!/bin/bash

# Simple graph that shows just the average power by source

PNGDIR=/tmp/ccost/png
RRDFILE=/tmp/ccost/powertemp.rrd
TIMESPAN=$1
rrdtool graph $PNGDIR/source-$TIMESPAN.png \
--start end-$TIMESPAN --width 700 --end now --slope-mode \
--no-legend --vertical-label Watts --lower-limit 0 \
--alt-autoscale-max $2 $3 \
DEF:Power=${RRDFILE}:Power:AVERAGE \
DEF:PowerGen=${RRDFILE}:generating:AVERAGE \
DEF:PowerExport=${RRDFILE}:exporting:AVERAGE \
CDEF:PowerGenClean=PowerGen,0,ADDNAN  \
CDEF:PowerExpClean=PowerExport,0,ADDNAN  \
CDEF:PowerGenUse1=PowerGenClean,PowerExpClean,-  \
CDEF:PowerGenUse=PowerGenUse1,0,LT,0,PowerGenUse1,IF  \
AREA:PowerGenUse#00FF00:"Average" \
STACK:PowerExport#00FF0040:"Average" \
STACK:Power#0000FF:"Average"
