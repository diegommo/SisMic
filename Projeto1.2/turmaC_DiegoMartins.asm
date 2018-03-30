;NOME: DIEGO MARTINS DE OLIVEIRA
;MATRÍCULA: 160049300
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
P1:			mov.w	#vetor, R5
			call	#ORDENA
			jmp		$
			nop
ORDENA:		mov.b	@R5, R7
			mov.b	@R5, R8
LOOPG:		inc		R5
			mov.w	R5, R6
			dec		R7
			mov.b	R7,R8
			jnz		LOOP
			ret
LOOP:		inc		R6
			cmp.b	0(R5), 0(R6)
			jge		FIM
			mov.b	@R6, R9
			mov.b	0(R5),0(R6)
			mov.b	R9, 0(R5)
FIM:		dec 	R8
			jz		LOOPG
			jmp		LOOP
			nop
                                            

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            .data
vetor:		.byte	22, "DIEGOMARTINSDEOLIVEIRA"
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
