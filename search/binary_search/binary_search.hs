import Data.List (sort)

-- targetを二分探索で探す
binarySearch :: [Int] -> Int -> Int -> Int -> Bool
binarySearch xs target left right
  | left > right = False -- 要素が見つからない
  | xs !! mid == target = True -- インデックスで要素にアクセス
  | xs !! mid < target = binarySearch xs target (mid + 1) right
  | otherwise = binarySearch xs target left (mid - 1)
  where
    mid = (left + right) `div` 2

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  let sortedList = sort randomList -- 配列がsort済みである必要がある
  print sortedList
  print $ binarySearch sortedList 47 0 (length sortedList - 1) -- 発見
  print $ binarySearch sortedList 100 0 (length sortedList - 1) -- 発見できず