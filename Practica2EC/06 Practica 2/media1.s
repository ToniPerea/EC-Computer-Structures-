.section .data
lista:		.int 0x10000000, 0x10000000, 0x10000000, 0x10000000,
            .int 0x10000000, 0x10000000, 0x10000000, 0x10000000,
            .int 0x10000000, 0x10000000, 0x10000000, 0x10000000,
            .int 0x10000000, 0x10000000, 0x10000000, 0x10000000

longlista:	.int   (.-lista)/4
resultado:	.quad 0
  formato: 	.asciz	"suma = %lu = 0x%lx hex\n"

.section .text
main: .global  main

  mov  $lista, %rbx
  mov  longlista, %rcx
  call suma		# == suma(&lista, longlista);
  mov  %eax, resultado
  mov  %eax, resultado+4
  mov $formato, %rdi
  mov resultado, %rsi
  mov resultado, %rdx
  mov resultado, %ecx
  mov $0, %eax
  call printf
  mov resultado, %edi
  call _exit
  ret

suma:
	mov  $0, %eax
	mov  $0, %edx
    mov $0, %rsi
bucle:
	add (%rbx,%rsi,4), %eax
    jnc %rsi
	jnc return_loop
    inc %edx
    ret

return_loop:
  inc %rsi
  cmp %rsi,%rcx
  jne bucle
  ret
