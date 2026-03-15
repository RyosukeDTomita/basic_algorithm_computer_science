-- フィボナッチ数列の計算（再帰定義）
fibonacciNumber :: Int -> Int
fibonacciNumber n
  | n == 0 = 0
  | n == 1 = 1
  | otherwise = fibonacciNumber (n - 1) + fibonacciNumber (n - 2)

main :: IO ()
main = do
  let range = [0 .. 35]
  let fibonacciNumberList = map fibonacciNumber range
  print fibonacciNumberList
