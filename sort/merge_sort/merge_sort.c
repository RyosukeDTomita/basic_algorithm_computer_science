#include <stdio.h>
#include <stdlib.h>
#define ARRAY_SIZE 20

void merge_sort(int array[], int left_size, int right_size);
void _merge(int array[], int left, int left_size, int right_size);
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
 * merge sort(array, 0,
 * 5)からのmerge_sortの再起呼び出しイメージ(文字数の関係上，arrayをAに省略)
 *                     merge_sort(A, 0, 1)
 * merge_sort(A, 0, 2)/
 *                    \
 *                     merge_sort(A, 1, 2)
 *
 *                     merge_sort(A, 2, 3)
 * merge_sort(A, 2, 5)/
 *                    \                        merge_sort(A, 3, 4)
 *                     merge_sort(array, 3, 5)/
 *                                            \
 *                                             merge_sort(A, 4, 5)
 */
void merge_sort(int array[], int left_idx, int right_idx) {
  // 配列のサイズが1になるまで繰り返す。
  if ((left_idx + 1) < right_idx) {
    int mid_idx = (left_idx + right_idx) / 2;  // 切り捨て
    merge_sort(array, left_idx, mid_idx);
    merge_sort(array, mid_idx, right_idx);
    _merge(array, left_idx, mid_idx, right_idx);
  }
}

/**
 * 分割した配列をマージする過程でソートする。
 */
void _merge(int array[], int left_idx, int mid_idx, int right_idx) {
  int nl = mid_idx - left_idx;   // 左側の配列のサイズ
  int nr = right_idx - mid_idx;  // 右側の配列のサイズ
  int left[nl], right[nr];

  // 左側の配列
  for (int i = 0; i < nl; i++) {
    left[i] = array[left_idx + i];
  }
  // 右側の配列
  for (int i = 0; i < nr; i++) {
    right[i] = array[mid_idx + i];
  }

  int i = 0, j = 0;
  int k = left_idx;
  // 左右どちらかの配列が空になるまで2つの配列の最小値を基の配列に代入する。
  // INFO: array[k++] =
  // left[i++]のような書き方を後置インクリメントといい，array[k]にleft[i]が代入後にインクリメントが実行される。
  while ((i < nl) && (j < nr)) {
    if (left[i] <= right[j]) {
      array[k++] = left[i++];
    } else {
      array[k++] = right[j++];
    }
  }

  // 空にならなかった方の配列を元の配列に連結。
  if (i < nl) {
    array[k++] = left[i++];
  } else {
    array[k++] = right[j++];
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

  printf("%s\n", "-----MERGE SORT-----");

  merge_sort(random_array, 0, ARRAY_SIZE);
  print_array(random_array, ARRAY_SIZE);

  // メモリを開放する。
  free(random_array);
  return 0;
}
