module Main where

-- 2.5 Polimorfismo Ad hoc
class Tipavel a where
  nomeTipo :: a -> String

instance Tipavel Int where
  nomeTipo _ = "É um Int"
  --nomeTipo _ = "Int"

instance Tipavel Integer where
  nomeTipo _ = "Integer"

instance Tipavel Float where
  nomeTipo _ = "É um Float"

instance Tipavel Double where
  nomeTipo _ = "É um Double"

instance Tipavel Char where
  nomeTipo _ = "É um caractere"

--               Tipavel a -> a -> Bool
isTipoInteiro :: Tipavel a => a -> Bool
isTipoInteiro x = nomeTipo x `elem` ["Int", "Integer"]

teste :: Tipavel a => Ord a => Ord b => Ord c => Ord d => a -> b -> c -> d -> ()
teste = undefined

main :: IO()
main = do
  let str = "Hello World!"
  --print $ sqrt str -- No instance for (Floating [Char]) arising from a use of `sqrt`
  print str

-- stach ghci
-- λ> nomeTipo (5.0 :: Float)
-- "\201 um Float"
-- λ> putStrLn $ nomeTipo (5.0 :: Float)
-- É um Float
-- λ> putStrLn $ nomeTipo (5.0 :: Double)
-- É um Double
-- λ> putStrLn $ nomeTipo (1)
-- É um Double
-- λ> putStrLn $ nomeTipo (1 :: Int)
-- É um Int
-- λ> putStrLn $ nomeTipo 'a'
-- É um caractere
-- λ> :r
-- λ> isTipoInteiro 5
-- True
-- λ> isTipoInteiro 5.0
-- False
-- λ> isTipoInteiro 'v'
-- False
-- λ> isTipoInteiro (3 :: Integer)
-- True
-- λ> isTipoInteiro (3 :: Int)
-- False
-- λ> isTipoInteiro (3 :: Float)
-- False
-- λ> :r
-- λ> :t teste
-- teste :: (Ord a, Ord b, Ord c, Ord d) => a -> b -> c -> d -> ()
