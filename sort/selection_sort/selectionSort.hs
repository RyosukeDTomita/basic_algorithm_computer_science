import Data.List (delete, unfoldr)

selectionSort :: (Ord a) => [a] -> [a]
selectionSort xs =
  go xs
  where
    go [] = []
    go xs = let m = minimum xs in m : go (delete m xs) -- deleteで特定の要素を消した配列を返している

-- unfoldrを使って簡潔に書いたバージョン
selectionSort' :: (Ord a) => [a] -> [a]
selectionSort' xs = unfoldr go xs
  where
    go [] = Nothing -- 空なら停止
    go xs =
      let m = minimum xs
          xs' = delete m xs
       in Just (m, xs')

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  print $ selectionSort randomList
  print $ selectionSort' randomList