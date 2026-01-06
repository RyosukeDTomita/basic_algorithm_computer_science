-- https://www.sampou.org/haskell/article/whyfp.html
-- 近似を1つ進める関数
next :: Double -> Double -> Double
next n x = (x + n / x) / 2

-- 許容誤差と近似値よりも差の小さい2つの連続する近似値を探す
within :: Double -> [Double] -> Double
within eps (a : b : rest)
  | abs (a - b) <= eps = b -- 絶対誤差
  | otherwise = within eps (b : rest)

-- ２つの近似値の比が1に近づくようにして許容誤差よりも小さい２つの連続する近似値を探す
relative :: Double -> [Double] -> Double
relative eps (a : b : rest)
  | abs (a - b) <= eps * abs b = b -- abs (a - b) / abs b <= epsを変形したもの。いわゆる相対誤差
  | otherwise = relative eps (b : rest)

-- withinを使って平方根をもとめる例
sqrt' :: Double -> Double -> Double -> Double
sqrt' a0 eps n = within eps $ iterate (next n) a0

relativesqrt :: Double -> Double -> Double -> Double
relativesqrt a0 eps n = relative eps $ iterate (next n) a0

main :: IO ()
main = do
  let n = fromIntegral 2 -- 平方根を求めたい値
  let a0 = fromInteger 1 -- 計算の初期値
  let eps = 0.001
  let epsRelative = 0.001
  print $ take 10 $ iterate (next n) 1
  print $ sqrt' a0 eps n
  print $ relativesqrt a0 epsRelative n