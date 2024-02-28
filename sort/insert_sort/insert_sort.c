#include <stdio.h>
#include <stdlib.h>
#define ARRAY_SIZE 20

int* insert_sort(int array[], int array_size);
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
 * insert sort
 */
int* insert_sort(int* array, int array_size) {
  for (int i = 1; i < ARRAY_SIZE; i++) {
    int tmp = array[i];
    int j = i;
    while (j > 0 && array[j - 1] > tmp) {
      array[j] = array[j - 1];
      j--;
    }
    array[j] = tmp;
  }
  return array;
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

  printf("-----insert, sort-----\n");

  int* sorted_array = insert_sort(random_array, ARRAY_SIZE);
  print_array(sorted_array, ARRAY_SIZE);

  // メモリを開放する。
  free(random_array);
  return 0;
}
