    .globl bl_entrypoint

    .cfi_sections .debug_frame
    .section .text.asm.bl_entrypoint, "ax"
    .type bl_entrypoint, %function
    .cfi_startproc
    .align 2
bl_entrypoint:
    mov x0, #0
    mov x1, #1
    mov x2, #2
    mov x3, #3
    mov x4, #4
    mov x5, #5
    mov x6, #6
    mov x7, #7
    mov x8, #8
    mov x9, #9
    .cfi_endproc
    .size bl_entrypoint, . - bl_entrypoint
