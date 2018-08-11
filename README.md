by frank38

An operation system resource monitor made for fun.

Programs and modules required:
- Python3
- Gtk3 for Python
- psutil (python3 module): >= 5.1.0 (at least 4.3.0 with less features: no cpu frequencies and temperatures)

The Monitors:

There are three monitors that update their values at the specified interval of time:
- memory and network
- cpu
- Nvidia

The Summary (and the battery infos) and the Disks tabs do not update their values.

About Nvidia monitor:
the Nvidia tab appears only if the program nvidia-smi is 
in the system. This also affects the name of the Gpu 
that appears in the main tab.

How to use:
: python3 os_monitor.py or ./os_monitor.py
In this case, the monitors update their values every second.
or, e.g.,
: python3 os_monitor.py 3
In this case, the monitors update their values every three seconds.
