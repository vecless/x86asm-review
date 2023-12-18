#
# Prints "Hello world" 10 times
#

.section .data
output:
    .ascii "Hello world\n"
.section .text
.global _start
_start:
    movl $0, %ecx       # ecx = 0
    whileloop:
    cmpl $10, %ecx      # cmp(subtrahend, minuend)
    jge endwhileloop    # jump if minuend >= subtrahend
    call say_hello
    incl %ecx           # ecx = ecx + 1
    jmp whileloop

say_hello:
    # Callee setup
    push %ebp           # save old base pointer
    movl %esp, %ebp     # set new base pointer
    push %ecx           # save the value of registers that the fn uses
                        # no need to save other registers in this case
    # Subroutine body
    # sys_write(1, output, 12)
    movl $4, %eax
    movl $1, %ebx
    movl $output, %ecx
    movl $12, %edx
    int $0x80           # invoke syscall
    # Teardown
    pop %ecx            # restore the register values
    movl %ebp, %esp     # deallocate any local variables
    pop %ebp            # restore the caller base pointer
    ret
    endwhileloop:

    # sys_exit(0)
    movl $1, %eax
    movl $0, %ebx
    int $0x80
