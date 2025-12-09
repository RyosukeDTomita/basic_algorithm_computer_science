-- ユークリッドの互助法
euclidean :: Int -> Int -> Int
euclidean a b
  | a `mod` b == 0 = b
  | otherwise = euclidean b (a `mod` b)

main :: IO ()
main = do
  print $ euclidean 5 21
  print $ euclidean 10 100