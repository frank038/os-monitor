#!/usr/bin/env python3

# by frank38
# V. 1.4.0

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import GLib, Gtk, Gdk, GdkPixbuf
from gi.repository.GdkPixbuf import Pixbuf
import os
import sys
import shutil
import subprocess
from collections import deque
import psutil

# loop interval
LOOP_INTERVAL = 1
# if gt zero
if len(sys.argv) > 1:
    if sys.argv[1].isdigit():
        if int(sys.argv[1]) > 0:
            LOOP_INTERVAL = int(sys.argv[1])

# window size
SIZX = 800
SIZY = 600

# overrid the text label color
OVVERIDE_TEXT_COLOR = Gdk.RGBA(0.5, 0.5, 0.5, 1.0)

# if 0 the timouto is stopped
TIMEOUT = 0

# psutil version
PSUTIL_V = psutil.version_info
if PSUTIL_V < (4,3,0):
    print("Version >= 4.3.0 is required.")
    sys.exit()

class mainwindow(Gtk.Window):
    
    def __init__(self):
        
        Gtk.Window.__init__(self, title="System Info")
        self.connect("destroy", Gtk.main_quit)
        self.set_default_size(SIZX, SIZY)
        font_size = self.get_style_context()
        self.def_fontsize = font_size.get_font(0).get_size()/1024
        vbox1 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        self.add(vbox1)
        self.notebook = Gtk.Notebook()
        vbox1.pack_start(self.notebook, True, True, 0)
        # the summary
        self.page0 = Gtk.Box()
        self.page0.set_orientation(orientation=Gtk.Orientation.VERTICAL)
        self.grid = Gtk.Grid()
        self.grid.set_border_width(10)
        self.grid.set_column_spacing(10)
        self.page0.add(self.grid)
        # system logo
        self.logop = Gtk.Image()
        self.grid.attach(self.logop, 0,0,1,20)
        self.logop.props.halign = 0.5
        self.logop.props.valign = 1
        # user name
        labelunt = Gtk.Label(label="User Name")
        labelunt.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        labelunt.props.xalign = 1
        self.grid.attach(labelunt, 1,0,1,1)
        self.labelun = Gtk.Label()
        self.labelun.props.xalign = 0
        self.grid.attach(self.labelun, 2,0,1,1)
        # node name
        label0t = Gtk.Label(label="Network Pc Name")
        label0t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label0t.props.xalign = 1
        self.grid.attach(label0t, 1,1,1,1)
        self.label0 = Gtk.Label()
        self.label0.props.xalign = 0
        self.grid.attach(self.label0, 2,1,1,1)
        # distro name
        label1t = Gtk.Label(label="Distro")
        label1t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label1t.props.xalign = 1
        self.grid.attach(label1t, 1,2,1,1)
        self.label1 = Gtk.Label()
        self.label1.props.xalign = 0
        self.grid.attach(self.label1, 2,2,1,1)
        # kernel version
        label2t = Gtk.Label(label="Kernel Version")
        label2t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label2t.props.xalign = 1
        self.grid.attach(label2t, 1,3,1,1)
        self.label2 = Gtk.Label()
        self.label2.props.xalign = 0
        self.grid.attach(self.label2, 2,3,1,1)
        # current desktop name
        label3t = Gtk.Label(label="Desktop Manager")
        label3t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label3t.props.xalign = 1
        self.grid.attach(label3t, 1,4,1,1)
        self.label3 = Gtk.Label()
        self.label3.props.xalign = 0
        self.grid.attach(self.label3, 2,4,1,1)
        # installed memory
        label4t = Gtk.Label(label="Installed Memory")
        label4t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label4t.props.xalign = 1
        self.grid.attach(label4t, 1,5,1,1)
        self.label4 = Gtk.Label()
        self.label4.props.xalign = 0
        self.grid.attach(self.label4, 2,5,1,1)
        # total swap memory
        label5t = Gtk.Label(label="Swap")
        label5t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label5t.props.xalign = 1
        self.grid.attach(label5t, 1,6,1,1)
        self.label5 = Gtk.Label()
        self.label5.props.xalign = 0
        self.grid.attach(self.label5, 2,6,1,1)
        # root partition and root fstype
        label6t = Gtk.Label(label="Root Device and type")
        label6t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label6t.props.xalign = 1
        self.grid.attach(label6t, 1,7,1,1)
        self.label6 = Gtk.Label()
        self.label6.props.xalign = 0
        self.grid.attach(self.label6, 2,7,1,1)
        # root disk total - used
        label8t = Gtk.Label(label="Disk Size")
        label8t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label8t.props.xalign = 1
        self.grid.attach(label8t, 1,8,1,1)
        self.label8 = Gtk.Label()
        self.label8.props.xalign = 0
        self.grid.attach(self.label8, 2,8,1,1)
        # processor
        label10t = Gtk.Label(label="Processor")
        label10t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label10t.props.xalign = 1
        self.grid.attach(label10t, 1,11,1,1)
        self.label10 = Gtk.Label()
        self.label10.props.xalign = 0
        self.grid.attach(self.label10, 2,11,1,1)
        # gpu
        label11t = Gtk.Label(label="Gpu")
        label11t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        label11t.props.xalign = 1
        self.grid.attach(label11t, 1,12,1,1)
        self.label11 = Gtk.Label()
        self.label11.props.xalign = 0
        self.grid.attach(self.label11, 2,12,1,1)
        # battery - static info
        if PSUTIL_V > (5,1,0):
            battery = psutil.sensors_battery()
            if battery != None:
                label12t = Gtk.Label(label="Battery")
                label12t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
                label12t.props.xalign = 1
                self.grid.attach(label12t, 1,13,1,1)
                #
                bsec = int(battery.secsleft)
                stbsec = "very very low"
                if bsec/60/60 > 1:
                    # hours 
                    tbsec = bsec/60/60
                    stbsec = str(round(tbsec, 2))+" hours"
                elif bsec/60 > 1:
                    # minutes
                    tbsec = bsec/60
                    stbsec = str(round(tbsec, 2))+" minutes"
                label12 = Gtk.Label(label=str(battery.percent)+"% - "+stbsec)
                label12.props.xalign = 0
                self.grid.attach(label12, 2,13,1,1)
        #
        page0_label = Gtk.Label(label="Summary")
        self.notebook.append_page(self.page0, page0_label)
        self.page0.show()
        self.os_infos()
        #################
        # the memory page
        self.page1 = Gtk.Box()
        self.page1.set_orientation(orientation=Gtk.Orientation.VERTICAL)
        self.page1.show()
        page1_label = Gtk.Label(label="Memory and Network")
        self.notebook.append_page(self.page1, page1_label)
        self.page1_grid = Gtk.Grid()
        self.page1_grid.set_border_width(10)
        self.page1_grid.set_row_spacing(10)
        self.page1_grid.set_column_spacing(10)
        self.page1_grid.set_column_homogeneous(False)
        self.page1.add(self.page1_grid)
        #
        self.mem_list = []
        # title
        title_label = Gtk.Label(label="Memory")
        title_label.props.xalign = 0
        self.page1_grid.attach(title_label, 0,0,1,1)
        #
        imlabel = Gtk.Label(label="Installed Memory")
        imlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        imlabel.props.xalign = 1
        self.page1_grid.attach(imlabel, 0,1,1,1)
        timlabel = Gtk.Label()
        timlabel.props.xalign = 0
        self.page1_grid.attach(timlabel, 1,1,1,1)
        self.mem_list.append(timlabel)
        #
        amlabel = Gtk.Label(label="Available Memory")
        amlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        amlabel.props.xalign = 1
        self.page1_grid.attach(amlabel, 0,2,1,1)
        tamlabel = Gtk.Label()
        tamlabel.props.xalign = 0
        self.page1_grid.attach(tamlabel, 1,2,1,1)
        self.mem_list.append(tamlabel)
        #
        umlabel = Gtk.Label(label="Used Memory")
        umlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        umlabel.props.xalign = 1
        self.page1_grid.attach(umlabel, 0,3,1,1)
        tumlabel = Gtk.Label()
        tumlabel.props.xalign = 0
        self.page1_grid.attach(tumlabel, 1,3,1,1)
        self.mem_list.append(tumlabel)
        #
        fmlabel = Gtk.Label(label="Free Memory")
        fmlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        fmlabel.props.xalign = 1
        self.page1_grid.attach(fmlabel, 0,4,1,1)
        tfmlabel = Gtk.Label()
        tfmlabel.props.xalign = 0
        self.page1_grid.attach(tfmlabel, 1,4,1,1)
        self.mem_list.append(tfmlabel)
        #
        cmlabel = Gtk.Label(label="Buff/Cached Memory")
        cmlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        cmlabel.props.xalign = 1
        self.page1_grid.attach(cmlabel, 0,5,1,1)
        tcmlabel = Gtk.Label()
        tcmlabel.props.xalign = 0
        self.page1_grid.attach(tcmlabel, 1,5,1,1)
        self.mem_list.append(tcmlabel)
        #
        smlabel = Gtk.Label(label="Shared Memory")
        smlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        smlabel.props.xalign = 1
        self.page1_grid.attach(smlabel, 0,6,1,1)
        tsmlabel = Gtk.Label()
        tsmlabel.props.xalign = 0
        self.page1_grid.attach(tsmlabel, 1,6,1,1)
        self.mem_list.append(tsmlabel)
        # swap
        # total used free percent
        title_swap = Gtk.Label(label="Swap")
        title_swap.props.xalign = 0
        self.page1_grid.attach(title_swap, 0,8,1,1)
        #
        tswaplabel = Gtk.Label(label="Total")
        tswaplabel.props.xalign = 1
        tswaplabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        self.page1_grid.attach(tswaplabel, 0,9,1,1)
        ttswaplabel = Gtk.Label()
        ttswaplabel.props.xalign = 0
        self.page1_grid.attach(ttswaplabel, 1,9,1,1)
        self.mem_list.append(ttswaplabel)
        #
        uswaplabel = Gtk.Label(label="Used")
        uswaplabel.props.xalign = 1
        uswaplabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        self.page1_grid.attach(uswaplabel, 0,10,1,1)
        tuswaplabel = Gtk.Label()
        tuswaplabel.props.xalign = 0
        self.page1_grid.attach(tuswaplabel, 1,10,1,1)
        self.mem_list.append(tuswaplabel)
        # 
        self.mem_function()
        # NETWORK
        self.net_list = []
        #
        title_net = Gtk.Label(label="Network")
        title_net.props.xalign = 0
        self.page1_grid.attach(title_net, 0,12,1,1)
        # 
        snetlabel = Gtk.Label(label="bytes/packets sent")
        snetlabel.props.xalign = 1
        snetlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        self.page1_grid.attach(snetlabel, 0,13,1,1)
        tsnetlabel = Gtk.Label()
        tsnetlabel.props.xalign = 0
        self.page1_grid.attach(tsnetlabel, 1,13,1,1)
        self.net_list.append(tsnetlabel)
        # 
        rnetlabel = Gtk.Label(label="bytes/packets received")
        rnetlabel.props.xalign = 1
        rnetlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        self.page1_grid.attach(rnetlabel, 0,14,1,1)
        trnetlabel = Gtk.Label()
        trnetlabel.props.xalign = 0
        self.page1_grid.attach(trnetlabel, 1,14,1,1)
        self.net_list.append(trnetlabel)
        # 
        einetlabel = Gtk.Label(label="errin/dropin")
        einetlabel.props.xalign = 1
        einetlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        self.page1_grid.attach(einetlabel, 0,15,1,1)
        teinetlabel = Gtk.Label()
        teinetlabel.props.xalign = 0
        self.page1_grid.attach(teinetlabel, 1,15,1,1)
        self.net_list.append(teinetlabel)
        # 
        eonetlabel = Gtk.Label(label="errout/dropout")
        eonetlabel.props.xalign = 1
        eonetlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
        self.page1_grid.attach(eonetlabel, 0,16,1,1)
        teonetlabel = Gtk.Label()
        teonetlabel.props.xalign = 0
        self.page1_grid.attach(teonetlabel, 1,16,1,1)
        self.net_list.append(teonetlabel)
        #
        self.fnetwork()

        #################
        # the cpu page
        self.page2 = Gtk.Box()
        self.page2.set_orientation(orientation=Gtk.Orientation.VERTICAL)
        self.page2.show()
        #
        page2_label = Gtk.Label(label="Cpu")
        self.notebook.append_page(self.page2, page2_label)
        # grid
        self.page2_grid = Gtk.Grid()
        self.page2_grid.set_border_width(10)
        self.page2_grid.set_row_spacing(10)
        self.page2_grid.set_column_spacing(10)
        self.page2_grid.set_column_homogeneous(False)
        self.page2.add(self.page2_grid)
        # number of points in the diagram
        deque_size = 15
        self.dcpu = deque('', deque_size)
        for i in range(deque_size):
            self.dcpu.append('0')
        
        # cpu diagram
        self.cpu_area = Gtk.DrawingArea()
        self.cpu_area.props.hexpand = True
        self.cpu_area.props.vexpand = True
        self.cpu_area.connect('draw', self.on_draw)
        self.cpu_area.connect('draw', self.draw_line)
        # 
        self.page2_grid.attach(self.cpu_area, 0,0,30,1)
        # 
        self.loop_func()
        # total cpu level
        self.cpu_level = Gtk.DrawingArea()
        self.cpu_level.props.hexpand = True
        self.cpu_level.props.vexpand = True
        self.cpu_level.connect('draw', self.on_draw_level)
        self.page2_grid.attach(self.cpu_level, 30,0,8,1)
        
        # single cpu core level
        # number of cpu cores
        proc_num = psutil.cpu_count()
        self.ncpu_level = Gtk.DrawingArea()
        self.ncpu_level.props.hexpand = True
        self.ncpu_level.props.vexpand = True
        self.ncpu_level.connect('draw', self.on_ncpu_level, proc_num)
        self.page2_grid.attach(self.ncpu_level, 0,1,38,1)
        
        # cpu frequencies
        self.flabel_list = []
        # psutil version 5.1.0 needed
        if PSUTIL_V >= (5,1,0):
            cpu_freq = psutil.cpu_freq(percpu=True)
            self.n_cpu_freq = len(cpu_freq)
            for i in range(self.n_cpu_freq):
                clabel = Gtk.Label(label="Cpu"+str(i+1))
                clabel.props.xalign = 0
                self.page2_grid.attach(clabel, 0,2+i,1,1)
                nflabel = Gtk.Label(label="Current Frequency")
                nflabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
                self.page2_grid.attach(nflabel, 1,2+i,1,1)
                flabel = Gtk.Label(label="")
                flabel.props.xalign = 1
                self.page2_grid.attach(flabel, 2,2+i,1,1)
                self.flabel_list.append(flabel)
        self.cpu_curr_freq()
        
        # cpu temperatures
        self.tlabel_list = []
        # psutil version 5.1.0 needed
        if PSUTIL_V >= (5,1,0):
            cpu_temps = psutil.sensors_temperatures()['coretemp']
            self.n_cpu_temps = len(cpu_temps)
            
            if self.n_cpu_temps > self.n_cpu_freq:
                i = self.n_cpu_temps-1
                while(i>-1):
                    if not "Core" in cpu_temps[i].label:
                        cpu_temps.pop(i)
                    i -= 1
            
            self.n_cpu_range = len(cpu_temps)
            for i in range(self.n_cpu_range):
                ntlabel = Gtk.Label(label=" Temperature")
                ntlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
                self.page2_grid.attach(ntlabel, 3,2+i,1,1)
                tlabel = Gtk.Label(label="")
                tlabel.props.xalign = 1
                self.page2_grid.attach(tlabel, 4,2+i,1,1)
                self.tlabel_list.append(tlabel)
        self.cpu_curr_temps()
        #####################
        # DISKS page
        self.page3 = Gtk.Box()
        self.page3.set_orientation(orientation=Gtk.Orientation.VERTICAL)
        self.page3.show()
        page3_label = Gtk.Label(label="Disks")
        self.notebook.append_page(self.page3, page3_label)
        # 
        self.swp3 = Gtk.ScrolledWindow()
        self.swp3.props.vexpand = 1
        # grid
        self.page3_grid = Gtk.Grid()
        self.page3_grid.set_border_width(10)
        self.page3_grid.set_row_spacing(10)
        self.page3_grid.set_column_spacing(10)
        self.page3_grid.set_column_homogeneous(False)
        self.swp3.add(self.page3_grid)
        self.page3.add(self.swp3)
        # main label
        label_disks = Gtk.Label(label="Disks")
        label_disks.props.xalign = 0
        self.page3_grid.attach(label_disks, 0,0,1,1)
        # how many partitions
        tpartitions = psutil.disk_partitions(all=False)
        npartitions = len(tpartitions)
        for i in range(npartitions):
            separator = Gtk.Separator()
            self.page3_grid.attach(separator, 0,1+(i*4),1,1)
            ppart = Gtk.Label(label="Mount Point")
            ppart.props.xalign = 1
            ppart.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            self.page3_grid.attach(ppart, 0,2+(i*4),1,1)
            tppart = Gtk.Label(label=tpartitions[i].mountpoint)
            tppart.props.xalign = 0
            self.page3_grid.attach(tppart, 1,2+(i*4),1,1)
            #
            ypart = Gtk.Label(label="Type")
            ypart.props.xalign = 1
            ypart.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            self.page3_grid.attach(ypart, 0,3+(i*4),1,1)
            typart = Gtk.Label(label=tpartitions[i].fstype)
            typart.props.xalign = 0
            self.page3_grid.attach(typart, 1,3+(i*4),1,1)
            #
            tupart = Gtk.Label(label="Total/Used")
            tupart.props.xalign = 1
            tupart.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            self.page3_grid.attach(tupart, 0,4+(i*4),1,1)
            ttupart = Gtk.Label(label=self.el_size(psutil.disk_usage(psutil.disk_partitions()[i].mountpoint).total)+" - "+self.el_size(psutil.disk_usage(psutil.disk_partitions()[i].mountpoint).used))
            ttupart.props.xalign = 0
            self.page3_grid.attach(ttupart, 1,4+(i*4),1,1)
        separator = Gtk.Separator()
        self.page3_grid.attach(separator, 0,(npartitions*4)+1,1,1)
        ###################
        # VIDEO CARD
        #
        self.is_nvidia = 0
        # if nvidia-smi is in the system
        if shutil.which("nvidia-smi"):
            # needed by the looping function
            self.is_nvidia = 1
            # change the gpu name in the first tab
            self.label11.set_text(subprocess.check_output("nvidia-smi --query-gpu=gpu_name --format=csv,noheader",shell=True).decode().strip())
            self.page4 = Gtk.Box()
            self.page4.set_orientation(orientation=Gtk.Orientation.VERTICAL)
            self.page4.show()
            page4_label = Gtk.Label(label="Nvidia")
            self.notebook.append_page(self.page4, page4_label)
            # grid
            self.page4_grid = Gtk.Grid()
            self.page4_grid.set_border_width(10)
            self.page4_grid.set_row_spacing(10)
            self.page4_grid.set_column_spacing(10)
            self.page4_grid.set_column_homogeneous(False)
            self.page4.add(self.page4_grid)
            # Nvidia logo
            nvlogo = Gtk.Image()
            nvlogo.set_from_file("NVLogo.png")
            nvlogo.props.halign = 0.5
            nvlogo.props.valign = 0.5
            self.page4_grid.attach(nvlogo, 0,0,1,6)
            #
            numproc = int(subprocess.check_output("nvidia-smi --query-gpu=count --format=csv,noheader",shell=True).decode().strip())
            if  numproc > 1:
                self.numgpu = Gtk.Label(label="GPUs")
                self.numgpu.props.xalign = 1
                self.numgpu.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
                self.page4_grid.attach(self.numgpu, 1,0,1,1)
                self.tnumgpu = Gtk.Label(numproc)
                self.tnumgpu.props.xalign = 0
                self.page4_grid.attach(self.tnumgpu, 2,0,1,1)
            # 
            self.pnlabel = Gtk.Label(label="Product Name")
            self.pnlabel.props.xalign = 1
            self.pnlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            self.page4_grid.attach(self.pnlabel, 1,1,1,1)
            self.tpnlabel = Gtk.Label()
            self.tpnlabel.props.xalign = 0
            self.page4_grid.attach(self.tpnlabel, 2,1,1,1)
            # 
            self.dvlabel = Gtk.Label(label="Driver Version")
            self.dvlabel.props.xalign = 1
            self.dvlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            self.page4_grid.attach(self.dvlabel, 1,2,1,1)
            self.tdvlabel = Gtk.Label()
            self.tdvlabel.props.xalign = 0
            self.page4_grid.attach(self.tdvlabel, 2,2,1,1)
            # 
            self.mmlabel = Gtk.Label(label="Total Memory")
            self.mmlabel.props.xalign = 1
            self.mmlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            self.page4_grid.attach(self.mmlabel, 1,3,1,1)
            self.tmmlabel = Gtk.Label()
            self.tmmlabel.props.xalign = 0
            self.page4_grid.attach(self.tmmlabel, 2,3,1,1)
            # 
            self.umlabel = Gtk.Label(label="Memory Used")
            self.umlabel.props.xalign = 1
            self.umlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            self.page4_grid.attach(self.umlabel, 1,4,1,1)
            self.tumlabel = Gtk.Label()
            self.tumlabel.props.xalign = 0
            self.page4_grid.attach(self.tumlabel, 2,4,1,1)
            # 
            self.tlabel = Gtk.Label(label="Temperature")
            self.tlabel.props.xalign = 1
            self.tlabel.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            self.page4_grid.attach(self.tlabel, 1,5,1,1)
            self.ttlabel = Gtk.Label()
            self.ttlabel.props.xalign = 0
            self.page4_grid.attach(self.ttlabel, 2,5,1,1)
            #
            self.fnvidia()
        else:
            # set an alternative name for the gpu
            igpu = subprocess.check_output('lspci | grep VGA | cut -d ":" -f3', shell=True).decode().strip()
            self.label11.set_text(igpu)


