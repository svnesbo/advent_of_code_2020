; file: day2_part2_asm.asm
; Verify that string contains search character at one of the
; positions, but not both

segment .text
        global  day2_part2_asm

; Parameters:
; #1: (EBP+8): String pointer
; #2: (EBP+12): Search character
; #3: (EBP+16): First position (not zero-indexed)
; #4: (EBP+20): Second position (not zero-indexed)
;
; Note: params are always in multiples of 4 bytes
;
; Local variables:
; #1 (EBP-4): Counts of search character (1 byte) at position 1 and 2
;
; Return value: 1 if passwd is valid, 0 is password is invalid
day2_part2_asm:
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
        mov ebx, [ebp+16]       ; Check first position
        dec ebx                 ; Make position zero-indexed
        cmp eax, ebx
        je check_for_char_match

        mov ebx, [ebp+20]       ; Check second position
        dec ebx
        cmp eax, ebx
        je check_for_char_match
        ; Fall through if not at 1st or 2nd position
next_char:
        mov bl, [edi+eax]
        cmp bl, 0               ; First check for null-terminator
        je  check_results
        inc eax
        jmp char_loop

check_for_char_match:
        mov bl, [edi+eax]
        cmp bl, [ebp+12]        ; Compare with search character
        jne next_char
        add byte [ebp-4], 1     ; Increase count of search char at right position
        jmp next_char

check_results:
        mov bl, [ebp-4]
        cmp bl, 1               ; Expecting to find search char at _one_ of the positions
        jne not_valid
        mov eax, 1
        jmp done
not_valid:
        mov eax, 0
done:
        ; Subroutine Epilogue 
        pop ebx      ; Recover register values
        pop edi
        mov esp, ebp ; Deallocate local variables
        pop ebp ; Restore the caller's base pointer value
        ret



        