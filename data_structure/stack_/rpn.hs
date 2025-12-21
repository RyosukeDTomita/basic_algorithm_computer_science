rpn :: [String] -> [Int]
rpn input = foldl step [] input
  where
    step :: [Int] -> String -> [Int]
    step stack operand =
      case operand of
        "+" -> let (a : b : rest) = stack in (b + a) : rest
        "-" -> let (a : b : rest) = stack in (b - a) : rest
        "*" -> let (a : b : rest) = stack in (b * a) : rest
        n -> (read :: String -> Int) n : stack

main :: IO ()
main = do
  print $ rpn $ words "4 8 + 1 3 + *" -- (4 + 8) * (1 + 3)