############ PAGE 1
        
    # os.uname
    def os_infos(self):
        u_sysname = os.uname().sysname
        u_username = psutil.Process().username()
        uname_list = os.uname()
        u_name = uname_list.sysname
        u_nodename = uname_list.nodename
        u_release = uname_list.release
        u_dmname = os.environ['XDG_CURRENT_DESKTOP']
        u_totmem = psutil.virtual_memory().total
        u_swapmem = 0
        try:
            u_swapmem = psutil.swap_memory().total
            if u_swapmem == None:
                u_swapmem = 0
        except:
            u_swapmem = 0
        # partitions
        partitions = psutil.disk_partitions(all=False)
        num_partitions = len(partitions)
        # check the moutpoint
        home_partition = ""
        for i in range(num_partitions):
            if partitions[i].mountpoint == "/":
                root_partition = partitions[i].device
                root_fstype = partitions[i].fstype
                root_disk_usage = psutil.disk_usage('/')
                root_disk_total = self.el_size(root_disk_usage.total)
            if partitions[i].mountpoint == "/home":
                home_partition = partitions[i].device
                home_fstype = partitions[i].fstype
                home_disk_usage = psutil.disk_usage('/home')
                home_disk_total = self.el_size(home_disk_usage.total)
                home_disk_used = self.el_size(home_disk_usage.used)
        # processor
        u_proc_num = psutil.cpu_count()
        u_proc_num_real = psutil.cpu_count(logical=False)
        u_proc_model = ""
        try:
            f = open('/proc/cpuinfo', 'r')
            for line in f:
                if line.rstrip('\n').startswith('model name'):
                    u_proc_model_name = line.rstrip('\n').split(':')[1].strip()
                    break;
            f.close()
        except:
            u_proc_model_name("NN")
        if u_proc_num_real == u_proc_num:
            self.label10.set_text(u_proc_model_name+" x "+str(u_proc_num_real))
        else:
            self.label10.set_text(u_proc_model_name+" x ("+str(u_proc_num_real)+"+"+str(u_proc_num)+")")
        # set the logo
        if u_sysname == "Linux":
            pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_scale('Tux.svg', 100, 100, 0)
            self.logop.set_from_pixbuf(pixbuf)
        else:
            pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_scale('Tux.svg', 100, 100, 0)
            self.logop.set_from_pixbuf(pixbuf)
        
        # set the labels
        self.labelun.set_text(u_username or "")
        self.label0.set_text(u_nodename or "")
        self.label1.set_text(self.name_distro() or uname_list.version or "")
        self.label2.set_text(u_release or "")
        self.label3.set_text(u_dmname or "")
        self.label4.set_text(str(self.el_size(u_totmem)) or "")
        self.label5.set_text(str(self.el_size(u_swapmem)) or "")
        self.label6.set_text(root_partition+" - "+root_fstype)
        self.label8.set_text(str(root_disk_total))
        if home_partition:
            # home partition and fstype
            label7t = Gtk.Label(label="Home device and size")
            label7t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            label7t.props.xalign = 1
            self.grid.attach(label7t, 1,9,1,1)
            label7 = Gtk.Label()
            label7.props.xalign = 0
            self.grid.attach(label7, 2,9,1,1)
            # home disk total - used
            label9t = Gtk.Label(label="Home Disk Size")
            label9t.override_color(Gtk.StateFlags.NORMAL, OVVERIDE_TEXT_COLOR)
            label9t.props.xalign = 1
            self.grid.attach(label9t, 1,10,1,1)
            label9 = Gtk.Label()
            label9.props.xalign = 0
            self.grid.attach(label9, 2,10,1,1)
            #
            label7.set_text(home_partition+" - "+home_fstype)
            label9.set_text(str(home_disk_total)+" - "+str(home_disk_used))

    # the name of the distro
    def name_distro(self):
        try:
            with open("/etc/os-release") as f:
                lline = f.readline().split("=")[1].replace('"',"").strip()
                return lline
        except:
            try:
                with open("/etc/issue") as f:
                    return f.read().replace("\n","").replace("\l","").strip()
            except:
                return ""

    #  size in the readable format
    def el_size(self, esize):
        if esize == 0 or esize == 1:
            oesize = str(esize)+" byte"
        elif esize//1024 == 0:
            oesize = str(esize)+" bytes"
        elif esize//1048576 == 0:
            oesize = str(round(esize/1024, 3))+" KB"
        elif esize//1073741824 == 0:
            oesize = str(round(esize/1048576, 3))+" MB"
        elif esize//1099511627776 == 0:
            oesize = str(round(esize/1073741824, 1))+" GiB"
        else:
            oesize = str(round(esize/1099511627776, 1))+" GiB"
        
        return oesize

