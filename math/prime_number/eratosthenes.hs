import Control.Monad (forM_, when)
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM

type PrimeTable = VU.Vector Bool -- i番目の数字が素数かどうかをBoolで管理するtable

-- 素数のリストを返す
primeTableToList :: PrimeTable -> [Int]
primeTableToList t =
  [ i
    | i <- [0 .. VU.length t - 1],
      t VU.! i
  ]

-- PrimeTableに入っていれば素数であると判定する。
isInPrimeTable :: PrimeTable -> Int -> Bool
isInPrimeTable t n
  | 0 <= n && n < VU.length t = t VU.! n
  | otherwise = error "out of range"

-- 先頭の値iはかならす素数なので、iの倍数を生成して素数でないものを弾いていく。
sieve :: Int -> PrimeTable
sieve n = VU.create $ do
  vec <- VUM.replicate (n + 1) True
  -- 0、1は素数でない
  VUM.write vec 0 False
  VUM.write vec 1 False
  forM_ [2 .. n] $ \i -> do
    b <- VUM.read vec i
    when b $ do
      forM_ [2 * i, 3 * i .. n] $ \j -> do
        -- ghci> [2 * i , 3 * i ..10]=[4,6,8,10]
        VUM.write vec j False
  return vec

main :: IO ()
main = do
  -- 100までの素数を作る
  let t = sieve 100
  print t
  let prime = primeTableToList t
  print prime

  -- 素数判定
  print $ isInPrimeTable t 47
  print $ isInPrimeTable t 57
