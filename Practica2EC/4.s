.section .data
    .macro linea #.int 1,1,1,1
    .endm 
    lista: .irpc i,12345678
    linea
    .endr

longlista: .int (.-lista)/4
cociente: .int -1
resto: .int -1
formato: .ascii "media:\n\t cociente = %8d = 0x%08x = hex\n\t resto = %8d = 0x%08x = hex\n\0"


.section .text
main: .global main
    mov $lista, %ebx
    mov longlista, %ecx
    call suma
    push resto 
    push resto 
    push cociente 
    push cociente 
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
    mov %edi,%eax
    idiv %ecx
    mov %eax, cociente 
    mov %edx, resto
    pop %edx
    ret