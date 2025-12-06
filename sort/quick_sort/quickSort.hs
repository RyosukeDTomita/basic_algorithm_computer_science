-- NOTE: pivotは雑に左端から選択している
quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x : xs) = quickSort left ++ [x] ++ quickSort right
  where
    left = filter (< x) xs
    right = filter (>= x) xs

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  print $ quickSort randomList