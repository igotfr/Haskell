{-# LANGUAGE TypeApplications,
             ScopedTypeVariables,
             AllowAmbiguousTypes,
             MultiParamTypeClasses,
             FlexibleInstances,
             LambdaCase #-}

module Main where

-- 2.6 Visible Type Applications
class Tipavel a where
  nomeTipo0 :: String

  nomeTipo :: a -> String
  nomeTipo _ = nomeTipo0 @a

instance Tipavel Int where
  nomeTipo0 = "É um Int"
  --nomeTipo0 = "Int"

instance Tipavel Integer where
  nomeTipo0 = "Integer"

instance Tipavel Float where
  nomeTipo0 = "É um Float"

instance Tipavel Double where
  nomeTipo0 = "É um Double"

instance Tipavel Char where
  nomeTipo0 = "É um caractere"

--               Tipavel a -> a -> Bool
isTipoInteiro :: Tipavel a => a -> Bool
isTipoInteiro x = nomeTipo x `elem` ["Int", "Integer"]

teste :: Tipavel a => Ord a => Ord b => Ord c => Ord d => a -> b -> c -> d -> ()
teste = undefined

{-
data Grama
data Kilograma
data Onça
data Libra
data Pedra

class Unidade u where
  sigla :: String
  fator :: Floating a => a

instance Unidade Grama where
  sigla = "g"
  fator = 1.0

instance Unidade Kilograma where
  sigla = "kg"
  fator = 1000

instance Unidade Onça where
  sigla = "oz"
  fator = 28.35

instance Unidade Libra where
  sigla = "lb"
  fator = 453.59

instance Unidade Pedra where
  sigla = "st"
  fator = 14 * fator @Libra

class Conv a b where
  conv :: Floating f => f -> f

instance (Unidade a, Unidade b) => Conv a b where
  conv x = x * fator @a / fator @b

convOnçaParaLibra :: Floating f => f -> f
convOnçaParaLibra = conv @Onça @Libra
--convOnçaParaLibra x = conv @Onça @Libra x
-}

data Unidade = Grama | Kilograma | Onça | Libra | Pedra

fator :: Floating f => Unidade -> f
fator = \case
  Grama     -> 1
  Kilograma -> 1000
  Onça      -> 28.35
  Libra     -> 453.59
  Pedra     -> 14 * fator Libra

sigla :: Unidade -> String
sigla = \case
  Grama     -> "g"
  Kilograma -> "kg"
  Onça      -> "oz"
  Libra     -> "lb"
  Pedra     -> "st"

conv :: Floating f => Unidade -> Unidade -> f -> f
conv u0 u1 x = x * fator u0 / fator u1

convOnçaParaLibra :: Floating f => f -> f
convOnçaParaLibra = conv Onça Libra

-- conv @UnidadeOrigem @UnidadeDestino valor
-- conv UnidadeOrigem UnidadeDestino valor

main :: IO()
main = do
  let str = "Hello World!"
  --print $ sqrt str -- No instance for (Floating [Char]) arising from a use of `sqrt`
  print str

-- λ> undefined
-- *** Exception: Prelude.undefined
-- CallStack (from HasCallStack):
--  error, called at libraries/base/GHC/Err.hs:80:14 in base:GHC.Err
--  undefined, called at <interactive>:8:1 in interactive:Ghci1
-- λ> nomeTipo (undefined :: Int)
-- "\201 um Int"
-- λ> nomeTipo (undefined :: Char)
-- "\201 um caractere"

-- λ> nomeTipo0
-- <interactive>:18:1-9: error:
--    • Ambiguous type variable ‘a0’ arising from a use of ‘nomeTipo0’
--      prevents the constraint ‘(Tipavel a0)’ from being solved.
--      Probable fix: use a type annotation to specify what ‘a0’ should be.
--      These potential instances exist:
--        instance [safe] Tipavel Integer
          -- Defined at /home/notecomm/phaskell/visible_type_applications.hs:18:10
--        instance [safe] Tipavel Char
          -- Defined at /home/notecomm/phaskell/visible_type_applications.hs:27:10
--        instance [safe] Tipavel Double
          -- Defined at /home/notecomm/phaskell/visible_type_applications.hs:24:10
--        ...plus two others
--        (use -fprint-potential-instances to see them all)
--    • In the expression: nomeTipo0
--      In an equation for ‘it’: it = nomeTipo0

-- λ> :set -XTypeApplications
-- λ> nomeTipo0 @Char
-- "\201 um caractere"

-- λ> :r
-- λ> conv @Onça Libra 13
-- 0.8125179126523954
-- λ> :r
-- λ> convOnçaParaLibra 13
-- 0.8125179126523954

-- λ> :r
-- λ>  convOnçaParaLibra 13
-- 0.8125179126523954
-- λ> conv Kilograma Pedra 42
-- 6.613902422892922
