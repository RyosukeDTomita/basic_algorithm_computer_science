primes :: [Int]
primes = 2 : sieve [3, 5 ..] -- 2と奇数の無限配列
  where
    sieve (p : xs) =
      p
        : sieve
          [ x
            | x <- xs,
              x `mod` p /= 0
          ]

main :: IO ()
main = do
  print $ take 20 primes
  print $ 7 `elem` primes

-- print $ 102 `elem` primes -- 素数でない数を探索すると止まらない