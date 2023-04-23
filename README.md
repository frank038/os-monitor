V. 1.6.1

An operation system resource monitor made for fun.

Programs and modules required:
- Python3
- Gtk3 for Python
- Cairo for Python
- psutil (python3 module): >= 5.1.0 (at least 4.3.0 with less features: no cpu frequencies and temperatures); in the case it is not able to show the frequency or some newer cpu correctely, it is possible to use the sys entry: just change the option at the beginning of the program file.

The Monitors:

There are three monitors that update their values at the specified interval of time:
- memory and network
- cpu
- gpu (only Nvidia has full support)

The Summary (and the battery infos) and the Disks tabs do not update their values.

About the gpu monitor:
the Nvidia entries are populate only if the program nvidia-smi is 
in the system. This also affects the name of the Gpu 
that appears in the main tab. Otherwise, only the gpu name will appear.

Some kind of personalizations at the beginning of the program file.

How to use:
: ./os-monitor.sh or ./os_monitor.py or python3 os_monitor.py
In this case, the monitors update their values every two seconds.
or, e.g.,
: python3 os_monitor.py 3
In this case, the monitors update their values every three seconds.

![My image](https://github.com/frank038/os-monitor/blob/master/os_monitor-01.png)

![My image](https://github.com/frank038/os-monitor/blob/master/os_monitor-02.png)

![My image](https://github.com/frank038/os-monitor/blob/master/os_monitor-04.png)

![My image](https://github.com/frank038/os-monitor/blob/master/os_monitor-05.png)
