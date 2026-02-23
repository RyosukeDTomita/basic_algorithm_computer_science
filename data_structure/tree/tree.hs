import Data.List (find)

data Tree a = Node a [Tree a] deriving (Show) -- 型コンストラクタとしてTreeをデータコンストラクタとしてNodeを作成

-- 葉ノード（子を持たないノード）を作成
leaf :: a -> Tree a
leaf x = Node x []

-- ルートの値を取得
rootValue :: Tree a -> a
rootValue (Node x _) = x

-- 特定の値を持つノードの子として新しい値を挿入
-- 見つからない場合は元の木を返す
insertAt :: (Eq a) => a -> a -> Tree a -> Tree a
insertAt target newVal (Node x children)
  | x == target = Node x (leaf newVal : children)
  | otherwise = Node x (map (insertAt target newVal) children) -- mapするのはすべての子要素について調査するため

-- 特定の値を持つノードを削除（子ノードは親に昇格）
-- ルートノードは削除できない
delete :: (Eq a) => a -> Tree a -> Tree a
delete target (Node x children) = Node x (concatMap (deleteHelper target) children)
  where
    deleteHelper :: (Eq a) => a -> Tree a -> [Tree a]
    deleteHelper t (Node v children')
      | v == t = children' -- このノードを削除し、子を昇格
      | otherwise = [Node v (concatMap (deleteHelper t) children')]

-- 木に特定の値が含まれているか検索
contains :: (Eq a) => a -> Tree a -> Bool
contains target (Node x children) = x == target || any (contains target) children

-- 木のサイズ（ノード数）を取得
size :: Tree a -> Int
size (Node _ children) = 1 + sum (map size children)

-- 木の深さを取得
depth :: Tree a -> Int
depth (Node _ []) = 1
depth (Node _ children) = 1 + maximum (map depth children)

-- ある要素から見た親を探す
findParent :: (Eq a, Num a) => Tree a -> a -> a
findParent (Node x children) v
  | v `elem` map rootValue children = x
  | otherwise =
      foldr
        ( \child acc -> case findParent child v of
            -1 -> acc
            p -> p
        )
        (-1)
        children

-- 木を整形して表示（枝を使って階層構造を明確化）
prettyPrint :: (Show a) => Tree a -> String
prettyPrint tree = go "" "" tree
  where
    go prefix childPrefix (Node x children) =
      prefix
        ++ show x
        ++ "\n"
        ++ drawChildren childPrefix children

    drawChildren _ [] = ""
    drawChildren prefix [c] =
      go (prefix ++ "└── ") (prefix ++ "    ") c
    drawChildren prefix (c : children') =
      go (prefix ++ "├── ") (prefix ++ "│   ") c
        ++ drawChildren prefix children'

main :: IO ()
main = do
  -- 初期の木を作成
  let tree1 = Node 1 [leaf 2, leaf 3]
  print tree1
  putStr $ prettyPrint tree1

  -- ノード2の子として4を挿入
  putStrLn "\nノード2に4を挿入"
  let tree2 = insertAt 2 4 tree1
  print tree2
  putStr $ prettyPrint tree2

  -- ノード2を削除（子の4が昇格）
  putStrLn "\nノード2を削除後（子が昇格）:"
  let tree3 = delete 2 tree2
  print tree3
  putStr $ prettyPrint tree3

  -- 親を探す
  let parentOf4 = findParent tree2 4
  print parentOf4