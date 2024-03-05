#include <stdio.h>
#include <stdlib.h>
#define ARRAY_SIZE 20

int binary_search(int* array, int array_size, int target);
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
 * binary search
 */
int binary_search(int* array, int array_size, int target) {
  int left_idx = 0;
  int right_idx = array_size - 1;
  int mid_idx;
  while (left_idx < right_idx) {
    mid_idx = (left_idx + right_idx) / 2;  // 切り捨て
    if (target < array[mid_idx]) {
      right_idx = mid_idx;
    } else if (target == array[mid_idx]) {
      return 1;
    } else {
      left_idx = mid_idx + 1;
    }
  }
  return (array[mid_idx] == target);
}

/**
 * qsortにつかうcomparator
 */
int compare(const void* a, const void* b) { return (*(int*)a - *(int*)b); }

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

  printf("%s\n", "-----LINEAR SEARCH-----");
  // 事前にソートが必用
  qsort(random_array, ARRAY_SIZE, sizeof(int), compare);
  print_array(random_array, ARRAY_SIZE);

  // 配列に存在する数でテスト
  int target = 1;
  int result = binary_search(random_array, ARRAY_SIZE, target);
  printf("%d is %d\n", target, result);

  // 配列に存在しない数でテスト
  target = 3;
  result = binary_search(random_array, ARRAY_SIZE, target);
  printf("%d is %d\n", target, result);

  // メモリを開放する。
  free(random_array);
  return 0;
}