################## PAGE 2

    # memory and swap
    def mem_function(self):
        mem = psutil.virtual_memory()
        mswap = psutil.swap_memory()
        # total
        self.mem_list[0].set_text(self.el_size(mem.total))
        # available
        self.mem_list[1].set_text(self.el_size(mem.available))
        # used
        self.mem_list[2].set_text(self.el_size(mem.used)+" ("+str(mem.percent)+"%)")
        # free
        self.mem_list[3].set_text(self.el_size(mem.free))
        # buffers and cached
        self.mem_list[4].set_text(self.el_size(mem.buffers+mem.cached))
        # shared
        self.mem_list[5].set_text(self.el_size(mem.shared))
        # swap
          # total
        self.mem_list[6].set_text(self.el_size(mswap.total) or "")
          # used and percent
        self.mem_list[7].set_text((self.el_size(mswap.used)+" ("+str(mswap.percent)+"%)") or "")

    # network
    def fnetwork(self):
        tnet = psutil.net_io_counters()
        # bytes and packets sent
        self.net_list[0].set_text(str(self.el_size(tnet.bytes_sent))+" - "+str(tnet.packets_sent))
        # bytes and packets received
        self.net_list[1].set_text(str(self.el_size(tnet.bytes_recv))+" - "+str(tnet.packets_recv))
        # errin and dropin
        self.net_list[2].set_text(str(tnet.errin)+" - "+str(tnet.dropin))
        # errout and dropout
        self.net_list[3].set_text(str(tnet.errout)+" - "+str(tnet.dropout))
        

