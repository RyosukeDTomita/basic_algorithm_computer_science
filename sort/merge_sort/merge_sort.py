# coding: utf-8
"""
マージソートは2つのソート済みの配列を結合することでソート済みの配列を作る。
そのため，まず配列をサイズ 1 まで小さくしてそれを結合する過程でマージする操作を繰り返す。
"""
import random
from typing import List


def merge_sort(array: List[int]) -> List[int]:
    """
    配列を半分ずつに分割していき，再帰によってサイズが1になるまでリストのサイズを分割し，_merge_arraysを呼び出す。
    """
    # リストを完全に1つずつに分割されていたら、終了
    if len(array) <= 1:
        return array

    mid_idx = len(array) // 2  # //は切り捨て除算
    left = array[:mid_idx]
    right = array[mid_idx:]
    print(f"CALL: _merge_arrays(merge_sort({left}), merge_sort({right}))")
    return _merge_arrays(merge_sort(left), merge_sort(right))


def _merge_arrays(left: List[int], right=[]) -> List[int]:
    """
    INFO: 引数のリストが1つでも動作するように右側のリストのデフォルト値をからの配列とする。
    2周目以降はleft,rightはソート済みである必要がある。
    """
    sorted_array = []
    i, j = 0, 0

    print(f"START MERGE: left: {left}, right: {right}")

    # left,rightを先頭から比較していき，小さい順にsorted_arrayに格納していく。どちらかの配列が空になったら単純につなげる。
    # while i < len(left) and j < len(right):
    # 直感的でないのでwhile文を書き換え
    while (len(left) - i != 0) and (len(right) - j != 0):
        if left[i] < right[j]:
            sorted_array.append(left[i])
            i += 1
        else:
            sorted_array.append(right[j])
            j += 1
    print(f"MERGE DONE: sorted_array: {sorted_array} + left: {left[i:]} + right: {right[j:]}, RETURN = {sorted_array + left[i:] + right[j:]}")
    return sorted_array + left[i:] + right[j:]  # +で配列を結合できる。


def main():
    random.seed(3)
    random_array = [random.randint(0, 100) for _ in range(15)]
    print(random_array)
    print("-----MERGE SORT-----")
    print(merge_sort(random_array))


if __name__ == '__main__':
    main()
