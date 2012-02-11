#!/bin/bash
RRDFILE=/tmp/ccost/powertemp.rrd
rrdtool graph /tmp/ccost/png/power-day.png \
--start end-1d --width 700 --end now --slope-mode \
--no-legend --vertical-label Watts --lower-limit 0 \
--alt-autoscale-max \
DEF:Power=${RRDFILE}:Power:AVERAGE \
DEF:PowerMin=${RRDFILE}:Power:MIN \
DEF:PowerMax=${RRDFILE}:Power:MAX \
CDEF:PowerRange=PowerMax,PowerMin,- \
DEF:PowerGen=${RRDFILE}:generating:AVERAGE \
AREA:PowerGen#00FF00:"Average" \
AREA:Power#0000FF:"Average":STACK \
LINE1:PowerGen: \
LINE1:PowerMin::STACK \
AREA:PowerRange#FF000040:"Error Range":STACK \
LINE1:PowerGen: \
LINE1:PowerMin#FF000060:"Min":STACK \
LINE1:PowerGen: \
LINE1:PowerMax#FF000060:"Max":STACK 
