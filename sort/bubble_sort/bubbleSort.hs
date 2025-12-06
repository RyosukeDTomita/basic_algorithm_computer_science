bubbleSort :: (Ord a) => [a] -> [a]
bubbleSort xs =
  -- リストの数だけ再帰する
  go xs (length xs)
  where
    go xs 0 = xs
    go xs n = go (bubble xs) (n - 1)

    -- 隣同士を比較して交換する関数
    bubble (x : y : zs)
      | x > y = y : bubble (x : zs)
      | otherwise = x : bubble (y : zs)
    bubble xs = xs -- リストのサイズが2未満になった時

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  print $ bubbleSort randomList
