;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
M1E7:		call	#FIB
			jmp		$
			nop
FIB:		mov.w	#0x2400, R5				;(end.)mov.w	#0, 0(R6)Inicio do vetor
			mov.w	#0x2404, R6				;(end.)Primeiro elemento do vetor
			mov.w	#20, 0(R5)				;Quantidade de elementos
			incd	R5
			mov.w	#0, 0(R5)				;Primeiro elemento do vetor
			mov.w	#1, 0(R6)				;Segundo elemento do vetor
			mov.b	#9, R8					;R8 = contador
LOOP:		mov.w	0(R6), R7
			add		0(R5), R7
			add		#4, R5
			mov.w	R7, 0(R5)
			mov.w	0(R5), R7
			add		0(R6), R7
			add		#4, R6
			mov.w	R7, 0(R6)
			dec		R8
			jnz		LOOP
			ret

                                            

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
