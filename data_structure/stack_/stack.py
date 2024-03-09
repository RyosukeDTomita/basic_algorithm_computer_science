# coding: utf-8
"""
LIFOでデータを格納するスタック
"""
from typing import Union


def push(data: int):
    """
    データを配列の先頭から順に格納し，`stack_pointer`をインクリメントする。
    """
    global stack_pointer
    if stack_pointer < stack_size:
        stack[stack_pointer] = data
        stack_pointer += 1
    else:
        print(f"data size exceed stack_size:{stack_size}.")


def pop() -> Union[int, None]:
    """
    Last Outでデータを取り出す。
    最後に入れたデータのインデックスは`stack_pointer`になる
    """
    global stack_pointer
    if stack_pointer > 0:
        # 配列のindexは0から始まるので先にstack_pointerをディクリメントしている。
        stack_pointer -= 1
        return stack[stack_pointer]
    else:
        print("Can not find data in stack")
        return None


# globalで宣言
stack_size = 5
stack = [0] * stack_size  # 0が格納された配列を宣言
stack_pointer = 0


def main():
    for i in range(6):
        print(f"push data = {i}")
        push(i)
    for _ in range(6):
        data = pop()
        print(f"pop data = {data}")


if __name__ == "__main__":
    main()
