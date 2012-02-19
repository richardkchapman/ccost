#!/bin/bash

# Graph that shows power usage with min/max and average, by source

PNGDIR=/tmp/ccost/png
RRDFILE=/tmp/ccost/powertemp.rrd
TIMESPAN=$1

rrdtool graph $PNGDIR/source-$TIMESPAN.png \
--start end-$TIMESPAN --width 700 --end now --slope-mode \
--no-legend --vertical-label Watts --lower-limit 0 \
--alt-autoscale-max \
DEF:Power=${RRDFILE}:Power:AVERAGE \
DEF:PowerMin=${RRDFILE}:Power:MIN \
DEF:PowerMax=${RRDFILE}:Power:MAX \
CDEF:PowerRange=PowerMax,PowerMin,- \
DEF:PowerGen=${RRDFILE}:generating:AVERAGE \
DEF:PowerExport=${RRDFILE}:exporting:AVERAGE \
CDEF:PowerGenClean=PowerGen,0,ADDNAN  \
CDEF:PowerExpClean=PowerExport,0,ADDNAN  \
CDEF:PowerGenUse1=PowerGenClean,PowerExpClean,-  \
CDEF:PowerGenUse=PowerGenUse1,0,LT,0,PowerGenUse1,IF  \
AREA:PowerGenUse#00FF00:"Average" \
STACK:Power#0000FF:"Average" \
AREA:PowerGenUse#00FF00:"Average" \
STACK:PowerExport#00FF0040:"Average" \
LINE1:PowerGen: \
LINE1:PowerMin::STACK \
AREA:PowerRange#FF000040:"Error Range":STACK \
LINE1:PowerGen: \
LINE1:PowerMin#FF000060:"Min":STACK \
LINE1:PowerGen: \
LINE1:PowerMax#FF000060:"Max":STACK 
