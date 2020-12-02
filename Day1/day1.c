#include "../cdecl.h"
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

uint32_t PRE_CDECL day1_part1_asm(uint32_t* p_data, uint32_t num) POST_CDECL;
uint32_t PRE_CDECL day1_part2_asm(uint32_t* p_data, uint32_t num) POST_CDECL;

int main()
{
    FILE *fp = fopen("day1_input.txt", "r");

    if (fp == NULL) {
        printf("Could not open input file.\n");
        exit(-1);
    }
    
    uint32_t num_lines = 0;

    while (!feof(fp)) {
        char ch = fgetc(fp);
        if (ch == '\n') {
            num_lines++;
        }
    }

    uint32_t* p_numbers = malloc(sizeof(uint32_t) * num_lines);

    if (p_numbers == NULL) {
        printf("Error allocating mem.\n");
        exit(-1);
    }

    fseek(fp, SEEK_SET, 0); // Rewind file

    for (unsigned int line = 0; line < num_lines; line++) {
        fscanf(fp, "%u", &p_numbers[line]);
    }

    uint32_t answer1 = day1_part1_asm(p_numbers, num_lines);
    uint32_t answer2 = day1_part2_asm(p_numbers, num_lines);

    printf("answer1 = %u, answer2 = %u\n", answer1, answer2);

    return 0;
}
