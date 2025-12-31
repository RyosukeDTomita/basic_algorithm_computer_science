-- https://www.sampou.org/haskell/article/whyfp.html
easyIntegrate :: (Fractional a) => (a -> a) -> a -> a -> a
easyIntegrate f a b = (f a + f b) * (b - a) / 2

integrate :: (Double -> Double) -> Double -> Double -> [Double]
integrate f a b =
  easyIntegrate f a b
    : zip'
      (integrate f a mid)
      (integrate f mid b)
  where
    mid = (a + b) / 2

-- fa fm fbの値をキャッシュすることで効率化したバージョン
-- integrate' :: (Double -> Double) -> Double -> Double -> [Double]
-- integrate' f a b = integ f a b (f a) (f b)
--   where
--     integ f a b fa fb = ((fa + fb) * (b - a) / 2) : zipWith (+) (integ f a m fa fm) (integ f m b fm fb)
--     m = (a + b) / 2 -- NOTE: この実装だとmとfmが束縛されてしまい、すべてのintegに対して同じ値を使うので不適切
--     fm = f m
integrate' :: (Double -> Double) -> Double -> Double -> [Double]
integrate' f a b = integ a b (f a) (f b)
  where
    integ a b fa fb =
      let m = (a + b) / 2
          fm = f m
       in ((fa + fb) * (b - a) / 2)
            : zipWith
              (+)
              (integ a m fa fm)
              (integ m b fm fb)

-- 誤差を消去するリスト変換
-- a = a(i)
-- b = b(i+1)
--      	a(i+1)*(2**n) - a(i)
-- A = --------------------
--           2**n - 1
elimerror :: Int -> [Double] -> [Double]
elimerror n (a : b : rest) =
  ((b * (2 ** fromIntegral n) - a) / (2 ** fromIntegral n - 1)) : elimerror n (b : rest)

-- nを求められるらしい。
order :: [Double] -> Int
order (a : b : c : _) =
  round (logBase 2 ((a - c) / (b - c) - 1))

improve :: [Double] -> [Double]
improve s = elimerror (order s) s

-- 複数回improveすると急速に高い結果をもたらす
super :: [Double] -> [Double]
super s = map second (iterate improve s)
  where
    second (a : b : rest) = b

zip' :: (Num a) => [a] -> [a] -> [a]
zip' (a : s) (b : t) = a + b : (zip' s t)
zip' _ _ = []

zip'' :: (Num a) => [a] -> [a] -> [a]
zip'' as bt = zipWith (+) as bt

-- 許容誤差と近似値よりも差の小さい2つの連続する近似値を探す
within :: Double -> [Double] -> Double
within eps (a : b : rest)
  | abs (a - b) <= eps = b -- 絶対誤差
  | otherwise = within eps (b : rest)

relative :: Double -> [Double] -> Double
relative eps (a : b : rest)
  | abs (a - b) <= eps * abs b = b -- abs (a - b) / abs b <= epsを変形したもの。いわゆる相対誤差
  | otherwise = relative eps (b : rest)

square :: Double -> Double
square x = x * x

main :: IO ()
main = do
  -- print $ zip' [1, 2] [3, 4] -- [4, 6]
  -- print $ zip'' [1, 2] [3, 4] -- [4, 6]
  let eps = 0.001
  let a = 0
  let b = 3
  print $ within eps (integrate' square a b) -- x^2を積分すると(1/3) * x^3なので
  print $ relative eps (integrate' square a b)

  -- 高速にsinの積分を求める例
  -- print $ improve (integrate' sin 0 4)

  -- π/4
  let f x = 1 / (1 + x * x)
  print $ within eps (super (integrate' f 0 1))
