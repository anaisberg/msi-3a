import Data.List
import Data.Maybe
import Control.Monad.State



myLast :: [a] -> Maybe a

myLast [] = Nothing
myLast [x] = Just x
myLast (hd:tl) = myLast tl


ggcd :: Int -> Int -> Int
ggcd x 0 = x
ggcd x y = ggcd y (mod x y)

g2cd x 0 = x
g2cd x y = g2cd y $ mod x y

g3cd x 0 = x
g3cd x y = g3cd y $ x `mod` y

table = [("Alice","Bureau 13"),("Bob","Bureau 14")]
bAlice = lookup "Alice" table
bMallory = lookup "Mallory" table

putStrLnM Nothing = putStrLn "Rien"
putStrLnM (Just x) = putStrLn x

-- putStrLnM $ Just "Rien"

{- How to make the distinction ? -}

putStrLnM2 Nothing = putStrLn "Rien."
putStrLnM2 (Just x) = putStrLn $ "Quelque chose. " ++ x


l = [1..]

{- genL :: [Integer] -> [Integer] -}
genL l = case l of
          [] -> genL [1]
          (hd:tl) -> hd:(genL $ (hd+1):tl)

{-- hd:tl ~ Elem(hd,tl) --}
auxx n = Elem(n,(auxx (n+1)))
l2p1 = auxx 1

l2 = let aux n = n:(aux $ n + 1) in aux 1


data MaListe a = Vide | Elem (a,MaListe a) deriving Show

tete l = case l of
           Vide -> Nothing
           Elem(x,_) -> Just x

tete2 Vide = Nothing
tete2 (Elem(x,_)) = Just x


data MaListe1 a = Vide1 | Elem1 (a, MaListe1 a) deriving (Show)

data MaListe2 a = Vide2 | Elem2 (a, MaListe2 a)
instance Show a => Show (MaListe2 a) where
  show Vide2 = "V"
  show (Elem2 (x,tl)) = "E(" ++ (show x) ++ "," ++ (show tl) ++ ")"




liste0 = Elem(0,Vide)
liste1 = Elem1(1,Vide1)
liste1p1 = Elem1(Vide,Vide1)
liste2 = Elem2(2,Vide2)
liste2p1 = Elem2(Vide,Vide2)

echo = getLine >>= putStrLn
echoInfini = getLine >>= \x -> do {putStrLn x; echoInfini}

isPrime n = foldl (&&) True $ fmap (\x -> n `mod` x /= 0) [2..(n-1)]

isPrime2 n = foldl (\x y -> x && n `mod` y /= 0) True [2..(n-1)] 

peel :: Monad m => m (m a) -> m a
peel v = v >>= (\x -> x >>= return)


extract :: Maybe Int -> Int
extract Nothing = error "pas bon"
extract (Just x) = x

