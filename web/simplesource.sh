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
AREA:PowerGen#00FF00:"Average" \
STACK:Power#0000FF:"Average"
