# coding: utf-8
"""
quicksort
pivotと呼ばれる基準を適当に選び、pivotより小さいなら左、大きいなら右に要素を移動する。これを繰り返す。
"""
import random
from typing import List


def quick_sort(array: List[int]) -> List[int]:
    # 配列が空の場合は再帰しない。
    if array == []:
        return array

    # pivotをランダムで選ぶようにする。
    p = random.choice(array)
    left = []
    right = []
    pivots = []

    for v in array:
        if v < p:
            left.append(v)
        elif v == p:
            pivots.append(v)
        else:
            right.append(v)
    return quick_sort(left) + pivots + quick_sort(right)


def main():
    random_array = [random.randint(0, 100) for _ in range(15)]
    print(random_array)
    print("-----QUICK SORT-----")
    print(quick_sort(random_array))


if __name__ == "__main__":
    main()
