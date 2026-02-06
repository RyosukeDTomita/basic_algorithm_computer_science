import Data.Vector.Unboxed qualified as VU

-- quickSort.hsのVector使用バージョン
quickSort :: (VU.Unbox a, Ord a) => [a] -> [a]
quickSort xs = VU.toList $ go (VU.fromList xs)
  where
    go vs
      | VU.null vs = VU.empty
      | otherwise = go left VU.++ VU.singleton pivot VU.++ go right
      where
        pivot = VU.head vs -- pivotは左端固定とする
        rest = VU.tail vs -- pivotを外す
        left = VU.filter (< pivot) rest
        right = VU.filter (>= pivot) rest

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69] :: [Int]
  print randomList
  print $ quickSort randomList