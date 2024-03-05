# coding: utf-8
"""
線形探索
先頭から対象の値を探す。
計算量はO(n)
"""
import random
from typing import List


def linear_search(array: List[int], target: int) -> int:
    """
    線形探索
    """
    for i in range(len(array)):
        if target == array[i]:
            return i
    return -999  # 存在しない場合は-999を返す。


def main():
    random.seed(3)  # randomシードを指定
    random_array = [random.randint(0, 99) for _ in range(20)]
    print(random_array)
    print("-----LINEAR SEARCH-----")
    # 存在する数
    target = 77
    print(f"{target} index is {linear_search(random_array, 77)}")
    # 存在しない数
    target = 2
    print(f"{target} index is {linear_search(random_array, 2)}")


if __name__ == '__main__':
    main()
