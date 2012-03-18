#!/bin/bash

dmesg | grep $1.*ttyUSB | sed 's/.*\(ttyUSB.\)$/\1/'
