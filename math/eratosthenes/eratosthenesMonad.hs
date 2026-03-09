import Control.Monad (forM_, when)
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM

type PrimeTable = VU.Vector Bool

primeTableToList :: PrimeTable -> [Int]
primeTableToList t =
  [ i
    | i <- [0 .. VU.length t - 1],
      t VU.! i
  ]

isInPrimeTable :: PrimeTable -> Int -> Bool
isInPrimeTable t n
  | 0 <= n && n < VU.length t = t VU.! n
  | otherwise = error "out of range"

sieve :: Int -> PrimeTable
sieve n = VU.create $ do
  vec <- VUM.replicate (n + 1) True
  VUM.write vec 0 False
  VUM.write vec 1 False
  forM_ [2 .. n] $ \i -> do
    b <- VUM.read vec i
    when b $ do
      forM_ [2 * i, 3 * i .. n] $ \j -> do
        VUM.write vec j False
  return vec

main = do
  let t = sieve 100
  print $ primeTableToList t

-- print $ take 20 primes
-- print $ 7 `elem` primes

-- print $ 102 `elem` primes -- 素数でない数を探索すると止まらない