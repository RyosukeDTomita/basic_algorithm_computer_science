# coding: utf-8
"""
片方向リスト
"""
from typing import Union


def insert_list(data: int) -> bool:
    """
    データの最後尾に値を追加し，追加できた時にTrueを返す。
    """
    global data_list, pointer
    is_empty = False

    # データに空き領域があるか調べる。
    for i in range(LIST_SIZE):
        if data_list[i] is None:
            n = i  # 配列の先頭から最も近い空き領域のインデックス
            is_empty = True
            break
    if not is_empty:
        print("no empty space")
        return False

    # 配列にデータが入っており，pointerがNoneでない=最後尾に連結する。
    for i in range(LIST_SIZE):
        if (data_list[i] is not None) and (pointer[i] is None):
            pointer[i] = n
            break

    # データの追加
    data_list[n] = data
    pointer[n] = None  # データの最後尾なのでpointerはNone
    print(f"insert data: {data}.")
    return True


def delete_list(data: int) -> bool:
    """
    削除対象のdataを受け取り，削除できたらTrueを返す。
    """
    global head
    is_found = False

    # 削除対象のデータを探し，data_listのindexをnに格納する。
    for i in range(LIST_SIZE):
        if data_list[i] == data:
            n = i
            is_found = True
            break

    if not is_found:
        print("no data found")
        return False

    # pointer[i]がnを指しているのでpointer[n]が指している要素に変更する。
    if n != head:
        for i in range(LIST_SIZE):
            if pointer[i] == n:
                pointer[i] = pointer[n]

    # 削除するのがheadの時はheadをheadが指していたpointerつまり，headの次の要素に変更する。
    else:
        head = pointer[n]
        if head is None:
            head = 0

    # データの削除
    data_list[n] = None
    pointer[n] = None
    print(f"delete data {data}")
    return True


def put_list():
    """
    リストのデータの一覧を出力する
    """
    p = head
    while True:
        print(data_list[p], end="-->")
        if pointer[p] is None:
            print("EOF")
            break
        p = pointer[p]  # 取り出したらpを更新する。


# global変数の初期設定
LIST_SIZE = 5  # リストのサイズ
data_list = [None] * LIST_SIZE  # データ
pointer = [None] * LIST_SIZE
head = 0  # 先頭ノードの位置を管理する


def main():
    for i in range(1, 6):
        insert_list(i)
    put_list()

    # 削除テスト
    delete_list(3)
    put_list()

    # headを消してみる
    delete_list(1)
    put_list()


if __name__ == '__main__':
    main()
