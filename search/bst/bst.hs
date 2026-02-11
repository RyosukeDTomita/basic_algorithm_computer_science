{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

data BST a
  = Empty
  | Node a (BST a) (BST a)
  deriving (Show)

search :: (Ord a) => a -> BST a -> Bool
search _ Empty = False
search target (Node v left right)
  | target == v = True
  | target < v = search target left -- 自分より小さい値は左側の枝に
  | otherwise = search target right

insert :: (Ord a) => a -> BST a -> BST a
insert x Empty = Node x Empty Empty
insert x (Node v left right)
  | x == v = Node v left right
  | x < v = Node v (insert x left) right
  | otherwise = Node v left (insert x right)

-- 削除対象の位置にその位置からみた右部分木の最小値に置き換える。
-- これにより、左部分技よりは小さく、右部分技のどの値よりも小さな値がトップにくるため二分木が破綻しない。
delete :: (Ord a) => a -> BST a -> BST a
delete _ Empty = Empty
delete x (Node v left right)
  | x < v = Node v (delete x left) right
  | x > v = Node v left (delete x right)
  | otherwise = removeNode (Node v left right)

-- ノード削除ロジック
removeNode :: (Ord a) => BST a -> BST a
removeNode (Node _ Empty right) = right
removeNode (Node _ left Empty) = left
removeNode (Node _ left right) =
  -- 右部分木の最小値を取り出し、そのノードを除いた木も返す
  let (m, right') = detachMin right
   in Node m left right'
removeNode Empty = Empty

detachMin :: BST a -> (a, BST a)
detachMin Empty = error "detachMin: empty tree"
detachMin (Node x Empty right) = (x, right)
detachMin (Node x left right) =
  let (m, left') = detachMin left
   in (m, Node x left' right)

-- 木を整形して表示（枝を使って階層構造を明確化）
prettyPrint :: (Show a) => BST a -> String
prettyPrint tree = go "" "" tree
  where
    go _ _ Empty = ""
    go prefix childPrefix (Node x left right) =
      prefix
        ++ show x
        ++ "\n"
        ++ drawChildren childPrefix left right

    drawChildren prefix Empty Empty = ""
    drawChildren prefix left Empty =
      go (prefix ++ "└── ") (prefix ++ "    ") left
    drawChildren prefix Empty right =
      go (prefix ++ "└── ") (prefix ++ "    ") right
    drawChildren prefix left right =
      go (prefix ++ "├── ") (prefix ++ "│   ") left
        ++ go (prefix ++ "└── ") (prefix ++ "    ") right

main :: IO ()
main = do
  let bTree =
        Node
          5
          ( Node
              3
              ( Node
                  1
                  Empty
                  Empty
              )
              ( Node
                  4
                  Empty
                  Empty
              )
          )
          ( Node
              7
              ( Node
                  6
                  Empty
                  Empty
              )
              ( Node
                  8
                  Empty
                  Empty
              )
          )
  putStrLn "=====INITIAl====="
  putStrLn $ prettyPrint bTree
  print $ search 3 bTree -- 存在する
  print $ search 10 bTree -- 存在しない

  -- 追加
  putStrLn "=====ADD 10====="
  let bTree' = insert 10 bTree
  putStrLn $ prettyPrint bTree'
  print $ search 10 bTree'

  -- 存在する要素を追加
  putStrLn "=====ADD 3(already exists)====="
  let bTree'' = insert 3 bTree
  putStrLn $ prettyPrint bTree''
  print $ search 3 bTree''

  -- 削除
  putStrLn "=====DELETE 5====="
  let bTree''' = delete 5 bTree
  putStrLn $ prettyPrint bTree'''
  print $ search 5 bTree'''

  -- 存在しない要素を削除する
  putStrLn "=====DELETE 8(not exist)====="
  let bTree'''' = delete 8 bTree
  putStrLn $ prettyPrint bTree''''
  print $ search 8 bTree''''