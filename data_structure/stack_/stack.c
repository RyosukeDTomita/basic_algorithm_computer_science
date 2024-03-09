#include <stdio.h>
#define STACK_SIZE 5
int my_stack[5];
int stack_pointer = 0;
void push(int data);
int pop(void);

/**
 *
 */
void push(int data) {
  if (stack_pointer < STACK_SIZE) {
    my_stack[stack_pointer] = data;
    stack_pointer++;
    printf("push data = %d\n", data);
  } else {
    printf("data size exceed stack_size: %d\n", data);
  }
}

int pop() {
  if (stack_pointer > 0) {
    stack_pointer--;
    return my_stack[stack_pointer];
  } else {
    printf("can not find data in stack.\n");
  }
  return -999;
}

int main(void) {
  for (int i = 0; i < 6; i++) {
    push(i);
  }
  for (int i = 0; i < 6; i++) {
    int data = pop();
    printf("pop data = %d\n", data);
  }
  return 0;
}
