#!/bin/bash
RELATIVEDIR=`echo $0|sed s/os-monitor.sh//g`
cd $RELATIVEDIR
python3 os_monitor.py &
