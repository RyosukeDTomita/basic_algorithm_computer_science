# coding: utf-8
"""
挿入ソート
"""
import random
from typing import List


def insert_sort(array: List[int]) -> List[int]:
    """_summary_

    Args:
        array List[int]

    Returns: List[int]
    """
    # 左から挿入する値の候補にする。
    # ループが1から始まっているのに注意。
    for i in range(1, len(array)):
        tmp = array[i]
        j = i

        # 取り出したtmpと取り出した位置よりひとつ左隣のarray[j-1]の値を比較し，tmpが小さければ入れ替える操作を繰り返す。
        while (j > 0) and (array[j - 1] > tmp):
            array[j] = array[j - 1]
            j = j - 1
        array[j] = tmp
    return array


def main():
    random.seed(3)  # randomシードを指定
    random_array = [random.randint(0, 99) for _ in range(20)]
    print(insert_sort(random_array))


if __name__ == "__main__":
    main()
