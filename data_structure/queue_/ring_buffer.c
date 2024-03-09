#include <stdio.h>
#define QUE_SIZE 5
int my_que[5] = {-99, -99, -99, -99, -99};
int enqueue_idx = 0;
int dequeue_idx = 0;
void enqueue(int data);
int dequeue(void);

/**
 * FIFOでデータを追加する。
 */
void enqueue(int data) {
  // リングバッファが一周していないかチェック。
  int next_idx = (enqueue_idx + 1) % QUE_SIZE;
  if (next_idx == dequeue_idx) {
    printf("data size exceed que_size: %d\n", data);
  } else {
    my_que[enqueue_idx] = data;
    enqueue_idx = next_idx;
    printf("enqueue data = %d\n", data);
  }
}

/**
 * FIFOでデータを取り出す。
 */
int dequeue() {
  if (enqueue_idx == dequeue_idx) {
    printf("que is empty\n");
    return -99;
  } else {
    int data = my_que[dequeue_idx];
    my_que[dequeue_idx] = -99;
    dequeue_idx = (dequeue_idx + 1) % QUE_SIZE;
    return data;
  }
}

/**
 * 1次元配列をprintする
 */
void print_array(int* array, int array_size) {
  // 配列のサイズは配列全体のバイト数 / 要素一つのバイト数で求められる。
  for (int i = 0; i < array_size; i++) {
    printf("%d, ", array[i]);
  }
  printf("\n");
}

int main(void) {
  for (int i = 1; i < 7; i++) {
    enqueue(i);
    print_array(my_que, QUE_SIZE);
  }
  for (int i = 0; i < 6; i++) {
    int data = dequeue();
    printf("dequeue data = %d\n", data);
    print_array(my_que, QUE_SIZE);
  }
  return 0;
}
