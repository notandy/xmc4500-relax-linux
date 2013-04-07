TARGET = blink

#### Setup ####
#CMSIS         = /YOUR/PATH/TO/CMSIS
CMSIS = /home/andy/exchange/workspace/CMSIS
SRC           = $(wildcard src/*.c)
TOOLCHAIN     = arm-none-eabi
UC            = XMC4500
UC_ID         = 4503
CPU           = cortex-m4
FPU           = fpv4-sp-d16
FABI          = softfp
LIBS          = -larm_cortexM4_mathL_2
GDB_ARGS      = -ex "target remote :2331" -ex "monitor reset" -ex "load" -ex "monitor reset" -ex "monitor go"

LINKER_FILE = ./src/xmc4500.ld
CMSIS_SRC += $(CMSIS)/Infineon/$(UC)_series/Source/System_$(UC).c

CC   = $(TOOLCHAIN)-gcc
CP   = $(TOOLCHAIN)-objcopy
OD   = $(TOOLCHAIN)-objdump
GDB  = $(TOOLCHAIN)-gdb
SIZE = $(TOOLCHAIN)-size

CFLAGS = -mthumb -mcpu=$(CPU) -mfpu=$(FPU) -mfloat-abi=$(FABI)
CFLAGS+= -O0 -ffunction-sections -fdata-sections
CFLAGS+= -MD -std=c99 -Wall -fms-extensions
CFLAGS+= -DUC_ID=$(UC_ID) -DARM_MATH_CM4
CFLAGS+= -g3 -fmessage-length=0 -I$(CMSIS)/Include
CFLAGS+= -I$(CMSIS)/Infineon/Include
CFLAGS+= -I$(CMSIS)/Infineon/$(UC)_series/Include
LFLAGS = -nostartfiles -L$(CMSIS)/Lib/GCC -Wl,--gc-sections
CPFLAGS = -Obinary
ODFLAGS = -S

OBJS  = $(SRC:.c=.o)
OBJS += src/System_$(UC).o

#### Rules ####
all: $(OBJS) $(TARGET).axf $(TARGET)

src/System_$(UC).o: $(CMSIS_SRC)
	$(CC) -c $(CFLAGS) $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

$(TARGET).axf: $(OBJS)
	mkdir -p bin/
	$(CC) -T $(LINKER_FILE) $(LFLAGS) $(CFLAGS) -o bin/$(TARGET).axf $(OBJS) $(LIBS)

$(TARGET): $(TARGET).axf
	$(CP) $(CPFLAGS) bin/$(TARGET).axf bin/$(TARGET).bin
	$(OD) $(ODFLAGS) bin/$(TARGET).axf > bin/$(TARGET).lst
	$(SIZE) bin/$(TARGET).axf

install: $(TARGET)
	$(GDB) bin/$(TARGET).axf $(GDB_ARGS)

clean:
	rm -f src/*.o src/*.d bin/*
