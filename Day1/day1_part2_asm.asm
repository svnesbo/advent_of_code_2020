; file: day1_part2_asm.asm
; Searches for three values whose sum is 2020 in list of 32-bit unsigned integers,
; and returns the product of the three values.

segment .text
        global  day1_part2_asm

; Parameters:
; #1 (EBP+8): Pointer to data
; #2: (EBP+12): Number of elements
;
; Local variables:
; #1 (EBP-4): Outer loop counter
; #2 (EBP-8): Inner loop counter
; #3 (EBP-12): Innermost loop counter
;
; Return value: Product of the first three elements in the data that add up to 2020. Zero is returned if not found.
day1_part2_asm:
        push ebp     ; Save the old base pointer value.
        mov ebp, esp ; Set the new base pointer value.
        sub esp, 12   ; Make room for three 4-byte local variable.
        
        ; Save the values of registers that the function
        ; will modify. This function uses EBX
        push ebx

        ; Subroutine Body
        ;mov esi, [ebp+8]        ; Set ESI to base address of data
        mov dword [ebp-4], 0    ; Initialize outer loop counter
outer_loop:
        ;mov edi, [ebp+8]        ; Set EDI to base address of data
        mov dword [ebp-8], 0    ; Initialize inner loop counter
inner_loop:
        mov eax, [ebp-4]
        cmp eax, [ebp-8]        ; Don't compare elements of same idnex
        je  inner_loop_next
        mov dword [ebp-12], 0   ; Initialize innermost loop counter
innermost_loop:
        mov eax, [ebp-4]
        cmp eax, [ebp-12]
        je  innermost_loop_next

        mov eax, [ebp-8]
        cmp eax, [ebp-12]
        je  innermost_loop_next

        ; Get element from outer loop
        mov eax, [ebp-4]        ; Element num
        shl eax, 2              ; Multiply by 4 - 4 bytes per element
        add eax, [ebp+8]        ; Add base address

        ; Get element from inner loop
        mov ebx, [ebp-8]
        shl ebx, 2
        add ebx, [ebp+8]

        ; Get element from innermost loop
        mov ecx, [ebp-12]
        shl ecx, 2
        add ecx, [ebp+8]
        
        mov eax, [eax]
        add eax, [ebx]
        add eax, [ecx]
        cmp dword eax, 2020
        je  match_found
innermost_loop_next:
        add dword [ebp-12], 1   ; Increase innermost loop
        mov eax, [ebp-12]
        cmp eax, [ebp+12]  ; Compare innermost loop counter with num elements
        jne innermost_loop
inner_loop_next:
        add dword [ebp-8], 1    ; Increase inner loop
        mov eax, [ebp-8]
        cmp eax, [ebp+12]   ; Compare inner loop counter with num elements
        jne inner_loop
outer_loop_next:
        add dword [ebp-4], 1    ; Increase outer loop
        mov eax, [ebp-4]
        cmp eax, [ebp+12]   ; Compare outer loop counter with num elements
        je  match_not_found     ; Searched all elements, no match
        jmp outer_loop

match_found:
        ; Get element from outer loop
        mov eax, [ebp-4]        ; Element num
        shl eax, 2              ; Multiply by 4 - 4 bytes per element
        add eax, [ebp+8]        ; Add base address

        ; Get element from inner loop
        mov ebx, [ebp-8]
        shl ebx, 2
        add ebx, [ebp+8]

        ; Get element from innermost loop
        mov ecx, [ebp-12]
        shl ecx, 2
        add ecx, [ebp+8]

        ; Multiply elements
        mov eax, [eax]
        mul dword [ebx]
        mul dword [ecx]
        jmp done
match_not_found:
        mov eax, 0
done:
        ; Subroutine Epilogue 
        pop ebx      ; Recover register values
        mov esp, ebp ; Deallocate local variables
        pop ebp      ; Restore the caller's base pointer value
        ret
