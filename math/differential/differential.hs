-- https://www.sampou.org/haskell/article/whyfp.html
import Control.Arrow (Arrow (second))
import Data.Semigroup (diff)

-- 傾きをもとめる
easyDiff :: (Fractional a) => (a -> a) -> a -> a -> a
easyDiff f x h = (f (x + h) - f x) / h

differentiate :: Double -> (Double -> Double) -> Double -> [Double]
differentiate h0 f x = map (easyDiff f x) (iterate halve h0)
  where
    halve x = x / 2

-- 許容誤差と近似値よりも差の小さい2つの連続する近似値を探す
within :: Double -> [Double] -> Double
within eps (a : b : rest)
  | abs (a - b) <= eps = b -- 絶対誤差
  | otherwise = within eps (b : rest)

-- テスト用の関数
square :: Double -> Double
square x = x ** 2

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

main :: IO ()
main = do
  let eps = 0.001
  let h0 = 0.1
  let x = 3
  print $ within eps (differentiate h0 square x)
  -- より良い近似
  print $ within eps (improve (differentiate h0 square x))
  -- improveを複数回やると効率良く近似できる
  print $ within eps (improve (improve (improve (differentiate h0 square x))))
  -- 複数回improveするものの改良版
  print $ within eps (super (differentiate h0 square x))