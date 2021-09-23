-- faire un arbre
-- définition du type
data Tree a = Empty | Node(a, Tree a, Tree a)

-- fonctions de base sur arbre

-- hauteur
hauteur :: Tree a -> Int
hauteur t = case t of
    Empty -> 0
    Node(x, g, d) -> 1 + max (hauteur g) (hauteur d)
    

-- taille, nombre de noeuds
size :: Tree a -> Int
size t = case t of
    Empty -> 0
    Node (_, g, d) -> 1 + (size g) + (size d) 
    
-- parcours infixe : fils gauche - noeud - fils droit
infixe :: Tree a -> [a]
infixe t = case t of 
    Empty -> []
    Node (x, g, d) -> (infixe g) ++ [x] ++ (infixe d)

-- parcous prefixe : valeur - fils gauche - fils droit
prefixe :: Tree a -> [a]
prefixe t = case t of
    Empty -> []
    Node (x, g, d) -> [x] ++ (prefixe g) ++ (prefixe d)

-- parcous postfixe : fils gauche - fils droit - valeur
postfixe :: Tree a -> [a]
postfixe t = case t of
    Empty -> []
    Node (x, g, d) -> (prefixe g) ++ (prefixe d) ++ [x]