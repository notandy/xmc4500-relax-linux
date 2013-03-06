Infineon XMC4500 Relax (Lite) Linux/UNIX template
===================

Template for Infineon's XMC4500 Relax (Lite) Kit for UNIX-based operating systems

Requirements:

* CMSIS folder from DAVE 3: http://www.infineon.com/dave
* ARM GCC crosscompiler, e.g. 
** GCC ARM Embedded: https://launchpad.net/gcc-arm-embedded
** Sourcery CodeBench Lite (EABI): http://codesourcery.com/gnu_toolchains/arm
* For deployment/JTAG-Debugging:
** J-Link Linux Software http://www.segger.com/jlink-software.html
* GNU Make

Usage
-------------------------
1. Edit the Makefile and adapt the CMSIS Path.
2. Type _make_
3. Connect your evaluation board to usb, start the gdb-server with:

       JLinkGDBServer -Device XMC4500-1024 -if SWD

4. Type _make install_

Getting J-Link Tools
-------------------------

You need to provide your serial number to download the J-Link Tools,
to get them you can connect your board to a windows pc and install
the DAVE supplied J-Link package. After opening J-Link Commander you
will see the SN.

