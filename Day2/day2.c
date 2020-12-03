#include "../cdecl.h"
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

uint32_t PRE_CDECL day2_part1_asm(char* p_str, char search_char, uint8_t min, uint8_t max) POST_CDECL;
uint32_t PRE_CDECL day2_part2_asm(char* p_str, char search_char, uint8_t min, uint8_t max) POST_CDECL;

int main()
{
    FILE *fp = fopen("day2_input.txt", "r");

    if (fp == NULL) {
        printf("Could not open input file.\n");
        exit(-1);
    }
    
    uint32_t num_valid_strings_part1 = 0;
    uint32_t num_valid_strings_part2 = 0;

    while (!feof(fp)) {
        unsigned int min;
        unsigned int max;
        char search_char;
        char passwd[100];
        fscanf(fp, "%u-%u %c: %s\n", &min, &max, &search_char, passwd);

        num_valid_strings_part1 += day2_part1_asm(passwd, search_char, min, max);
        num_valid_strings_part2 += day2_part2_asm(passwd, search_char, min, max);
    }

    printf("Number of valid strings - part 1: %d\n", num_valid_strings_part1);
    printf("Number of valid strings - part 2: %d\n", num_valid_strings_part2);

    return 0;
}
