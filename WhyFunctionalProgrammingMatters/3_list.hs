-- Haskell版
sumList :: (Num a) => [a] -> a
sumList [] = 0
sumList (x : xs) = x + sumList xs

-- Haskellのfoldrと同じ
reduce' :: (a -> b -> b) -> b -> [a] -> b
reduce' _ x [] = x
reduce' f x (a : l) = f a (reduce' f x l)

-- reduce版 sum
sumList' :: (Num a) => [a] -> a
sumList' xs = reduce' (+) 0 xs -- reduce'はfoldrで置き換え可能

product' :: (Num a) => [a] -> a
product' xs = reduce' (*) 1 xs

-- Haskellにはandという関数がある
allTrue :: [Bool] -> Bool
allTrue xs = foldr (&&) True xs

-- Haskellにはorという関数がある
anyTrue :: [Bool] -> Bool
anyTrue xs = foldr (||) False xs

-- リストの連結を行う
append' :: [a] -> [a] -> [a]
append' xs ys = foldr (:) ys xs

-- リストの中身を2倍にする
doubleall :: (Foldable t, Num a) => t a -> [a]
doubleall xs = foldr doubleandcons [] xs
  where
    doubleandcons num xs = (:) (2 * num) xs

-- リストの中身を2倍にする(関数合成版)
doubleall' :: (Foldable t, Num a) => t a -> [a]
doubleall' xs = foldr ((:) . double) [] xs
  where
    double n = 2 * n

-- リストの中身を2倍にする(map + 関数合成版)
doubleall'' :: (Foldable t, Num a) => t a -> [a]
doubleall'' xs = map' double xs
  where
    map' f xs = foldr ((:) . f) [] xs
    double n = 2 * n

-- 2次元配列を全部足す
sumMatrix :: [[a]] -> a
sumMatrix xxs = (sum . map sum) xxs

main :: IO ()
main = do
  -- リストの定義
  print $ 1 : (2 : (3 : [])) -- [1, 2, 3]

  -- sum
  print $ sumList [1, 2, 3] -- 1 + 2 + 3 = 6

  -- reduce版
  print $ sumList' [1, 2, 3]
  print $ product' [1, 2, 3] -- 1 * 2 * 3 = 6

  -- リストの要素が全てTrueか
  print $ allTrue [True, True, True] -- True
  print $ allTrue [True, True, False] -- False

  -- リストの要素が一つでもTrueか
  print $ anyTrue [True, True, True] -- True
  print $ anyTrue [True, True, False] -- True
  print $ anyTrue [False, False, False] -- False

  -- リストの連結
  print $ append' [1, 2, 3] [4, 5]

  -- リストの中身を2倍にする
  print $ doubleall [1, 2, 3]
  print $ doubleall' [1, 2, 3]

  -- mapの発見
  print $ doubleall'' [1, 2, 3]
  print $ sumMatrix [[1, 2, 3], [4, 5], [6, 7, 8, 9]]
