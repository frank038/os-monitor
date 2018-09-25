#!/bin/bash
RELATIVEDIR=`echo $0|sed s/os-monitor.sh//g`
cd $RELATIVEDIR
./os_monitor.py &
