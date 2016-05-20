// Filename: memory_demo.c
// Author: Matthew Spencer
// Description: Prints the memory location of strings on the stack and heap.

#include <stdio.h>

main()
{
	int size = 32;
	char stack1[size];
	//char stack2[size];
	//char stack3[size];

	char *heap1;
	//char *heap2;
	//char *heap3;
	heap1 = malloc(size);
	//heap2 = malloc(size);
	//heap3 = malloc(size);

	//printf("Size of string: %d bytes \n", size);
	printf("Location on stack: %p \n", stack1);
	//printf("Location on stack: %p  Offset: %d \n", stack2, stack2 - stack1);
	//printf("Location on stack: %p  Offset: %d \n", stack3, stack3 - stack2);

	
	printf("Location on heap: %p \n", heap1);
	//printf("Location on heap: %p   Offset: %d \n", heap2, heap2 - heap1);
	//printf("Location on heap: %p   Offset: %d \n", heap3, heap3 - heap2);
	
	return 0;
}
