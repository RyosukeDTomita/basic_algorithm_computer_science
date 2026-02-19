{-# LANGUAGE NumDecimals #-}

import Data.Int (Int64)

-- 法となる素数: 32 bit整数の最大値である2.1 * 10^9に近い
modulus :: Int64
-- modulus = 10 ^ 9 + 7
modulus = 1e9 + 7 -- NumDecimals拡張を使うとコンパイル時に1000000007に展開される。

-- 繰り返し二乗法による (n^k) mod modulus の計算
-- e.g. x^9の場合: x^2 = x * x
-- x^4 = x^2 * x^2
-- x^8 = x^4 * x^4
-- x^9 = x * x^8
powMod :: Int64 -> Int64 -> Int64
powMod _ 0 = 1
powMod n k
  | even k =
      let half = powMod n (k `div` 2)
       in (half * half) `mod` modulus
  | otherwise = (n * powMod n (k - 1)) `mod` modulus

-- フェルマーの小定理を用いた逆元計算
-- a^(p-2) mod p
invMod :: Int64 -> Int64
invMod 0 = error "inverse of 0"
invMod a = powMod a (modulus - 2)

main :: IO ()
main = do
  let a = 3
  let invA = invMod a
  print invA
  print $ (a * invA) `mod` modulus -- フェルマーの小定理より1になるはず。