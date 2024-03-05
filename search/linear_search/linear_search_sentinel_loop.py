import random
import timeit
from typing import List


def linear_search(array: List[int], target: int) -> int:
    """
    通常の線形探索
    比較のためwhileを使って実装
    targetが存在するならそのインデックスを返す。
    """
    array_size = len(array)
    i = 0

    while array[i] != target:
        i += 1

        if (i == array_size):
            return -999  # 存在しない場合は-999を返す。
    return i


def linear_search_sentinel_loop(array: List[int], target: int) -> int:
    """
    線形探索(番兵)
    配列にターゲットを追加することで確実に配列がターゲットが見つかることを保証できる。
    """
    i = 0
    array.append(target)  # 番兵を追加
    array_size = len(array) - 1  # 番兵の分減らす。

    while array[i] != target:
        i += 1

    if i == array_size:  # whileの終了が番兵によって保証されていることでwhileの終了条件である i == array_sizeをwhile内で判定しなくてよい。
        return -999  # 番兵が見つかった場合は-999を返す。

    return i


# timeitからrandom_arrayを呼び出すためにはglobal宣言されている必用がある。
random.seed(3)
random_array = [random.randint(0, 100) for i in range(300)]


def main():
    time_1 = timeit.timeit('linear_search(random_array, 32)',
                           globals=globals(), number=2)
    time_2 = timeit.timeit('linear_search_sentinel_loop(random_array, 32)',
                           globals=globals(), number=2)

    print(time_1)
    print(time_2)


if __name__ == '__main__':
    main()
