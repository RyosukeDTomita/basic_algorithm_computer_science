-- 以下のdata型の定義はhttps://www.staff.city.ac.uk/~ross/papers/FingerTree.htmlに記載のあるものを流用している。
data FingerTree a
  = Empty -- 要素なし
  | Single a -- 要素1つ
  | Deep (Digit a) (FingerTree (Node a)) (Digit a)
  deriving (Show)

-- Finger Tree左右端のバッファ
data Digit a
  = One a
  | Two a a
  | Three a a a
  | Four a a a a
  deriving (Show)

-- Finger Treeの中間圧縮ノード
data Node a
  = Node2 a a
  | Node3 a a a
  deriving (Show)

-- 以降はそれっぽく作っているだけ。

-- 先頭(左端)追加
(<|) :: a -> FingerTree a -> FingerTree a
x <| Empty = Single x
x <| Single a = Deep (One x) Empty (One a)
-- pr: prefix(Digit)
-- m: middle(Node)
-- sf: suffix(Digit)
x <| Deep pr m sf =
  case pr of -- 左端のDigitのサイズで分岐
    One a -> Deep (Two x a) m sf
    Two a b -> Deep (Three x a b) m sf
    Three a b c -> Deep (Four x a b c) m sf
    Four a b c d -> Deep (Two x a) (Node3 b c d <| m) sf -- TODO

-- 末尾(右端)追加
(|>) :: FingerTree a -> a -> FingerTree a
Empty |> x = Single x
Single a |> x = Deep (One a) Empty (One x)
-- pr: prefix(Digit)
-- m: middle(Node)
-- sf: suffix(Digit)
Deep pr m sf |> x =
  case sf of
    One a -> Deep pr m (Two a x)
    Two a b -> Deep pr m (Three a b x)
    Three a b c -> Deep pr m (Four a b c x)
    Four a b c d -> Deep pr (m |> Node3 a b c) (Two d x)

data ViewR a
  = EmptyR
  | FingerTree a :> a
  deriving (Show)

-- 末尾(右端)とりだし
viewR :: FingerTree a -> ViewR a
viewR Empty = EmptyR
viewR (Single x) = Empty :> x
viewR (Deep pr m sf) =
  case sf of
    One a ->
      case viewR m of
        EmptyR -> digitToTreeR pr
        m' :> Node2 b c -> Deep pr m' (Two b c) :> a
        m' :> Node3 b c d -> Deep pr m' (Three b c d) :> a
    Two a b -> Deep pr m (One a) :> b
    Three a b c -> Deep pr m (Two a b) :> c
    Four a b c d -> Deep pr m (Three a b c) :> d

digitToTreeR :: Digit a -> ViewR a
digitToTreeR (One a) = Empty :> a
digitToTreeR (Two a b) = Single a :> b
digitToTreeR (Three a b c) = Deep (One a) Empty (One b) :> c
digitToTreeR (Four a b c d) = Deep (Two a b) Empty (One c) :> d

data ViewL a
  = EmptyL
  | a :< FingerTree a
  deriving (Show)

-- 先頭(左端)取り出し
viewL :: FingerTree a -> ViewL a
viewL Empty = EmptyL
viewL (Single x) = x :< Empty
viewL (Deep pr m sf) =
  case pr of
    One a ->
      case viewL m of
        EmptyL -> case digitToTree sf of
          b :< t -> a :< (b <| t)
        Node2 b c :< m' -> a :< Deep (Two b c) m' sf
        Node3 b c d :< m' -> a :< Deep (Three b c d) m' sf
    Two a b ->
      a :< Deep (One b) m sf
    Three a b c ->
      a :< Deep (Two b c) m sf
    Four a b c d ->
      a :< Deep (Three b c d) m sf

-- digitをFingerTreeに変換する (ViewL用)
digitToTree :: Digit a -> ViewL a
digitToTree (One a) = a :< Empty
digitToTree (Two a b) = a :< Single b
digitToTree (Three a b c) = a :< Deep (One b) Empty (One c)
digitToTree (Four a b c d) = a :< Deep (Two b c) Empty (One d)

main :: IO ()
main = do
  -- 末尾追加
  let addFingerTree = scanl (|>) Empty [1 .. 21]
  putStrLn $ unlines $ map show addFingerTree
  putStrLn "--------------------------------------"
  -- 先頭追加
  let addFingerTree' = scanl (flip (<|)) Empty $ reverse [1 .. 21]
  putStrLn $ unlines $ map show addFingerTree'
  putStrLn "--------------------------------------"

  -- 末端から取り出される過程をみる
  let testFingerTree = foldl (|>) Empty [1 .. 21]
  let removeSteps = scanl (\ft _ -> restL ft) testFingerTree [1 .. 21]
  putStrLn $ unlines $ map show removeSteps
  putStrLn "--------------------------------------"

  -- 先頭から取り出される過程をみる
  let testFingerTree = foldl (|>) Empty [1 .. 21]
  let removeSteps = scanl (\ft _ -> restL ft) testFingerTree [1 .. 21]
  putStrLn $ unlines $ map show removeSteps

-- viewRの結果から残りの木を取り出す
restR :: FingerTree a -> FingerTree a
restR ft = case viewR ft of
  EmptyR -> Empty
  rest :> _ -> rest

-- viewLの結果から残りの木を取り出す
restL :: FingerTree a -> FingerTree a
restL ft = case viewL ft of
  EmptyL -> Empty
  _ :< rest -> rest