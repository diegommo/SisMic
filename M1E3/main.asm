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
M1E3:		mov		#vetor,R5
			call	#M2M4
			jmp		$
			nop
M2M4:		mov.b	#0,R6					;R6 = contador M2
			mov.b	#0,R7					;R7 = contador M4
			mov.b	#0,R8					;R8 = contator
			mov.b	@R5,R8
LOOP:		inc.w	R5
			bit.b	#1b,0(R5)				;Testa se é multiplo de 2
			jnz		FIM
TESTEM4:	inc.w	R6
			bit.b	#11b,0(R5)				;Testa se é múltiplo de 4
			jnz		FIM
			inc.w	R7
FIM:		dec.w	R8						;Verifica se chegamos ao fim do vetor
			jnz		LOOP
			ret

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            .data
vetor:	.byte	10,"DIEGOMOISES"
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
