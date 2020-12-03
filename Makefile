AS		  := nasm
ASFLAGS := -f elf32
CFLAGS	:= -m32
LDFLAGS := -m32
CC		:= gcc
TARGETS := day1 day2

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS) 

day1: Day1/day1_part1_asm.o Day1/day1_part2_asm.o
	$(CC) $(CFLAGS)  Day1/day1.c Day1/day1_part1_asm.o Day1/day1_part2_asm.o -o Day1/day1

day2: Day2/day2_part1_asm.o Day2/day2_part2_asm.o
	$(CC) $(CFLAGS)  Day2/day2.c Day2/day2_part1_asm.o Day2/day2_part2_asm.o -o Day2/day2

clean :
	rm -f Day1/*.o Day2/*.o

