.section .data
    lista: .int 1,1,1,1,1,1,1,2
    longlista: .int (.-lista)/4
    resultado: .quad -1
    formato: .ascii "suma = %lld = %llx hex\n\0"

.section .text

main: .global main
    mov $lista, %ebx
    mov longlista, %ecx
    call suma
    mov %edi, resultado
    mov %ebp, resultado+4
    push resultado+4
    push resultado
    push resultado+4
    push resultado
    push $formato
    call printf
    mov $20 ,%esp
    mov $1, %eax
    mov $0, %ebx
    int $0x80

suma:
    push %edx
    mov $0, %eax
    mov $0, %edx
    mov $0, %edi
    mov $0, %esi

bucle: 
    mov (%ebx,%esi,4),%eax
    cltd
    add %eax,%edi
    adc %edx,%ebp
    jmp finalbucle

finalbucle:
    inc %esi
    cmp %esi,%ecx
    jne bucle
    pop %edx
    ret