################## PAGE 3

    # the background
    def on_draw(self, widget, cr):
        X = self.cpu_area.get_allocated_width()
        Y = self.cpu_area.get_allocated_height()
        
        cr.set_source_rgb(1, 1, 1)
        cr.paint()
        
        cr.set_source_rgb(0, 0, 0)
        cr.set_line_width(1)
        cr.set_tolerance(0.1)
        cr.move_to(1, 1)
        cr.rel_line_to(X-2, 0)
        cr.rel_line_to(0, Y-2)
        cr.rel_line_to(-X+2, 0)
        cr.close_path()
        cr.stroke()
        
        cr.set_source_rgb(0.5, 0.5, 0.5)
        cr.set_line_width(1)
        cr.set_tolerance(0.1)
        
        cr.move_to(1, Y/3)
        cr.rel_line_to(X-2, 0)
        cr.stroke()
        
        cr.move_to(1, Y/3*2)
        cr.rel_line_to(X-2, 0)
        cr.stroke()

    def draw_line(self, widget, cr):
        
        X = self.cpu_area.get_allocated_width()
        Y = self.cpu_area.get_allocated_height()
        cr.set_source_rgb(1, 0, 0)
        cr.set_line_cap(1)
        
        for p in range(len(self.dcpu)-1):
            
            lline_width = 2
            if p == 0:
                cr.set_line_width(lline_width)
                cr.move_to((X/(len(self.dcpu)-1)*p)+lline_width, Y-(float(self.dcpu[p])*Y/100)-lline_width)
                x = X/(len(self.dcpu)-1)*(p+1)
                y = Y-(float(self.dcpu[p+1])*Y/100)
                cr.line_to(x, y-lline_width)
                cr.stroke()
            elif p == (len(self.dcpu)-2):
                cr.set_line_width(lline_width)
                cr.move_to(X/(len(self.dcpu)-1)*p, Y-(float(self.dcpu[p])*Y/100)-lline_width)
                x = (X/(len(self.dcpu)-1)*(p+1))-lline_width
                y = (Y-(float(self.dcpu[p+1])*Y/100))
                cr.line_to(x, y-lline_width)
                cr.stroke()
            else:
                cr.set_line_width(lline_width)
                cr.move_to(X/(len(self.dcpu)-1)*p, Y-(float(self.dcpu[p])*Y/100)-lline_width)
                x = X/(len(self.dcpu)-1)*(p+1)
                y = Y-(float(self.dcpu[p+1])*Y/100)
                cr.line_to(x, y-lline_width)
                cr.stroke()
            
    # CPU level
    def on_draw_level(self, widget, cr):
        X = self.cpu_level.get_allocated_width()
        Y = self.cpu_level.get_allocated_height()
        cr.set_source_rgb(0, 0, 0)
        cr.paint()
        cr.set_source_rgb(0, 1, 0)
        cr.rectangle(X/5, Y/5, X*3/5, Y*3/5)
        cr.fill()
        cr.set_source_rgba(0, 0, 0, 0.80)
        YY = (100-float(self.dcpu[-1]))/100 
        cr.rectangle(X/5, Y/5, X*3/5, Y*3/5*YY)
        cr.fill()

        cr.set_font_size(14)
        cr.set_source_rgb(1, 1, 1)
        (x, y, width, height, dx, dy) = cr.text_extents("Cpu")
        cr.move_to((X-width)/2, Y-10)
        cr.text_path("Cpu")
        cr.clip()
        cr.paint()

    # single core cpu usage level
    def on_ncpu_level(self, widget, cr, ncpu):
        cpu_core_use = psutil.cpu_percent(percpu=True)
        X = self.ncpu_level.get_allocated_width()
        Y = self.ncpu_level.get_allocated_height()
        xx = self.cpu_level.get_allocated_width()
        yy = self.cpu_level.get_allocated_height()
        
        if (xx+10)*ncpu >= X:
            PAD = X/ncpu
        else:
            PAD = xx
       
        for i in range(ncpu):
            cr.set_source_rgb(0, 0, 0)
            cr.rectangle(PAD*i+10, 0, PAD-20, Y)
            cr.fill()
            cr.set_source_rgb(0, 1, 0)
            cr.rectangle((PAD*i+10)+(PAD-20)/3/2, Y/5, (PAD-20)*2/3, Y*3/5)
            cr.fill()
            cr.set_source_rgba(0, 0, 0, 0.80)
            YY = (100-float(cpu_core_use[i]))/100 
            cr.rectangle((PAD*i+10)+(PAD-20)/3/2, Y/5, (PAD-20)*2/3, Y*3/5*YY)
            cr.fill()
        
        for i in range(ncpu): 
            
            cr.set_font_size(14)
            cr.set_source_rgb(1, 1, 1)
            (x, y, width, height, dx, dy) = cr.text_extents("Cpu0")
            cr.move_to(((PAD*i+10)+(PAD-20-width)/2), Y-10)
            cr.text_path("Cpu"+str(i+1))
        cr.clip()
        cr.paint()

    # cpu current temperatures
    def cpu_curr_temps(self):
        if PSUTIL_V >= (5,1,0):
            for i in range(self.n_cpu_range):
                self.tlabel_list[i].set_text(str(int(psutil.sensors_temperatures()['coretemp'][i].current)))

    # cpu current frequencies
    def cpu_curr_freq(self):
        if PSUTIL_V >= (5,1,0):
            for i in range(self.n_cpu_freq):
                self.flabel_list[i].set_text(str(int(psutil.cpu_freq(percpu=True)[i].current)))

