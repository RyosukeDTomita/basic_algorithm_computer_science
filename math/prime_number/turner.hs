-- これはTurnerのふるいであってエラトステネスのふるいではないらしい
primes :: [Int]
primes = 2 : sieve [3, 5 ..] -- 2+奇数の無限配列
  where
    -- 初期値2は素数であり、pはそれより小さい素数の合成数でないため、リストの先頭は必ず素数である
    -- pで割ったあまりが0になる数をリストから削除することを繰り返すことで素数のリストができる。
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