; file: day3_asm.asm
; Find number of "trees" (# character) when moving through map
; of num_columns x num_rows in steps defined by col_jump_len
; and row_jump_len

segment .text
        global  day3_asm

; Parameters:
%define p_tree_map      [ebp+8]
%define num_columns     [ebp+12]
%define num_rows        [ebp+16]
%define col_jump_len    [ebp+20]
%define row_jump_len    [ebp+24]

; Local variables:
%define num_trees_hit   [ebp-4]
%define current_row     [ebp-8]
%define current_col     [ebp-12]

; Return value: Number of trees hit
day3_asm:
        push ebp     ; Save the old base pointer value.
        mov ebp, esp ; Set the new base pointer value.
        sub esp, 12   ; Make room for three 4-byte local variables.
        push ebx
        push ecx
        push edx

        mov dword num_trees_hit, 0
        mov dword current_row, 0
        mov dword current_col, 0

tree_map_loop:
        call update_position
        call collision_check
        add num_trees_hit, eax
        mov eax, current_row
        cmp eax, num_rows
        jl  tree_map_loop
done:
        mov eax, num_trees_hit

        ; Subroutine Epilogue 
        pop edx      ; Recover register values
        pop ecx
        pop ebx
        mov esp, ebp ; Deallocate local variables
        pop ebp ; Restore the caller's base pointer value
        ret

; Update row and column position
; Messes up EAX
update_position:
        mov eax, current_row
        add eax, row_jump_len
        mov current_row, eax
        mov eax, current_col
        add eax, col_jump_len
        cmp eax, num_columns
        jl  update_position_return
wrap_around_position:
        sub eax, num_columns
update_position_return:
        mov current_col, eax
        ret

; Check if there is a collision at current position
; Messes up EAX, EBX, ECX, EDX
; Return: EAX=1 on collision, EAX=0 if no collision
collision_check:
        ; Find position in p_tree_map
        mov eax, current_row
        mul dword num_columns
        add eax, current_col
        add eax, p_tree_map

        mov dl, '#'
        cmp dl, [eax]
        jne no_collision
        mov eax, 1
        ret
no_collision:
        mov eax, 0
        ret
