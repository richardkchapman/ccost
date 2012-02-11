#!/bin/sh

rrdtool create $1 --step 5 \
DS:Power:GAUGE:180:0:U \
DS:Temperature:GAUGE:180:U:U \
DS:generating:GAUGE:180:U:U \
DS:app1:GAUGE:180:U:U \
RRA:AVERAGE:0.5:1:3200 \
RRA:AVERAGE:0.5:6:3200 \
RRA:AVERAGE:0.5:36:3200 \
RRA:AVERAGE:0.5:144:3200 \
RRA:AVERAGE:0.5:1008:3200 \
RRA:AVERAGE:0.5:4320:3200 \
RRA:AVERAGE:0.5:52560:3200 \
RRA:AVERAGE:0.5:525600:3200 \
RRA:MIN:0.5:1:3200 \
RRA:MIN:0.5:6:3200 \
RRA:MIN:0.5:36:3200 \
RRA:MIN:0.5:144:3200 \
RRA:MIN:0.5:1008:3200 \
RRA:MIN:0.5:4320:3200 \
RRA:MIN:0.5:52560:3200 \
RRA:MIN:0.5:525600:3200 \
RRA:MAX:0.5:1:3200 \
RRA:MAX:0.5:6:3200 \
RRA:MAX:0.5:36:3200 \
RRA:MAX:0.5:144:3200 \
RRA:MAX:0.5:1008:3200 \
RRA:MAX:0.5:4320:3200 \
RRA:MAX:0.5:52560:3200 \
RRA:MAX:0.5:525600:3200
