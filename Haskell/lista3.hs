module Lista3 where

import Data.Foldable
import qualified Data.List as List
import qualified System.Random as Random

-- Zad 1

data Tree a = Leaf a | Node (Tree a) (Tree a)
  deriving (Show)

flipVals :: Tree a -> Tree a
flipVals = undefined

-- Zad 2

newtype DiffList a = DiffList { unDiffList :: [a] -> [a] }

fromDiffList :: DiffList a -> [a]
fromDiffList = undefined

toDiffList :: [a] -> DiffList a
toDiffList = undefined

diffSingleton :: a -> DiffList a
diffSingleton = undefined

instance Semigroup (DiffList a) where
  -- all methods undefined

instance Monoid (DiffList a) where
  -- all methods undefined

instance Foldable Tree where
  -- all methods undefined

-- Zad 3

data CoinTree a = CTLeaf a
                | CTNode (CoinTree a) (CoinTree a)

data ProbTree a = PTLeaf a
                | PTNode Double (ProbTree a) (ProbTree a)

toCoinTree :: ProbTree a -> CoinTree a
toCoinTree = undefined

coinRun :: [Bool] -> CoinTree a -> a
coinRun = undefined

randomCoinRun :: CoinTree a -> IO a
randomCoinRun t = do 
  gen <- Random.initStdGen
  let bitStream = List.unfoldr (Just . Random.uniform) gen
  return (coinRun bitStream t)

-- Zad 4

data Frac = Frac Integer Integer

instance Num Frac where
  -- all methods undefined

-- Zad 5

data CReal = CReal { unCReal :: [Frac] }
  
instance Num CReal where
  -- all methods undefinedcle [fromInteger n]

realPi :: CReal
realPi = undefined
