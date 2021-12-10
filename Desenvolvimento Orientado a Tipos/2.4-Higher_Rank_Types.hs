{-# LANGUAGE ExplicitForAll,
             RankNTypes #-}

module Main where

-- 2.4 Higher Rank Types
first :: forall a. [a] -> a
first [] = error "A lista nao pode estar vazia"
first (x:_) = x

foo :: forall b c. [b] -> [c] -> (b, c)
foo xs ys = (first xs, first ys)

aplicaEDevolvePar :: forall b c. (Num b, Num c) => (forall a. Num a => a -> a) -> b -> c -> (b, c)
--aplicaEDevolvePar :: forall b c. (Num b, Num c) => (forall a. Num a => (forall d. d -> d) -> a -> a) -> b -> c -> (b, c)
aplicaEDevolvePar f x y = (f x, f y)

doIt :: (Int, Float)
doIt = aplicaEDevolvePar (^2) 42 3.1415

--concatena :: (Show a, Show b, Show c) => (a -> String) -> b -> c -> String
concatena :: (Show b, Show c) => (forall a. Show a => a -> String) -> b -> c -> String
--concatena :: forall b c a. (Show b, Show c) => (a -> String) -> b -> c -> String
concatena f x y = f x ++ " - " ++ f y
--concatena toString x y = toString b ++ " - " ++ toString y

chamaConcatena :: String
chamaConcatena = concatena (\x -> "<" ++ show x ++ ">") "senha" 12345

main :: IO()
main = do
  let str = "Hello World!"
  --print $ sqrt str -- No instance for (Floating [Char]) arising from a use of `sqrt`
  print str

-- 2.4 Higher Rank Types
-- $ stack ghci Main.hs
-- higher_rank_types.hs:7:8-39: error: …
--    • Couldn't match type ‘Int’ with ‘Float’
--      Expected type: (Int, Float)
--        Actual type: (Int, Int)
--    • In the expression: aplicaEDevolvePar (^ 2) 42 3.1415
--      In an equation for ‘doIt’: doIt = aplicaEDevolvePar (^ 2) 42 3.1415
--  |
-- Compilation failed.
-- λ> :t aplicaEDevolvePar
-- aplicaEDevolvePar :: (t -> b) -> t -> t -> (b, b)
-- λ> doIt
-- (1764,9.869022)

-- λ> :i Show
-- type Show :: * -> Constraint
-- class Show a where
--  showsPrec :: Int -> a -> ShowS
--  show :: a -> String
--  showList :: [a] -> ShowS
--  {-# MINIMAL showsPrec | show #-}
      -- Defined in ‘GHC.Show’
-- instance (Show a, Show b) => Show (Either a b)
  -- Defined in ‘Data.Either’
-- instance Show a => Show [a] -- Defined in ‘GHC.Show’
-- instance Show Word -- Defined in ‘GHC.Show’
-- instance Show GHC.Types.RuntimeRep -- Defined in ‘GHC.Show’
-- instance Show Ordering -- Defined in ‘GHC.Show’
-- instance Show a => Show (Maybe a) -- Defined in ‘GHC.Show’
-- instance Show Integer -- Defined in ‘GHC.Show’
-- instance Show Int -- Defined in ‘GHC.Show’
-- instance Show Char -- Defined in ‘GHC.Show’
-- instance Show Bool -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f, Show g,
--          Show h, Show i, Show j, Show k, Show l, Show m, Show n, Show o) =>
--         Show (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f, Show g,
--          Show h, Show i, Show j, Show k, Show l, Show m, Show n) =>
--         Show (a, b, c, d, e, f, g, h, i, j, k, l, m, n)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f, Show g,
--          Show h, Show i, Show j, Show k, Show l, Show m) =>
--         Show (a, b, c, d, e, f, g, h, i, j, k, l, m)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f, Show g,
--          Show h, Show i, Show j, Show k, Show l) =>
--         Show (a, b, c, d, e, f, g, h, i, j, k, l)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f, Show g,
--          Show h, Show i, Show j, Show k) =>
--         Show (a, b, c, d, e, f, g, h, i, j, k)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f, Show g,
--          Show h, Show i, Show j) =>
--         Show (a, b, c, d, e, f, g, h, i, j)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f, Show g,
--          Show h, Show i) =>
--         Show (a, b, c, d, e, f, g, h, i)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f, Show g,
--          Show h) =>
--         Show (a, b, c, d, e, f, g, h)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f,
--          Show g) =>
--         Show (a, b, c, d, e, f, g)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e, Show f) =>
--         Show (a, b, c, d, e, f)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d, Show e) =>
--         Show (a, b, c, d, e)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c, Show d) => Show (a, b, c, d)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b, Show c) => Show (a, b, c)
  -- Defined in ‘GHC.Show’
-- instance (Show a, Show b) => Show (a, b) -- Defined in ‘GHC.Show’
-- instance Show () -- Defined in ‘GHC.Show’
-- instance Show Float -- Defined in ‘GHC.Float’
-- instance Show Double -- Defined in ‘GHC.Float’

-- λ> show 13
-- "13"
-- λ> show (13 :: Float)
-- "13.0"
-- λ> show "Oba"
-- "\"Oba\""

-- λ> chamaConcatena
-- "<\"senha\"> - <12345>"