################# PAGE 4

    # gpu
    def fnvidia(self):
        # gpu name
        self.tpnlabel.set_text(subprocess.check_output("nvidia-smi --query-gpu=gpu_name --format=csv,noheader",shell=True).decode().strip())
        # driver version
        self.tdvlabel.set_text(subprocess.check_output("nvidia-smi --query-gpu=driver_version --format=csv,noheader",shell=True).decode().strip())
        # total memory
        totmem = subprocess.check_output("nvidia-smi --query-gpu=memory.total --format=csv,noheader",shell=True).decode().strip()
        self.tmmlabel.set_text(totmem)
        # used memory
        usedmem = subprocess.check_output("nvidia-smi --query-gpu=memory.used --format=csv,noheader",shell=True).decode().strip()
        self.tumlabel.set_text(usedmem)
        # gpu temperature
        self.ttlabel.set_text(subprocess.check_output("nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader",shell=True).decode().strip())


########################

    def loop_func(self):
        GLib.timeout_add_seconds(LOOP_INTERVAL, self.mem_timeout)
        
    def mem_timeout(self):
        
        self.dcpu.append(psutil.cpu_percent())
        # the cpu usage diagram
        self.cpu_area.queue_draw()
        # the cpu usage level
        self.cpu_level.queue_draw()
        # the cpu usage of each cpu core
        self.ncpu_level.queue_draw()
        # the frequency of each cpu core
        self.cpu_curr_freq()
        # the current temperature of each cpu core
        self.cpu_curr_temps()
        # memory
        self.mem_function()
        # network
        self.fnetwork()
        # gpu
        if self.is_nvidia:
            self.fnvidia()

        if TIMEOUT == 1:
            return False
        else:
            return True

app = mainwindow()
app.show_all()
Gtk.main()
