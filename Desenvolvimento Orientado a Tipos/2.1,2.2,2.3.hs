{-# LANGUAGE ExplicitForAll #-}

module Main where

-- Desenvolvimento Orientado a Tipos
-- 2.1 Tipos, quem são, onde vivem e o quê comem
-- https://www.youtube.com/watch?v=mKnkkAv3n2o&list=PLYItvall0TqKaY6qObQMlZ45Bo94xq9Ym&index=3

-- Bool: True False
-- Int: MININT .... -1 0 1 2 .... MAXINT
-- Char: A..Za..z
-- [Char]: "" "A" "B" ... "Aa" "Ba" ....

--soma :: Int -> Int -> Int
soma :: Num a => a -> a -> a
soma a b = a + b

-- 2.2 Classes de Tipos
-- https://www.youtube.com/watch?v=nxvYbMOcL4w&list=PLYItvall0TqKaY6qObQMlZ45Bo94xq9Ym&index=4
--soma :: Num a => a -> a -> a
--soma = (+)
--soma :: (Num a, Num b, Num c) => a -> b -> c
--soma x y = x + y

exemplo :: Float
exemplo = 4 + 3.14

-- Number + -
--   - Floating
--      - Float
--      - Double
--   - Integral
--      - Int
--      - Integer

-- 2.3 Polimorfismo Paramétrico
-- https://www.youtube.com/watch?v=k25cJJ371jY&list=PLYItvall0TqKaY6qObQMlZ45Bo94xq9Ym&index=5
-- [Int]
-- [Char]
-- [Float]
-- [[Int]]
len :: [a] -> Int
len [] = 0
len (_:xs) = 1 + len xs

first :: forall a. [a] -> a
first [] = error "A lista nao pode estar vazia"
first (x:_) = x

segredo :: forall a. Num a => a
segredo = 42

foo :: [Int] -> [Char] -> (Int, Char)
foo xs ys = (first xs, first ys)

bar :: Int -> Int
bar x = x + segredo

baz :: Float
baz = segredo

qux :: Double -> Double
qux x = x * segredo

main :: IO()
main = do
  let str = "Hello World!"
  --print $ sqrt str -- No instance for (Floating [Char]) arising from a use of `sqrt`
  print str

-- 2.1 Tipos, quem são, onde vivem e o quê comem
-- $ stack ghci Main.hs
-- λ> soma 3 4
-- 7
-- λ> soma 5 (-2)
-- 3
-- λ> soma 5.0 3.14
-- • No instance for (Fractional Int) arising from the literal `5.0`
-- • In the first argument of `soma`, namely `5.0`
--   In the expression: soma 5.0 3.14
--   In an equation for `it`: it = soma 5.0 3.14

-- λ> :type
-- λ> :t 4
-- 4 :: Num p => p
-- λ> :t 'c'
-- 'c' :: Char
-- λ> :t "Olá"
-- "Olá" :: [Char]
-- λ> :t soma
-- soma :: Int -> Int -> Int
-- λ> :t 4 :: Int
-- 4 :: Int :: Int
-- λ> x = (7 + 8) :: Int
-- λ> y = (7 + 8) :: Float
-- λ> :t x
-- x :: Int
-- λ> :t y
-- y :: Float
-- λ> soma x x
-- 30
-- λ> soma y y
-- <interactive>:15:6: error:
-- <interactive>:15:8: error:
-- • Couldn't match expected type `Int` with actual type `Float`
-- • In the first argument of `soma`, namely `y`
--   In the expression: soma y y
--   In an equation for `it`: it = soma y y

-- λ> :r
-- λ> x = (7 + 8) :: Int
-- λ> y = (7 + 8) :: Float
-- λ> soma x x
-- 30
-- λ> soma y y
-- 30.0
-- λ> :t soma
-- soma :: Num a => a -> a -> a

-- λ> soma x y
-- <interactive>:22:8: error:
-- • Couldn't match expected type `Int` with actual type `Float`
-- • In the first argument of `soma`, namely `y`
--   In the expression: soma x y
--   In an equation for `it`: it = soma x y

-- 2.2 Classes de Tipos
-- $ stack ghci Main.hs
-- λ> :info
-- λ> :i Num
-- type Num :: * -> Constraint
-- class Num a where
--  (+) :: a -> a -> a
--  (-) :: a -> a -> a
--  (*) :: a -> a -> a
--  negate :: a -> a
--  abs :: a -> a
--  signum :: a -> a
--  fromInteger :: Integer -> a
--  {-# MINIMAL (+), (*), abs, signum, fromInteger, (negate | (-)) #-}
        -- Defined in ‘GHC.Num’
-- instance Num Word -- Defined in ‘GHC.Num’
-- instance Num Integer -- Defined in ‘GHC.Num’
-- instance Num Int -- Defined in ‘GHC.Num’
-- instance Num Float -- Defined in ‘GHC.Float’
-- instance Num Double -- Defined in ‘GHC.Float’

-- λ> :t (+)
-- (+) :: Num a => a -> a -> a
-- λ> :t soma
-- soma :: Num a => a -> a -> a

-- λ> :r
-- Main.hs:19:12-15: error: …
--    • Couldn't match expected type ‘c’ with actual type ‘a’
--      ‘a’ is a rigid type variable bound by
--        the type signature for:
--          soma :: forall a b c. (Num a, Num b, Num c) => a -> b -> c
--        at /home/notecomm/phaskell/aula.hs:18:1-44
--      ‘c’ is a rigid type variable bound by
--        the type signature for:
--          soma :: forall a b c. (Num a, Num b, Num c) => a -> b -> c
--        at /home/notecomm/phaskell/aula.hs:18:1-44
--    • In the expression: x + y
--      In an equation for ‘soma’: soma x y = x + y
--    • Relevant bindings include
--        x :: a (bound at /home/notecomm/phaskell/aula.hs:19:6)
--        soma :: a -> b -> c (bound at /home/notecomm/phaskell/aula.hs:19:1)
--   |
-- Main.hs:19:15: error: …
--    • Couldn't match expected type ‘a’ with actual type ‘b’
--      ‘b’ is a rigid type variable bound by
--        the type signature for:
--          soma :: forall a b c. (Num a, Num b, Num c) => a -> b -> c
--        at /home/notecomm/phaskell/aula.hs:18:1-44
--      ‘a’ is a rigid type variable bound by
--        the type signature for:
--          soma :: forall a b c. (Num a, Num b, Num c) => a -> b -> c
--        at /home/notecomm/phaskell/aula.hs:18:1-44
--    • In the second argument of ‘(+)’, namely ‘y’
--      In the expression: x + y
--      In an equation for ‘soma’: soma x y = x + y
--    • Relevant bindings include
--        y :: b (bound at /home/notecomm/phaskell/aula.hs:19:8)
--        x :: a (bound at /home/notecomm/phaskell/aula.hs:19:6)
--        soma :: a -> b -> c (bound at /home/notecomm/phaskell/aula.hs:19:1)
-- -  |
-- Compilation failed.

-- λ> :t exemplo
-- exemplo :: Double
-- λ> :t exemplo
-- exemplo :: Float

-- λ> :i Ord
-- type Ord :: * -> Constraint
-- class Eq a => Ord a where
--  compare :: a -> a -> Ordering
--  (<) :: a -> a -> Bool
--  (<=) :: a -> a -> Bool
--  (>) :: a -> a -> Bool
--  (>=) :: a -> a -> Bool
--  max :: a -> a -> a
--  min :: a -> a -> a
--  {-# MINIMAL compare | (<=) #-}
        -- Defined in ‘GHC.Classes’
-- instance Ord a => Ord [a] -- Defined in ‘GHC.Classes’
-- instance Ord Word -- Defined in ‘GHC.Classes’
-- instance Ord Ordering -- Defined in ‘GHC.Classes’
-- instance Ord Int -- Defined in ‘GHC.Classes’
-- instance Ord Float -- Defined in ‘GHC.Classes’
-- instance Ord Double -- Defined in ‘GHC.Classes’
-- instance Ord Char -- Defined in ‘GHC.Classes’
-- instance Ord Bool -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f, Ord g, Ord h,
--          Ord i, Ord j, Ord k, Ord l, Ord m, Ord n, Ord o) =>
--         Ord (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f, Ord g, Ord h,
--          Ord i, Ord j, Ord k, Ord l, Ord m, Ord n) =>
--         Ord (a, b, c, d, e, f, g, h, i, j, k, l, m, n)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f, Ord g, Ord h,
--          Ord i, Ord j, Ord k, Ord l, Ord m) =>
--         Ord (a, b, c, d, e, f, g, h, i, j, k, l, m)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f, Ord g, Ord h,
--          Ord i, Ord j, Ord k, Ord l) =>
--         Ord (a, b, c, d, e, f, g, h, i, j, k, l)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f, Ord g, Ord h,
--          Ord i, Ord j, Ord k) =>
--         Ord (a, b, c, d, e, f, g, h, i, j, k)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f, Ord g, Ord h,
--          Ord i, Ord j) =>
--         Ord (a, b, c, d, e, f, g, h, i, j)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f, Ord g, Ord h,
--          Ord i) =>
--         Ord (a, b, c, d, e, f, g, h, i)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f, Ord g,
--          Ord h) =>
--         Ord (a, b, c, d, e, f, g, h)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f, Ord g) =>
--         Ord (a, b, c, d, e, f, g)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e, Ord f) =>
--         Ord (a, b, c, d, e, f)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d, Ord e) => Ord (a, b, c, d, e)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c, Ord d) => Ord (a, b, c, d)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b, Ord c) => Ord (a, b, c)
  -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b) => Ord (a, b) -- Defined in ‘GHC.Classes’
