-- https://www.sampou.org/haskell/article/whyfp.html より
data Tree a = Node a [Tree a]

-- 木のリストに対する畳み込み
redtree ::
  (a -> b -> b) -> -- f : node を潰す
  (b -> b -> b) -> -- g : cons を潰す
  b -> -- a : nil を潰す
  Tree a ->
  b
redtree f g a (Node label subtrees) =
  f label (redtree' f g a subtrees)

-- ツリーのリストを処理する関数
redtree' ::
  (a -> b -> b) ->
  (b -> b -> b) ->
  b ->
  [Tree a] ->
  b
redtree' f g a (subtree : rest) =
  g
    (redtree f g a subtree) -- リストのサイズが1に分解して潰す --> f label (redtree' f g a [先頭の木]) ...という流れでredtree' _ _ a [] = aにたどりつく
    (redtree' f g a rest) -- 残りで再帰
redtree' _ _ a [] =
  a

tree :: Tree Int
tree =
  Node
    1
    ( (:)
        (Node 2 [])
        ( (:)
            ( Node
                3
                ((:) (Node 4 []) [])
            )
            []
        )
    )

sumtree :: (Num a) => Tree a -> a
sumtree tree = redtree (+) (+) 0 tree

labels :: (Num a) => Tree a -> [a]
labels tree = redtree (:) (++) [] tree

maptree :: (a -> b) -> Tree a -> Tree b
maptree f tree = redtree (\label subtrees -> Node (f label) subtrees) (:) [] tree

main :: IO ()
main = do
  print $ sumtree tree -- 10
  print $ labels tree -- [1, 2, 3, 4]
  print $ maptree (* 2) tree