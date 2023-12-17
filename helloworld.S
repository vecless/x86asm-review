.section .data
output:
    .ascii "Hello world\n"
.section .text
.global _start
_start:
    # sys_write(1, output, 12)
    movl $4, %eax
    movl $1, %ebx
    movl $output, %ecx
    movl $12, %edx
    int $0x80

    # sys_exit(0)
    movl $1, %eax
    movl $0, %ebx
    int $0x80
