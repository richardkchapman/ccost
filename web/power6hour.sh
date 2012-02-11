#!/bin/bash
RRDFILE=/tmp/ccost/powertemp.rrd
rrdtool graph /tmp/ccost/png/power-6hour.png \
--start end-6h --width 700 --end now --slope-mode \
--no-legend --vertical-label Watts --lower-limit 0 \
--alt-autoscale-max \
DEF:Power=${RRDFILE}:Power:AVERAGE \
DEF:PowerGen=${RRDFILE}:generating:AVERAGE \
AREA:PowerGen#00FF00:"Average" \
STACK:Power#0000FF:"Average"
