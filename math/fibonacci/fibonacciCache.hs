-- 一度求めたフィボナッチ数列をキャッシュする
-- NOTE: O(1)で要素にアクセスするためにVectorで実装した
import Data.Vector (Vector, fromList, (!))

fibonacciVector :: Int -> Vector Int
fibonacciVector n = vec
  where
    vec = fromList [fib i | i <- [0 .. n]] -- 一度計算したものはキャッシュされる
    fib 0 = 0
    fib 1 = 1
    fib i = vec ! (i - 1) + vec ! (i - 2) -- 計算済みを参照

main :: IO ()
main = do
  let n = 35
  let fibs = fibonacciVector n
  print [fibs ! i | i <- [0 .. n]]
