import Data.Hashable (Hashable, hash)
import Data.Vector qualified as V
import Debug.Trace (trace, traceShowId)

dbgId :: (Show a) => a -> a
dbgId x = trace ("bucketIndex is " ++ show x) x

-- チェイン法によるハッシュ
-- NOTE: レコード構文を使い、buckets hsで値が取得できるようにしている
-- ghci> import Data.Vector qualified as V
-- ghci> data HashSet a = HashSet {buckets :: V.Vector [a]} deriving (Show)
-- ghci> hs = HashSet {buckets=(V.replicate 3 [])}
-- ghci> buckets hs
-- [[],[],[]]
data HashSet a = HashSet {buckets :: V.Vector [a]}
  deriving (Show)

-- どのindexに保存するかを決める
bucketIndex :: (Hashable a) => HashSet a -> a -> Int
bucketIndex hs x = abs (hash x) `mod` V.length (buckets hs)

-- ハッシュテーブルの初期化
empty :: Int -> HashSet a
empty size = HashSet (V.replicate size [])

-- 値の存在確認
member :: (Eq a, Hashable a) => a -> HashSet a -> Bool
member x hs = x `elem` bucket -- NOTE: チェイン法なので同じハッシュの値が含まれている可能性があるのでelemでチェックしている
  where
    i = bucketIndex hs x
    bucket = buckets hs V.! i

insert :: (Eq a, Hashable a) => a -> HashSet a -> HashSet a
insert x hs
  | member x hs = hs -- 同じ要素は格納しない
  | otherwise = hs {buckets = buckets hs V.// [(i, x : bucket)]} -- index iの要素をx:bucketに置き換える(チェイン法なので同じハッシュの値は維持)
  where
    i = dbgId $ bucketIndex hs x
    bucket = buckets hs V.! i

delete :: (Eq a, Hashable a) => a -> HashSet a -> HashSet a
delete x hs =
  hs {buckets = buckets hs V.// [(i, newBucket)]}
  where
    i = dbgId $ bucketIndex hs x
    bucket = buckets hs V.! i
    newBucket = filter (/= x) bucket

main :: IO ()
main = do
  let hs0 = empty 8 :: HashSet Int -- サイズ8
  print hs0

  -- insert
  print "insert 1 4"
  let hs1 = insert 1 hs0
      hs2 = insert 4 hs1
  print hs2

  -- check
  print "check 10 1 is store"
  print $ member 10 hs2 -- False
  print $ member 1 hs2 -- True

  -- delete
  print "delete 1 and check 1 4 is store"
  let hs2' = delete 1 hs2
  print hs2'
  print $ member 1 hs2' -- False
  print $ member 4 hs2 -- True

  -- 同じハッシュのときのチェック
  print "same hash"
  let hs3 = insert 16 hs2
      hs4 = insert 32 hs3
  print hs4