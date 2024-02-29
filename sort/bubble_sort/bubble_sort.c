#include <stdio.h>
#include <stdlib.h>
#define ARRAY_SIZE 20

void bubble_sort(int array[], int array_size);
int* create_random_array(void);
void print_array(int* array, int array_size);

/**
 * サイズ20のランダムな配列を作成
 */
int* create_random_array(void) {
  // 長期的に使えるメモリ領域ヒープを確保
  int* array = (int*)malloc(ARRAY_SIZE * sizeof(int));

  srand(3);  // 乱数シード
  for (int i = 0; i < ARRAY_SIZE; i++) {
    // 長い乱数は見にくいので0~99の範囲で乱数を発生させる。
    array[i] = rand() % 100;
  };
  return array;
}

/**
 * bubble sort
 */
void bubble_sort(int* array, int array_size) {
  for (int i = 0; i < array_size; i++) {
    for (int j = 0; j < array_size - i - 1; j++) {
      if (array[j] > array[j + 1]) {
        int tmp = array[j + 1];
        array[j + 1] = array[j];
        array[j] = tmp;
      }
    }
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
  // ポインタ変数として作成された配列の先頭の値が格納されたメモリの位置を受け取る。
  int* random_array = create_random_array();
  print_array(random_array, ARRAY_SIZE);

  printf("-----bubble, sort-----\n");

  bubble_sort(random_array, ARRAY_SIZE);
  print_array(random_array, ARRAY_SIZE);

  // メモリを開放する。
  free(random_array);
  return 0;
}