-- instance Ord () -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b) => Ord (Either a b)
  -- Defined in ‘Data.Either’
-- instance Ord a => Ord (Maybe a) -- Defined in ‘GHC.Maybe’
-- instance Ord Integer
  -- Defined in ‘integer-gmp-1.0.2.0:GHC.Integer.Type’

-- λ> :i Eq
-- type Eq :: * -> Constraint
-- class Eq a where
--  (==) :: a -> a -> Bool
--  (/=) :: a -> a -> Bool
--  {-# MINIMAL (==) | (/=) #-}
        -- Defined in ‘GHC.Classes’
-- instance Eq a => Eq [a] -- Defined in ‘GHC.Classes’
-- instance Eq Word -- Defined in ‘GHC.Classes’
-- instance Eq Ordering -- Defined in ‘GHC.Classes’
-- instance Eq Int -- Defined in ‘GHC.Classes’
-- instance Eq Float -- Defined in ‘GHC.Classes’
-- instance Eq Double -- Defined in ‘GHC.Classes’
-- instance Eq Char -- Defined in ‘GHC.Classes’
-- instance Eq Bool -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--          Eq j, Eq k, Eq l, Eq m, Eq n, Eq o) =>
--         Eq (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--          Eq j, Eq k, Eq l, Eq m, Eq n) =>
--         Eq (a, b, c, d, e, f, g, h, i, j, k, l, m, n)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--          Eq j, Eq k, Eq l, Eq m) =>
--         Eq (a, b, c, d, e, f, g, h, i, j, k, l, m)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--          Eq j, Eq k, Eq l) =>
--         Eq (a, b, c, d, e, f, g, h, i, j, k, l)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--          Eq j, Eq k) =>
--         Eq (a, b, c, d, e, f, g, h, i, j, k)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
--          Eq j) =>
--         Eq (a, b, c, d, e, f, g, h, i, j)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i) =>
--         Eq (a, b, c, d, e, f, g, h, i)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h) =>
--         Eq (a, b, c, d, e, f, g, h)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g) =>
--         Eq (a, b, c, d, e, f, g)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f) =>
--         Eq (a, b, c, d, e, f)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d, Eq e) => Eq (a, b, c, d, e)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c, Eq d) => Eq (a, b, c, d)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b, Eq c) => Eq (a, b, c)
  -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b) => Eq (a, b) -- Defined in ‘GHC.Classes’
-- instance Eq () -- Defined in ‘GHC.Classes’
-- instance (Eq a, Eq b) => Eq (Either a b)
  -- Defined in ‘Data.Either’
-- instance Eq a => Eq (Maybe a) -- Defined in ‘GHC.Maybe’
-- instance Eq Integer
  -- Defined in ‘integer-gmp-1.0.2.0:GHC.Integer.Type’

-- 2.3 Polimorfismo Paramétrico
-- $ stack ghci Main.hs
-- λ> :t len
-- len :: [a] -> Int
-- λ> len [1, 2, 3, 4]
-- 4
-- λ> len "Ola mundo!"
-- 10
-- λ> len ["Ola mundo!", "Como vai", "E ai?"]
-- 3

-- λ> print segredo
-- <interactive>:5:7: error: Variable not in scope: segredo
-- λ> :r
-- λ> print segredo
-- 42
-- λ> print (segredo :: Int)
-- 42
-- λ> print (segredo :: Float)
-- 42.0

-- λ> foo [1, 2, 3] "Ola"
-- (1, 'O')
