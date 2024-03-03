#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define ARRAY_SIZE 20

void quick_sort(int array[], int left_idx, int right_idx);
int* create_random_array(void);
void print_array(int* array, int array_size);
void swap(int* val1, int* val2);

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
 * quick_sort
 * separator_idxはpivotよりも大きい値が出てきた時にはインクリメントされないため，
 * 次にpivotよりも小さい値が出てきた時にseparator_idxとiを入れ替えることで，separator_idxよりも小さい値を左に，大きい値を右に分けることができる。
 * その後，pivotを本来あるべき位置に移動させることで，pivotよりも小さい値と大きい値に分けることができる。
 * INFO: この方法で移動させたpivotの位置はソート完了時の正しい位置となる。
 */
void quick_sort(int* array, int left_idx, int right_idx) {
  // 配列のサイズが1以下の場合には何もしない。
  if (left_idx >= right_idx) {
    return;
  }

  // 配列のインデックスをランダムで決めてpivotを選ぶ。
  srand(time(NULL));
  int p_idx = rand() % (left_idx - right_idx) + left_idx;

  // pivotを左端に配置。
  swap(&array[p_idx], &array[left_idx]);
  p_idx = left_idx;
  int pivot = array[p_idx];

  // pivotより小さい値を左に，大きい値を右に分ける。
  int separator_idx = left_idx;  // pivotより小さい値と大きい値の境目のindex
  for (int i = (left_idx + 1); i <= right_idx; i++) {
    if (array[i] < pivot) {
      separator_idx++;
      if (i != separator_idx) {
        swap(&array[i], &array[separator_idx]);
      }
    }
  }
  // pivotを本来あるべき位置に移動。
  swap(&array[p_idx], &array[separator_idx]);

  quick_sort(array, left_idx, separator_idx - 1);  // pivotより小さい部分
  quick_sort(array, separator_idx + 1, right_idx);  // pivotより大きい部分
}

/**
 * 2つの値を入れ替える
 */
void swap(int* val1, int* val2) {
  int tmp = *val1;
  *val1 = *val2;
  *val2 = tmp;
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

  printf("%s\n", "-----QUICK, SORT-----");

  quick_sort(random_array, 0,
             (ARRAY_SIZE - 1));  // indexは0から始まるので-1する。
  print_array(random_array, ARRAY_SIZE);

  // メモリを開放する。
  free(random_array);
  return 0;
}
