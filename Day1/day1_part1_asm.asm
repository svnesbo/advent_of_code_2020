; file: day1_part1_asm.asm
; Searches for two values whose sum is 2020 in list of 32-bit unsigned integers,
; and returns the product of the two values.

segment .text
        global  day1_part1_asm

; Parameters:
; #1 (EBP+8): Pointer to data
; #2: (EBP+12): Number of elements
;
; Local variables:
; #1 (EBP-4): Outer loop counter
;
; Return value: Product of the first three elements in the data that add up to 2020. Zero is returned if not found.
day1_part1_asm:
        push ebp     ; Save the old base pointer value.
        mov ebp, esp ; Set the new base pointer value.
        sub esp, 4   ; Make room for one 4-byte local variable.
        push edi     ; Save the values of registers that the function
        push esi     ; will modify. This function uses EDI and ESI.

        ; Subroutine Body
        mov esi, [ebp+8]        ; Set ESI to base address of data
        mov dword [ebp-4], 0    ; Initialize outer loop counter
outer_loop:
        mov edi, [ebp+8]        ; Set EDI to base address of data
        mov ecx, 0              ; Reset ECX, used as inner loop counter
inner_loop:
        cmp esi, edi            ; Don't compare elements of same idnex
        je  inner_loop_next
        mov eax, [esi]
        add eax, [edi]
        cmp dword eax, 2020
        je  match_found
inner_loop_next:
        add edi, 4
        inc ecx
        cmp ecx, [ebp+12]       ; Compare inner loop counter with num elements
        jne inner_loop
outer_loop_next:
        add esi, 4
        add dword [ebp-4],1     ; Increase outer loop counter
        mov eax, [ebp-4]
        cmp eax, [ebp+12]       ; Compare outer loop counter with num elements
        je  match_not_found     ; Searched all elements, no match
        jmp outer_loop

match_found:
        mov eax, [esi]
        mul dword [edi]
        jmp done
match_not_found:
        mov eax, 0
done:
        ; Subroutine Epilogue 
        pop esi      ; Recover register values
        pop  edi
        mov esp, ebp ; Deallocate local variables
        pop ebp ; Restore the caller's base pointer value
        ret
