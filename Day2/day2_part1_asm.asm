; file: day2_part1_asm.asm
; Verify that input string contains a count of search character
; in the range specified by [min,max]

segment .text
        global  day2_part1_asm

; Parameters:
; #1: (EBP+8): String pointer
; #2: (EBP+12): Search character
; #3: (EBP+16): Min count of search character
; #4: (EBP+20): Max count of search character
;
; Note: params are always in multiples of 4 bytes
;
; Local variables:
; #1 (EBP-4): Counts of search character (1 byte)
;
; Return value: 1 if passwd is valid, 0 is password is invalid
day2_part1_asm:
        push ebp     ; Save the old base pointer value.
        mov ebp, esp ; Set the new base pointer value.
        sub esp, 1   ; Make room for one 1-byte local variable.
        push edi     ; Save the values of registers that the function
        push ebx

        mov byte [ebp-4], 0     ; Initialize search char count to zero

char_loop_start:
        mov edi, [ebp+8]
        mov eax, 0
char_loop:
        mov bl, [edi+eax]
        cmp bl, [ebp+12] ; Compare with search character
        jne next_char
        add byte [ebp-4], 1
next_char:
        mov bl, [edi+eax]
        cmp bl, 0   ; First check for null-terminator
        je  check_limits
        inc eax
        jmp char_loop

check_limits:
        mov bl, [ebp-4]
        cmp bl, [ebp+16]
        jl  too_few_chars
        cmp bl, [ebp+20]
        jg  too_many_chars
        mov eax, 1
        jmp done
too_many_chars:
too_few_chars:
        mov eax, 0
done:
        ; Subroutine Epilogue 
        pop ebx      ; Recover register values
        pop edi
        mov esp, ebp ; Deallocate local variables
        pop ebp ; Restore the caller's base pointer value
        ret
