.section .data
ifndef TEST
define TEST 9
endif

.macro linea
if TEST==1
    .int 1,1,1,1
elif TEST==2
    .int 0x0fffffff, 0x0fffffff, 0x0fffffff, 0x0fffffff
elif TEST==3
    .int 0x10000000, 0x10000000, 0x10000000, 0x10000000
elif TEST==4
    .int 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF
elif TEST==5
    .int -1, -1, -1, -1
elif TEST==6
    .int 200000000, 200000000, 200000000, 200000000
elif TEST==2
    .int  300000000, 300000000,  300000000, 300000000
elif TEST==8
    .int 5000000000,5000000000,5000000000,5000000000
else
    .error "Definir TEST entre 1..8"
endif .
    endm

lista:		.int 1, 1, 1, 1, 1, 1, 1,2
longlista:	.int   (.-lista)/4
resultado:	.quad -1
formato: 	.ascii "resultado \t = %18lu (uns)\n"
            .ascii "\t\t = 0x%18lx (hex)\n"
            .asciz "\t\t = 0x %08x %08x \n"

.section .text
main: .global  main

  mov  $lista, %rbx
  mov  longlista, %rcx
  call suma		# == suma(&lista, longlista);
  mov  %eax, resultado
  mov  %eax, resultado+4
  push resultado+4
  push resultado
  push resultado+4
  push resultado
  push $formato
  call printf
  mov $20, %esp
  mov $1, %eax
  mov $0, %rbx
  int $0x80

suma:
  push %rdx
  mov  $0, %eax
  mov  $0, %edx
  mov $0, %edi
  mov $0, %rsi

bucle:
  add  (%rbx,%rsi,4), %eax
  cltd
  add %eax, %edi
  adc %edx, %ebp
  jmp return_loop

return_loop:
  inc %rsi
  cmp %rsi, %rcx
  jne bucle
  pop %rdx
  ret
