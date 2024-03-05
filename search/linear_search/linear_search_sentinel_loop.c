#include <stdio.h>
#include <stdlib.h>
#define ARRAY_SIZE 20

int linear_search(int array[], int array_size, int target);
int linear_search_sentinel_loop(int array[], int array_size, int target);
int* create_random_array(void);
void print_array(int* array, int array_size);
void check_result(int result);

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
 * linear search
 * 比較用
 */
int linear_search(int* array, int array_size, int target) {
  int i = 0;
  while (array[i] != target) {
    i++;
    if (i == array_size) {
      return 1;
    }
  }
  return 0;
}

/**
 * linear search with sentinel loop
 * 配列にターゲットを追加することで確実に配列がターゲットが見つかることを保証できる。
 */
int linear_search_sentinel_loop(int* array, int array_size, int target) {
  int i = 0;
  array[array_size] = target;  // 番兵を追加
  while (array[i] != target) {
    i++;
  }
  if (i == array_size) {
    return 1;
  } else {
    return 0;
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

void check_result(int result) {
  if (result == 0) {
    printf("%s\n", "True");
  } else {
    printf("%s\n", "False");
  }
}

int main(void) {
  // ポインタ変数として作成された配列の先頭の値が格納されたメモリの位置を受け取る。
  int* random_array = create_random_array();
  print_array(random_array, ARRAY_SIZE);

  printf("%s\n", "-----LINEAR SEARCH-----");

  // TODO: 実行時間を計測する機能の実装。
  int result = linear_search(random_array, ARRAY_SIZE, 1);
  check_result(result);
  result = linear_search_sentinel_loop(random_array, ARRAY_SIZE, 1);
  check_result(result);

  // メモリを開放する。
  free(random_array);
  return 0;
}
