Infineon XMC4500 Relax (Lite) Linux/UNIX template
===================

Template for Infineon's XMC4500 Relax (Lite) Kit for UNIX-based operating systems

Requirements:

* CMSIS folder from DAVE 3: http://www.infineon.com/dave
* ARM GCC crosscompiler, e.g. 
 * GCC ARM Embedded: https://launchpad.net/gcc-arm-embedded
 * Sourcery CodeBench Lite (EABI): http://codesourcery.com/gnu_toolchains/arm
* For deployment/JTAG-Debugging:
 * J-Link Linux Software http://www.segger.com/jlink-software.html
* GNU Make

Preperations
------------------------
You need to rename a file inside the CMSIS directory, because else gcc is not
able find the System_XMD4500.c file. This seems to be a UNIX-only problem since
windows-gcc is case-insensitive regarding filenames.

        mv CMSIS/Infineon/XMC4500_series/Source/system_XMD4500.c CMSIS/Infineon/XMC4500_series/Source/System_XMD4500.c

Usage
-------------------------
1. Edit the Makefile and adapt the CMSIS Path.
2. Type _make_
3. Connect your evaluation board to usb, start the gdb-server with:

       JLinkGDBServer -Device XMC4500-1024 -if SWD

4. Type _make install_

Getting J-Link Tools
-------------------------

You need to provide your serial number to download the J-Link Tools.
To get them, you can connect your board to a windows pc and install
the DAVE supplied J-Link package. After opening J-Link Commander you
will see the serial number in the command window.

