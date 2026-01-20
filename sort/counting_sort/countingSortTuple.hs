countingSort :: [Int] -> [Int]
countingSort [] = []
countingSort xs =
  let updateCounts :: [(Int, Int)] -> Int -> [(Int, Int)]
      -- 第一引数: 操作前のcounts。各数値が何個見つかったか記録する
      -- x
      -- return xを適用したcounts
      -- 1回の更新はO(k)なので全体の最悪ケースはO(n^2)
      updateCounts [] x = [(x, 1)]
      updateCounts ((v, c) : rest) x
        | v == x = (v, c + 1) : rest
        | v < x = (v, c) : updateCounts rest x
        | otherwise = (x, 1) : (v, c) : rest
      counts = foldl updateCounts [] xs
      -- タプルから元のリストを再構築
      expand (value, count) = replicate count value
   in concatMap expand counts

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  print $ countingSort randomList