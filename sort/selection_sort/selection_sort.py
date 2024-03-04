# coding: utf-8
"""
選択ソート: 未整列のデータから最小値を探し、整列済みの最後尾に加えていくことでソートしていく。

"""
import random
from typing import List


def selection_sort(array: List[int]) -> List[int]:
    """_summary_

    Args:
        array List[int]

    Returns: List[int]
    """
    for i in range(len(array)):
        # 配列のi番目から最後までの間で一番小さい数を探す。
        min_idx = i
        for j in range(i, len(array)):
            if array[j] < array[min_idx]:
                min_idx = j
        array[i], array[min_idx] = array[min_idx], array[i]  # 最小値を左に置く。
    return array


def main():
    random.seed(3)  # randomシードを指定
    random_array = [random.randint(0, 99) for i in range(20)]
    print(random_array)
    print("-----SELECTION SORT-----")
    print(selection_sort(random_array))


if __name__ == "__main__":
    main()
