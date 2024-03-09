# coding: utf-8
"""
リングバッファ(FIFO)
"""
from typing import Union


def enqueue(data: int) -> None:
    """
    FIFOでデータを格納する。
    配列の最後にはデータを格納しない。
    % que_sizeすることで配列のサイズを超えた時にリングバッファが一周するようにしている。
    """
    global enqueue_idx  # グローバル変数を関数内で変更するために宣言

    # リングバッファが一周しているなら終了する。配列の最後にはデータを格納しないため，enqueue_idxに+1した値で判定している。
    next_idx = (enqueue_idx + 1) % que_size
    if next_idx == dequeue_idx:
        print(f"queue max size = {que_size}. cannot add data.")
    else:
        que[enqueue_idx] = data
        enqueue_idx = next_idx  # 次回のenqueue位置を更新
        print(f"enqueue data = {data}")


def dequeue() -> Union[int, None]:
    """
    FIFOでデータを取り出す。
    """
    global dequeue_idx  # グローバル変数を関数内で変更するために宣言
    if (dequeue_idx == enqueue_idx):
        print("que is empty.")
        return None
    else:
        data = que[dequeue_idx]
        que[dequeue_idx] = -99  # 取り出したデータの部分を初期化
        dequeue_idx = (dequeue_idx + 1) % que_size
        return data


# global変数
que_size = 5
que = [-99] * que_size
enqueue_idx = 0  # データを入れる位置を管理する
dequeue_idx = 0  # データを取り出す位置を管理する


def main():
    for i in range(1, 6):
        enqueue(i)
        print(que)
    for i in range(5):
        data = dequeue()
        print(f"dequeue data = {data}")
        print(que)


if __name__ == "__main__":
    main()
