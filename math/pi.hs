-- 円周率piが3.14以上であることがわかるn角形をもとめる
import Text.Printf (printf)

-- n角形による π の近似
approxPi :: Int -> Double
approxPi n
  | n >= 3 = fromIntegral n * sin (pi / fromIntegral n)
  | otherwise = error "invalid n"

iteratePi :: Int -> Int
iteratePi n
  | approxPi n >= 3.14 = n
  | otherwise = iteratePi (n + 1)

main :: IO ()
main = do
  let initialN = 3
  print $ iteratePi initialN
