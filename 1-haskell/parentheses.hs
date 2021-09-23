import Text.Parsec
import Control.Arrow

type Parser a = Parsec String () a

{- les fonctions d'incrément, avec détection de mauvais parenthésage  ---
   on devient mal parenthésé lorsqu'on a lu trop de parenthèses droites -}
leftIncr (x,y,b) = (x+1,y,b)
rightIncr (x,y,b) = (x,y+1,b && y<x)


-- on parse une parenthèse ouvrante : on incrémente le compteur
lpar :: Parser ((Int,Int,Bool) -> (Int,Int,Bool))
lpar = do
  char '('
  return leftIncr

rpar :: Parser ((Int,Int,Bool) -> (Int,Int,Bool))
rpar = do
  char ')'
  return rightIncr

-- on combine les parseurs, maintenant

counting = many (lpar <|> rpar)


{- on définit la fonction qui lance le parsing, analyse le résultat
 - et compose toutes les fonctions obtenues ensuite -}

reverseAnalyse s = case parse counting "" s of
  Left e -> putStrLn $ "Il y a eu une erreur " ++ (show e)
  Right list -> putStrLn $ show $ (foldl (.) (\x -> x) list) (0,0,True)

{- ça applique les fonctions de parsing à l'envers à cause de la composition (.)
 - qui se fait dans le mauvais sens. C'était volontaire :-) Tester, par exemple
- reverseAnalyse ")((" ou reverseAnalyse "(()" pour s'en convaincre -}


{- On reprend donc avec l'opérateur >>> de Control.Arrow, plutôt que la composition
 - Nb : on aurait pu aussi faire (reverse list) et continuer à utiliser (.) -}


directAnalyse s = case parse counting "" s of
  Left e -> putStrLn $ "Il y a eu une erreur " ++ (show e)
  Right list -> putStrLn $ show $ (foldl (>>>) (\x -> x) list) (0,0,True)

{- NB : on ferait bien mieux d'utiliser un état, et donc d'utiliser le type ParsecT, plus à fond que de produire des fonctions que l'on combine à la main ensuite. Mais c'est pour plus tard -}



{- OPTION PLUS SIMPLE -}

lpar2 :: Parser (Int,Int)
lpar2 = do
  char '('
  return (1,0)


rpar2 :: Parser (Int,Int)
rpar2 = do
  char ')'
  return (0,1)

onepar = lpar2 <|> rpar2

chain :: Parser [(Int,Int)]

chain = many onepar

reducer (x,y,b) (u,v) = (x+u, y+v, b && x+u >= y+v)

analyse s = (parse chain "" s) >>= \l -> return $ foldl reducer (0,0,True) l


