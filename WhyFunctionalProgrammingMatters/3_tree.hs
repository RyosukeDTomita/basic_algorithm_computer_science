-- https://www.sampou.org/haskell/article/whyfp.html より
-- Tree aはラベルaと自分自身(Tree a)のリストを持つデータ構造
-- つまり木の構造を表す
-- Node 1 [Node 2 [], Node 3 [Node 4 []]]
data Tree a = Node a [Tree a] deriving (Show)

-- 木のリストに対する畳み込み
redtree ::
  (a -> c -> b) -> -- f : node を潰す
  (b -> c -> c) -> -- g : cons を潰す
  c -> -- a : nil を潰す
  Tree a ->
  b
redtree f g a (Node label subtrees) =
  f label (redtree' f g a subtrees)

-- ツリーのリストを処理する関数
redtree' ::
  (a -> c -> b) ->
  (b -> c -> c) ->
  c ->
  [Tree a] ->
  c
redtree' f g a (subtree : rest) =
  g
    (redtree f g a subtree) -- リストのサイズが1に分解して潰す --> f label (redtree' f g a [先頭の木]) ...という流れでredtree' _ _ a [] = aにたどりつく
    (redtree' f g a rest) -- 残りで再帰
redtree' _ _ a [] =
  a

sumtree :: (Num a) => Tree a -> a
sumtree tree = redtree (+) (+) 0 tree

labels :: (Num a) => Tree a -> [a]
labels tree = redtree (:) (++) [] tree

maptree :: (a -> b) -> Tree a -> Tree b
maptree f tree = redtree (Node . f) (:) [] tree

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

main :: IO ()
main = do
  print $ sumtree tree -- 10
  print $ labels tree -- [1, 2, 3, 4]
  print $ maptree (* 2) tree