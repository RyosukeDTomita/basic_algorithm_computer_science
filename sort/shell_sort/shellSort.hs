shellSort :: (Ord a) => [a] -> [a]
shellSort xs = foldl sortGap xs gaps -- gapは大きい順で処理される
  where
    n = length xs

    -- Knuth gapを使用。元のリストサイズ以下の範囲で生成し、降順ソート
    gaps =
      reverse $
        takeWhile
          (< n)
          [ (3 ^ k + 1) `div` 2
            | k <- [1 ..]
          ]
    -- リストをgap個のグループに分けて挿入ソートを実施する。 [0 .. gap -1]は挿入ソートの開始位置を表す
    sortGap arr gap = foldl (sortGroup gap) arr [0 .. gap - 1]

    -- 挿入ソートを実施する。
    -- [start + gap, start + 2 * gap .. n -1]は[最初の値, 2番目の値, 上限]という形になっていて、2番目の値から類推して生成される
    -- ghci> start = 0
    -- ghci> gap = 5
    -- ghci> [start + gap, start + 2 * gap .. 100]
    -- [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
    sortGroup gap arr start = foldl (insertGap gap start) arr [start + gap, start + 2 * gap .. n - 1]

    -- 挿入処理を行う。
    insertGap gap start arr i =
      let x = arr !! i -- 挿入対象
      -- xの元のindex(i)からgap間隔で左側に走査していき、条件を満たさなくなる場所までこれを続ける。
          j = until (\j -> j - gap < start || arr !! (j - gap) <= x) (subtract gap) i
       in insertAt j x (deleteAt i arr) -- NOTE: 関数の引数であるdeleteAtが先に評価されることに注意
      -- リストのi番目を削除する
    deleteAt i arr =
      let (left, _ : right) =
            splitAt i arr
       in left ++ right
    -- リストのi番目にxを挿入する
    insertAt i x arr =
      let (left, right) =
            splitAt i arr
       in left ++ (x : right)

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  print $ shellSort randomList