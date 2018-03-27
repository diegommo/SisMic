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
M1E2:		mov.w	#vetor,R5
			call	#MAIOR16
			jmp		$
MAIOR16:	mov.w	#0x00,R6				;R6 = maior elemento
			mov.w	#0,R7					;R7 = frequência do maior
			mov.w	@R5,R8					;R8 = contador
LOOP:		incd.w	R5
			cmp.w	@R5,R6
			jn		label2
label1:		inc.w	R7
			jmp		FIM
label2:		mov.w	@R5,R6
			mov.w	#1,R7
FIM:		dec.w	R8
			jnz		LOOP
			ret

                                            

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            .data
vetor:		.byte	5, 0, "DIEGOMOISES"

;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
