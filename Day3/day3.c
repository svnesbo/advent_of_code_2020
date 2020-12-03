#include "../cdecl.h"
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define STR_BUFF_SIZE 100

uint32_t PRE_CDECL day3_asm(uint8_t *p_tree_map, uint32_t num_cols, uint32_t num_rows, uint32_t col_jump_len, uint32_t row_jump_len) POST_CDECL;

void strip_newlines(char* str, size_t len)
{
    char *p_char = strchr(str, '\r');
    if (p_char != NULL && p_char < (str+len) ) {
        *p_char = 0;
    }

    p_char = strchr(str, '\n');
    if (p_char != NULL && p_char < (str+len)) {
        *p_char = 0;
    }
}


int main()
{
    FILE *fp = fopen("day3_input.txt", "r");

    if (fp == NULL) {
        printf("Could not open input file.\n");
        exit(-1);
    }
    
    char test_line[STR_BUFF_SIZE];
    fgets(test_line, STR_BUFF_SIZE, fp);
    uint32_t line_length = strlen(test_line);
    strip_newlines(test_line, STR_BUFF_SIZE);
    uint32_t num_cols = strlen(test_line);

    fseek(fp, 0, SEEK_END);
    uint32_t num_rows = ftell(fp) / (line_length);

    uint8_t *tree_map = malloc(sizeof(uint8_t) * num_rows * num_cols);

    if (tree_map == NULL) {
        printf("Error allocating mem for tree map.\n");
        exit(-1);
    }

    fseek(fp, 0, SEEK_SET); // Rewind file
    unsigned int row_counter = 0;

    while (!feof(fp) && row_counter < num_rows) {
        fgets(test_line, STR_BUFF_SIZE, fp);
        strip_newlines(test_line, STR_BUFF_SIZE);
        if (strlen(test_line) != num_cols) {
            printf("Unexpected number of columns on line %d. Expected %d, got %d.\n", 
                   num_rows, num_cols, strlen(test_line));
            exit(-1);
        }
        memcpy((void *) &tree_map[num_cols*row_counter], (void *) test_line, num_cols);
        row_counter++;
    }

    printf("Number of trees hit - Right 1, down 1: %d\n", day3_asm(tree_map, num_cols, num_rows, 1, 1));
    printf("Number of trees hit - Right 3, down 1: %d\n", day3_asm(tree_map, num_cols, num_rows, 3, 1));
    printf("Number of trees hit - Right 5, down 1: %d\n", day3_asm(tree_map, num_cols, num_rows, 5, 1));
    printf("Number of trees hit - Right 7, down 1: %d\n", day3_asm(tree_map, num_cols, num_rows, 7, 1));
    printf("Number of trees hit - Right 1, down 2: %d\n", day3_asm(tree_map, num_cols, num_rows, 1, 2));

    printf("Product of num trees hit: %lu\n", (unsigned long) day3_asm(tree_map, num_cols, num_rows, 1, 1) 
                                             * (unsigned long) day3_asm(tree_map, num_cols, num_rows, 3, 1)
                                             * (unsigned long) day3_asm(tree_map, num_cols, num_rows, 5, 1)
                                             * (unsigned long) day3_asm(tree_map, num_cols, num_rows, 7, 1)
                                             * (unsigned long) day3_asm(tree_map, num_cols, num_rows, 1, 2));

    return 0;
}
