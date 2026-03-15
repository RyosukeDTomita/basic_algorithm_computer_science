# フィボナッチ数列まとめ

## INDEX

- [再帰](./fibonacciRecursive.hs)
- [一度計算した値を保存する](./fibonacciCache.hs)
- [遅延評価を使った実装](./fibonacciLazy.hs): Haskellの遅延評価を利用して無限リストが定義できている。また、Haskellの遅延評価はcall-by-needなので、同じ式が複数回評価されず、メモ化と同様の効果が得られている。
- [ストリームを使うバージョン](./fibonacciStream.hs)
