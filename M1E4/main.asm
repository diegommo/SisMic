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

M1E4:		mov.w	#vetor,R5
			call	#EXTREMOS
			jmp		$
EXTREMOS:	mov.w	@R5,R8					;R8 = contador
			incd 	R5
			mov.w	@R5,R6					;R6 = menor elemento
			mov.w	@R5,R7					;R7 = maior elemento
LOOP:		incd	R5
			cmp.w	R6,0(R5)				;Atual é menor que o anterior?
			jl		SUBSME					;Sim, pula para substituir R6
			cmp.w	R7,0(R5)				;Atual é maior que o anterior?
			jn		FINAL					;R7 ainda é maior, pular para FINAL
			mov.w	@R5,R7					;Substitui R7, já que @R5 é maior
			jmp		FINAL
SUBSME:		mov.w	@R5,R6					;Substitui R6, já que @R5 é menor
FINAL:		dec		R8
			jnz		LOOP
			ret


;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            .data
vetor:		.word		8, 160, 49, 300, -1997, 160, 114, 111, -1998
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
