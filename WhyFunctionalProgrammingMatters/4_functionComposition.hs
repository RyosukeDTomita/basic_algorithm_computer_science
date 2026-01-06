main :: IO ()
main = do
  print $ (\input -> (+ 1) ((* 2) input)) 3 -- lambda式版
  print $ ((+ 1) . (* 2)) 3 -- 関数合成のほうが完結に書ける 3*2+1