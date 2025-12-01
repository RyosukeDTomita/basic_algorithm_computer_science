-- 要素を正しい位置に挿入する関数
insert :: (Ord a) => a -> [a] -> [a]
insert e [] = [e] -- 空リストへの挿入
insert e (x : xs)
  | e <= x = e : x : xs -- eをxの左へ
  | otherwise = x : insert e xs -- eをxsの適切な位置へ挿入

-- 挿入ソート関数
insertSort :: (Ord a) => [a] -> [a]
insertSort [] = []
insertSort (x : xs) = insert x (insertSort xs)

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  print $ insertSort randomList
