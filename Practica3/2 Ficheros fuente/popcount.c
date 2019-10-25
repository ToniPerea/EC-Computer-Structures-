// 9.- gcc suma_09_Casm.c -o suma_09_Casm -O / -Og -g

#include <stdio.h>		// para printf()
#include <stdlib.h>		// para exit()
#include <sys/time.h>		// para gettimeofday(), struct timeval

int resultado=0;

#define SIZE (1<<16)                   // tamaño suficiente para tiempo apreciable
     /* -------------------------------------------------------------------- */
#if TEST==1
/* -------------------------------------------------------------------- */
  #define SIZE 4
  unsigned lista[SIZE]={0x80000000, 0x00400000, 0x00000200, 0x00000001};
  #define RESULT 4
/* -------------------------------------------------------------------- */
#elif TEST==2
/* -------------------------------------------------------------------- */
    #define SIZE 8
    unsigned lista[SIZE]={0x7fffffff, 0xffbfffff, 0xfffffdff, 0xfffffffe,
                        0x01000023, 0x00456700, 0x8900ab00, 0x00cd00ef};
    #define RESULT 156
/* -------------------------------------------------------------------- */
#elif TEST==3
/* -------------------------------------------------------------------- */
    #define SIZE 8
    unsigned lista[SIZE]={0x0 , 0x01020408, 0x35906a0c, 0x70b0d0e0,
                        0xffffffff, 0x12345678, 0x9abcdef0, 0xdeadbeef};
    #define RESULT 116
/* -------------------------------------------------------------------- */
#elif TEST==4||TEST==0
/* -------------------------------------------------------------------- */
    #define NBITS 20
    #define SIZE (1<<NBITS) // tamaño suficiente para tiempo apreciable 
    unsigned lista[SIZE]; //unsigned para desplazamiento derecha lógico
    #define RESULT ( NBITS * ( 1 << NBITS-1 ) )      // pistas para deducir fórmula
/* -------------------------------------------------------------------- */
#else 
    #error"DefinirTESTentre0..4"
#endif
/* -------------------------------------------------------------------- */

#define WSIZE  8*sizeof(unsigned)

int popcount1(unsigned* array, size_t len)
{
    size_t i;
    long result = 0;
    for(int j = 0; j < len; j++){
        for (i = 0; i < WSIZE ; i++){ 
            result += array[j] & 0x1;
            array[j] >>= 1;
        } 
    }
    
  return result;
} 


int popcount2(unsigned* array, size_t len)
{
    long result = 0;
    unsigned x=0;
    for(int j = 0; j < len; j++){
        x=array[j];
        while (x){ 
            result += x & 0x1;
            x >>= 1;
        } 
    }
    return result;
} 


/*int popcount3(unsigned* array, size_t len)
{

}

int popcount4(unsigned* array, size_t len)
{
//...
}

int popcount5(unsigned* array, size_t len)
{
//...
}

int popcount6(unsigned* array, size_t len)
{
//...
}

int popcount7(unsigned* array, size_t len)
{
//...
}

int popcount8(unsigned* array, size_t len)
{
//...
}

int popcount9(unsigned* array, size_t len)
{
//...
}

int popcount10(unsigned* array, size_t len)
{
//...
}*/

void crono(int (*func)(), char* msg){
    struct timeval tv1,tv2;
    long           tv_usecs;
    gettimeofday(&tv1,NULL);
    resultado = func(lista, SIZE);
    gettimeofday(&tv2,NULL);
    tv_usecs = (tv2.tv_sec -tv1.tv_sec )*1E6+(tv2.tv_usec-tv1.tv_usec);
#if TEST==0  
    printf(    "%ld" "\n",      tv_usecs);
#else
    printf("resultado = %d\t", resultado);
    printf("%s:%9ld us\n", msg, tv_usecs);
#endif
}

int main()
{
#if TEST==0 || TEST==4
    size_t i;
    for(i = 0; i<SIZE; i++)
        lista[i]=i; 
#endif

    //crono(popcount1 , "popcount1 (lenguaje C -       for)");
    crono(popcount2 , "popcount2 (lenguaje C -     while)");
    //crono(popcount3 , "popcount3 (leng.ASM-body while 4i)");
    /*crono(popcount4 , "popcount4 (leng.ASM-body while 3i)");
    crono(popcount5 , "popcount5 (CS:APP2e 3.49-group 8b)");
    crono(popcount6 , "popcount6 (Wikipedia- naive - 32b)");
    crono(popcount7 , "popcount7 (Wikipedia- naive -128b)");
    crono(popcount8 , "popcount8 (asm SSE3 - pshufb 128b)");
    crono(popcount9 , "popcount9 (asm SSE4- popcount 32b)");
    crono(popcount10, "popcount10(asm SSE4- popcount128b)");*/

#if TEST != 0
    printf("calculado = %d\n", RESULT);
#endif
exit(0); }