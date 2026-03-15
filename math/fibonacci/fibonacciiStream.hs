fibSeq :: Int -> [Int]
fibSeq n = map fst $ take n $ iterate (\(a, b) -> (b, a + b)) (0, 1)

main :: IO ()
main = do
  print $ fibSeq 36