# coding: utf-8
"""
線形探索
先頭から対象の値を探す。
計算量はO(n)
"""
import random


def linear_search(array, target):
    """
    線形探索
    """
    for v in array:
        if target == v:
            return True
    return False


def main():
    random.seed(3)  # randomシードを指定
    random_array = [random.randint(0, 99) for _ in range(20)]
    print(random_array)
    print("-----LINEAR SEARCH-----")
    print(linear_search(random_array, 77))  # 存在する数
    print(linear_search(random_array, 2))  # 存在しない数


if __name__ == '__main__':
    main()
