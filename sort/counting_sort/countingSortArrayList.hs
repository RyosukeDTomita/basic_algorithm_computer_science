countingSort :: [Int] -> [Int]
countingSort [] = []
countingSort xs =
  let maxX = maximum xs
      minX = minimum xs
      range = maxX - minX + 1
      -- 初期化：すべて0のリストを作成
      initCounts = replicate range 0
      -- 各値の出現回数をカウント（リストの更新はO(n)なので全体でO(n²)）
      updateCount :: [Int] -> Int -> [Int]
      updateCount counts x =
        let idx = x - minX
            (before, current : after) = splitAt idx counts
         in before ++ (current + 1) : after
      counts = foldl updateCount initCounts xs
      -- カウント配列から元のリストを再構築
      expand (i, count) = replicate count (i + minX)
   in concatMap expand (zip [0 ..] counts)

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  print $ countingSort randomList