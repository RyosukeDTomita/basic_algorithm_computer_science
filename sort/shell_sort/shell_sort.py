# coding: utf-8
import random


def shell_sort(array):
    """
    hを3n+1としてループを回す毎にhを3で割る(切り捨て)しつつ，挿入ソートと同様に2つの値を比較して並べることを繰り返す。
    """
    len_array = len(array)
    h = 1

    # h-sortの間隔hを決定
    while h < len_array / 9:
        h = h * 3 + 1  # 4

    while h > 0:
        for i in range(h, len_array):
            j = i
            while j >= h and array[j - h] > array[j]:
                array[j], array[j - h] = array[j - h], array[j]
                j -= h
        h = int(h / 3)  # FIXME
    return array


def main():
    random.seed(3)  # randomシードを指定
    random_array = [random.randint(0, 99) for _ in range(20)]
    print(random_array)
    print("-----SHELL SORT-----")
    print(shell_sort(random_array))


if __name__ == "__main__":
    main()
