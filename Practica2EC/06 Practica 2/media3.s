.section .data
ifndef TEST
define TEST 20
endif

.macro linea
if TEST==1
  .int -1, -1, -1, -1
elif TEST==2
  .int 0x04000000, 0x04000000, 0x04000000, 0x04000000
elif TEST==3
  .int 0x08000000, 0x08000000, 0x08000000, 0x08000000
elif TEST==4
  .int 0x10000000, 0x10000000, 0x10000000, 0x10000000
elif TEST==5
  .int 0x7FFFFFFF, 0x7FFFFFFF, 0x7FFFFFFF, 0x7FFFFFFF
elif TEST==6
  .int 0x80000000, 0x80000000, 0x80000000, 0x80000000
elif TEST==7
  .int 0xF0000000, 0xF0000000, 0xF0000000, 0xF0000000
elif TEST==8
  .int 0xF8000000, 0xF8000000, 0xF8000000, 0xF8000000
elif TEST==9
  .int 0xF7FFFFFF, 0xF7FFFFFF, 0xF7FFFFFF, 0xF7FFFFFF
elif TEST==10
  .int 100000000, 100000000, 100000000, 100000000
elif TEST==11
  .int 200000000, 200000000, 200000000, 200000000
elif TEST==12
  .int 300000000, 300000000, 300000000, 300000000
elif TEST==13
  .int 2000000000, 2000000000, 2000000000, 2000000000
elif TEST==14
  .int 3000000000, 3000000000, 3000000000, 3000000000
elif TEST==15
  .int -100000000, -100000000, -100000000, -100000000
elif TEST==16
  .int -200000000, -200000000, -200000000, -200000000
elif TEST==17
  .int -300000000, -300000000, -300000000, -300000000
elif TEST==18
  .int -2000000000, -2000000000, -2000000000, -2000000000
elif TEST==19
  .int -3000000000, -3000000000, -3000000000, -3000000000
else
  .error "Definir TEST entre 1..19"
endif
  .endm


lista .irpc i,12345678
linea
.endr

longlista:	.int   (.-lista)/4
cociente .int -1
resto .int .1
formato: 	.ascii "resultado \t = %18ld (sgn)\n"
            .ascii "\t\t = 0x%18lx (hex)\n"
            .asciz "\t\t = 0x %08x %08x \n"

.section .text
main: .global  main

  mov  $lista, %ebx
  mov  longlista, %ecx
  call suma		# == suma(&lista, longlista);
  push resto
  push resto
  push cociente
  push cociente
  push $formatome
  call printf
  mov $20, %esp
  mov $1, %eax
  mov $0, %ebx
  int $0x80

suma:
  push %edx
  mov  $0, %eax
  mov  $0, %edx
  mov $0, %edi
  mov $0, %esi

bucle:
  mov  (%ebx,%esi,4), %eax
  cltd
  add %eax, %edi
  adc %edx, %ebp
  jmp return_loop

return_loop:
  inc %esi
  cmp %esi,%ecx
  jne bucle
  mov %edi,%eax
  idiv %ecx
  mov %eax, cociente
  mov %edx, resto
  pop %edx
  ret
