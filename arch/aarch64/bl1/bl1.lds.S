#include "config/virt_cfg.h"

OUTPUT_FORMAT("elf64-littleaarch64")
OUTPUT_ARCH(aarch64)
ENTRY(bl_entrypoint)

MEMORY {
    ROM (rx): ORIGIN = ROM_BASE, LENGTH = ROM_SIZE
    RAM (rwx): ORIGIN = SRAM_BASE, LENGTH = SRAM_SIZE
}

SECTIONS
{
    . = LOAD_BASE;
    ASSERT(. == ALIGN(PAGE_SIZE), "BL_RO_BASE address is not aligned on a page boundary.")

    .text . : {
        __TEXT_START__ = .;

        *entrypoint.o(.text*)
        *(SORT_BY_ALIGNMENT(.text*))

        *(.vectors)
        . = ALIGN(PAGE_SIZE);

        __TEXT_END__ = .;
    } >ROM

    .ARM.extab . : {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } >ROM

    .ARM.exidx . : {
        *(.ARM.exidx* .gnu.linkonce.armexidx.*)
    } >ROM

    .rodata . : {
        __RODATA_START__ = .;

        *(SORT_BY_ALIGNMENT(.rodata*))
        . = ALIGN(8); 

        __RODATA_END__ = .;
         . = ALIGN(16);
    } >ROM

    . = BL_RW_BASE;
    ASSERT(BL_RW_BASE == ALIGN(0x1000), "BL_RW_BASE address is not aligned on a page boundary.")

    .data . : ALIGN(16) { 
        __DATA_START__ = .; 
        *(SORT_BY_ALIGNMENT(.data*)) __DATA_END__ = .; 
    } >RAM AT>ROM

    __DATA_RAM_START__ = __DATA_START__;
    __DATA_RAM_END__ = __DATA_END__;

    stacks (NOLOAD) : { 
        __STACKS_START__ = .; 
        *(normal_stacks) __STACKS_END__ = .; 
    } >RAM

    .bss (NOLOAD) : ALIGN(16) { 
        __BSS_START__ = .; 
        *(SORT_BY_ALIGNMENT(.bss*)) *(COMMON) . = ALIGN((1 << 6)); 
        __BSS_END__ = .; 
    } >RAM

    coherent_ram (NOLOAD) : ALIGN(((1) << (12))) {
        __COHERENT_RAM_START__ = .;
        *(coherent_mem)
        __COHERENT_RAM_END_UNALIGNED__ = .;
        . = ALIGN(((1) << (12)));
        __COHERENT_RAM_END__ = .;
    } >RAM

    __BL_RAM_START__ = ADDR(.data);
    __BL_RAM_END__ = .;

    __DATA_ROM_START__ = LOADADDR(.data);
    __DATA_SIZE__ = SIZEOF(.data);
    __BL_ROM_END__ = __DATA_ROM_START__ + __DATA_SIZE__;
    ASSERT(__BL_ROM_END__ <= BL_RO_LIMIT, "BL's ROM content has exceeded its limit.")

    __BSS_SIZE__ = SIZEOF(.bss);
    __COHERENT_RAM_UNALIGNED_SIZE__ =  __COHERENT_RAM_END_UNALIGNED__ - __COHERENT_RAM_START__;
    ASSERT(. <= BL_RW_LIMIT, "BL's RW section has exceeded its limit.")
}