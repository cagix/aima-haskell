{-# LANGUAGE ExistentialQuantification #-}

module AI.Util.Table
  ( Showable(..)
  , printTable
  ) where

-- |A Showable is simply a box containing a value which is an instance of 'Show'.
data Showable = forall a. Show a => SB a

-- |To convert a 'Showable' to a 'String', just call 'show' on its contents.
instance Show Showable where
  show (SB x) = show x

-- |Print a table of data to stdout. You must supply the column width (number
--  of chars) and a list of row and column names.
printTable :: Int           -- ^ Column width
           -> [[Showable]]  -- ^ Data
           -> [String]      -- ^ Column names (including the 0th column)
           -> [String]      -- ^ Row names
           -> IO ()
printTable pad xs header rownames = do
    let horzLines = replicate (length header) (replicate pad '-')
    printRow pad '+' horzLines
    printRow pad '|' header
    printRow pad '+' horzLines
    let rows = zipWith (:) rownames (map (map show) xs)
    mapM_ (printRow pad '|') rows
    printRow pad '+' horzLines

-- |Print a single row of a table, padding each cell to the required size
--  and inserting the specified separator between columns.
printRow :: Int -> Char -> [String] -> IO ()
printRow pad sep xs = do
    let ys = map (trim pad) xs
    putChar sep
    mapM_ printCell ys
    putStrLn ""
    where
        trim pad str = let n = length str
                           m = max 0 (pad - n)
                        in take pad str ++ replicate m ' '
        printCell cl = putStr cl >> putChar sep