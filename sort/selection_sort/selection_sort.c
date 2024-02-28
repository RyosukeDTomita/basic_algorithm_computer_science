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
 * selection sort
 */
int* selection_sort(int* array, int array_size) {
  for (int i = 0; i < ARRAY_SIZE; i++) {
    int min_idx = i;  // 仮の最小値が格納されたindex

    // 配列のi番目より右側の最小値を求める
    for (int j = i; j < ARRAY_SIZE; j++) {
      if (array[j] < array[min_idx]) {
        int tmp = array[j];
        array[j] = array[min_idx];
        array[min_idx] = tmp;
      }
    }
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

  printf("-----selection, sort-----\n");

  int* sorted_array = selection_sort(random_array, ARRAY_SIZE);
  print_array(sorted_array, ARRAY_SIZE);

  // メモリを開放する。
  free(random_array);
  return 0;
}
