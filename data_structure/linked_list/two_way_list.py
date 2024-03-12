# coding: utf-8
"""
線形リスト
"""


class Node:
    def __init__(self, data: int):
        self.data = data
        self.prev_node = None
        self.next_node = None


class DoubleLinkedList:
    def __init__(self):
        self.head = None

    def insert(self, data: int) -> None:

    def delete(self, data: int) -> None:

    def print_list(self) -> None:
        tmp = self.head
        while tmp:
            print(tmp.data, end=",")
            tmp = tmp.next_node
            if tmp == self.head:
                return
        else:
            print("List is empty.")


def main():
    doubly_linked_list = DoubleLinkedList()
    for i in range(5):
        doubly_linked_list.insert(i)
    doubly_linked_list.print_list()


if __name__ == '__main__':
    main()
