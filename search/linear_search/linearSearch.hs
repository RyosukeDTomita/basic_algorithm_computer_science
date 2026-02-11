linearSearch :: [Int] -> Int -> Int
linearSearch xs target =
  head
    [ i
      | i <- [0 .. length xs - 1],
        xs !! i == target
    ]

main :: IO ()
main = do
  let randomList = [30, 75, 69, 16, 47, 77, 60, 80, 74, 8, 77, 1, 60, 33, 70, 29, 24, 91, 60, 69]
  print randomList
  let target = 77
  print $ linearSearch randomList 77