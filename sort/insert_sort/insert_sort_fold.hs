insertSort :: (Ord a) => [a] -> [a]
insertSort xs = foldr insert [] xs
  where
    insert x [] = [x]
    insert x (y : ys) -- xをyとysの間に入れられるか調べる
      | x <= y = x : y : ys -- yの前にxを入れる
      | otherwise = y : insert x ys -- yとysの間にxは入れられることがわかったので、再帰してxを入れる適切な位置を探す。

insertSort' :: (Ord a) => [a] -> [a]
insertSort' xs = foldl (flip insert) [] xs -- flipは関数につけて引数の順序を逆にする
  where
    insert x [] = [x]
    insert x (y : ys) -- xをyとysの間に入れられるか調べる
      | x <= y = x : y : ys -- yの前にxを入れる
      | otherwise = y : insert x ys -- yとysの間にxは入れられることがわかったので、再帰してxを入れる適切な位置を探す。

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  print $ insertSort randomList
  print $ insertSort' randomList
