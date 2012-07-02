module AI.Util.Util where

import qualified Data.List as L
import qualified Data.Ord as O
import qualified System.Random as R

-----------------------
-- Numeric Functions --
-----------------------

-- | Positive infinity.
positiveInfinity :: Fractional a => a
positiveInfinity = 1/0

-- | Negative infinity.
negativeInfinity :: Fractional a => a
negativeInfinity = -1/0

--------------------
-- List Functions --
--------------------

-- |Update the element at position i in a list.
insert :: Int -> a -> [a] -> [a]
insert 0 n (_:xs) = n : xs
insert i n (x:xs) = x : insert (i-1) n xs

-- |Given a list x :: [a], return a new list y :: [(Int,a)] which pairs every
--  element of the list with its position.
enumerate :: [a] -> [(Int,a)]
enumerate = zip [0..]

-- | Return the element of the target list that maximises a function.
argMax :: (Ord b) => [a] -> (a -> b) -> a
argMax xs f = fst $ L.maximumBy (O.comparing snd) $ zip xs (map f xs)

-- | Return the element of a list that minimises a function.
argMin :: (Ord b) => [a] -> (a -> b) -> a
argMin xs f = fst $ L.minimumBy (O.comparing snd) $ zip xs (map f xs)

-- | Create a function from a list of (argument, value) pairs.
listToFunction :: (Eq a) => [(a,b)] -> a -> b
listToFunction xs x = case lookup x xs of
    Nothing -> error "Argument not found in list -- LISTTOFUNCTION"
    Just y  -> y

--------------------
-- Random Numbers -- 
--------------------

-- | Choose a random element from a list
randomChoiceIO :: [a] -> IO a
randomChoiceIO [] = error "Empty list -- RANDOMCHOICEIO"
randomChoiceIO xs = do
    n <- R.randomRIO (0,length xs - 1)
    return (xs !! n)

