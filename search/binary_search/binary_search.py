# coding: utf-8
"""
探索するデータを半分に分けて，そのどちらに目的の値があるかを判断し，探索範囲を絞り込みながら値を探す方法。
配列が既にソートされている状態である必要がある。
pointer(mid)から見て右にあるか左にあるかを判定し、右の場合にはlo = mid+1(lo < midは自明のため),に左の場合はhi = midとして再試行する。
2分探索法では，探索範囲を半分にしていく --> 32個のデータであればlog2 32=5回探索すれば見つかりそう。
"""
import random
from typing import List


def binary_search(array: List[int], target: int) -> bool:  # aという配列からxを探す。loは左端
    # hiのデフォルト値は配列のサイズとしたいが引数でhi=len(array)とすることはできないので一旦Noneをデフォルト値にしている。
    left_idx = 0
    right_idx = len(array) - 1
    # ターゲットがピボットよりも小さい場合は配列の左側を探索，それ以外なら右側を探索する。
    while left_idx < right_idx:
        mid_idx = (left_idx + right_idx) // 2  # 切り捨て
        if target < array[mid_idx]:
            right_idx = mid_idx
        elif target == array[mid_idx]:
            return True
        else:
            left_idx = mid_idx + 1
    return (array[mid_idx] == target)


def main():
    random.seed(3)
    my_array = [random.randint(0, 99) for _ in range(20)]
    print(my_array)
    print("-----BINARY SEARCH-----")
    # 配列がソート済みである必用があるのでソートする。
    my_array.sort()
    # 存在する数
    target = 30
    print(f"{target} is {binary_search(my_array, target)}")
    # 存在しない数
    target = 2
    print(f"{target} is {binary_search(my_array, target)}")


if __name__ == '__main__':
    main()
