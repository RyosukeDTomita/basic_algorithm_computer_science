mergeSort :: [Int] -> [Int]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort left) (mergeSort right) -- 配列をサイズ1もしくは空になるまで分割する
  where
    (left, right) = splitAt (length xs `div` 2) xs -- 真ん中でリストを分割する

-- 配列を合成する過程でソートする
merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x : xs) (y : ys)
  | x <= y = x : merge xs (y : ys)
  | otherwise = y : merge (x : xs) ys

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  print $ mergeSort randomList