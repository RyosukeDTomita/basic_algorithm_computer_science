-- 二分探索を使って関数の条件を満たす最大の値を求める。
binarySearch :: Int -> Int -> (Int -> Bool) -> Int
binarySearch ok ng f
  | abs (ok - ng) <= 1 = ok -- これが最大の値
  | f mid = binarySearch mid ng f
  | otherwise = binarySearch ok mid f
  where
    mid = (ok + ng) `div` 2

main :: IO ()
main = do
  print $ binarySearch 0 100 (\x -> x ^ 2 <= 30) -- x^2 <= 30 を満たす最大の値xを0から100の範囲で求める