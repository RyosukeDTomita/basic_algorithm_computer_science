import Data.Array

-- nまでのフィボナッチ数列を計算して配列にキャッシュ
fibonacciArray :: Int -> Array Int Int
fibonacciArray n = arr
  where
    arr = listArray (0, n) [fib i | i <- [0..n]]
    fib 0 = 0
    fib 1 = 1
    fib i = arr ! (i - 1) + arr ! (i - 2)  -- 計算済みを参照

main :: IO ()
main = do
    let n = 35
    let fibs = fibonacciArray n
    print [fibs ! i | i <- [0..n]]
