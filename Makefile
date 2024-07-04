
ASM = nasm
GCC = gcc
LINKER = ld

SRC_DIR = src
BUILD_DIR = build


.PHONY: all link kernel clean always

# Link
link: kernel
	$(LINKER) -m elf_i386 -T $(SRC_DIR)/link.ld -o $(BUILD_DIR)/kernel $(BUILD_DIR)/kernel_asm.o $(BUILD_DIR)/kernel_c.o


# Kernel
kernel:	$(BUILD_DIR)/kernel_asm.o $(BUILD_DIR)/kernel_c.o
$(BUILD_DIR)/kernel_asm.o: always
	$(ASM) -f elf32 $(SRC_DIR)/kernel/kernel.asm -o $(BUILD_DIR)/kernel_asm.o
$(BUILD_DIR)/kernel_c.o: always
	$(GCC) -fno-stack-protector -m32 -c $(SRC_DIR)/kernel/kernel.c -o $(BUILD_DIR)/kernel_c.o





always:
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)/*
