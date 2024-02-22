# coding: utf-8
"""
バブルソート
左右のデータを比較して小さい方を右に配置する。
"""
import random


def bubble_sort(array: list) -> list:
    """
    左端から2つずつデータを比較して小さいほうが配列の左にくるように入れ替えていく。
    """
    for i in range(len(array)):
        # jはi回目のループで配列の右隣との比較が終わっていないarrayのindex
        for j in range(0, (len(array) - i - 1)):
            if array[j] > array[j + 1]:
                array[j], array[j + 1] = array[j + 1], array[j]
    return array


def main():
    random.seed(3)  # randomシードを指定
    random_array = [random.randint(0, 99) for _ in range(20)]
    print(random_array)
    print("-----bubble sort-----")
    print(bubble_sort(random_array))


if __name__ == "__main__":
    main()
