-- Zad 1. (Enigma)

import Data.Char (ord, chr)
import Data.List (elemIndex)
import Data.Maybe (fromJust)

data Rotor = Rotor { wiring   :: [Char]
                   , turnover :: [Char] }
    deriving(Show)

encode :: [Rotor] -> String -> String
encode [] s = s
encode rotors "" = ""
encode rotors (letter:rest) =
    foldl encodeOneRotor letter rotors : encode (rotateRotors rotors) rest
        where 
            encodeOneRotor c rotor = wiring rotor !! (ord c - ord 'A')

decode :: [Rotor] -> String -> String
decode [] s = s
decode rotors "" = ""
decode rotors (letter:rest) =
    foldr decodeOneRotor letter rotors : decode (rotateRotors rotors) rest
        where
            decodeOneRotor rotor c = chr (ord 'A' + fromJust (elemIndex c (wiring rotor)))

rotateRotors :: [Rotor] -> [Rotor]
rotateRotors [] = []
rotateRotors ((Rotor wiring turnover):rs) =
    let firstRotorRotated = Rotor (tail wiring ++ [head wiring]) turnover
    in 
        if head wiring `elem` turnover
        then firstRotorRotated : rotateRotors rs
        else firstRotorRotated : rs

rotors :: [Rotor]
rotors =
    [ Rotor "EKMFLGDQVZNTOWYHXUSPAIBRCJ" "Q"
    , Rotor "AJDKSIRUXBLHWTMCQGZNPYFVOE" "E"
    , Rotor "BDFHJLCPRTXVZNYEIWGAKMUSQO" "V"
    , Rotor "ESOVPZJAYQUIRHXLNFTGKDCMWB" "J"
    , Rotor "VZBRGITYUPSDNHLXAWMJQOFECK" "Z"
    , Rotor "JPGVOUMFYQBENHZRDKASXLICTW" "ZM"
    , Rotor "NZJHGRCXMYSWBOUFAIVLPEKQDT" "ZM"
    , Rotor "FKQHTLXOCBJSPDZRAMEWNIUYGV" "ZM" ]

rotors2 :: [Rotor]
rotors2 =
    [ Rotor "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "C"
    , Rotor "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "" ]

-- Zad 2 (unfold)

unfoldStream :: (seed -> (seed, val)) -> seed -> [val]
unfoldStream f s = let (newSeed, value) = f s
                   in value : unfoldStream f newSeed

-- Zad 3 (Pascal)

pascal :: [[Integer]]
pascal = unfoldStream (\x -> (nextRow x, x)) [1] where
  nextRow row = zipWith (+) (0 : row) (row ++ [0])

-- Zad 4 (generowanie drzew)

data Tree = Leaf | Node Tree Tree

instance Show Tree where
  show Leaf = "."
  show (Node l r) = "(" ++ show l ++ show r ++ ")"

trees :: [Tree]
trees = concatMap kNodesTrees [0..]

kNodesTrees :: Int -> [Tree]
kNodesTrees 0 = [Leaf]
kNodesTrees n = [Node left right |  leftSize <- [0..(n-1)],
                                    let rightSize = (n-1) - leftSize,
                                      left <- kNodesTrees leftSize,
                                      right <- kNodesTrees rightSize]

-- Zad 5 (lista dwukierunkowa)

maybeToType :: Maybe a -> a
maybeToType Nothing = error ""
maybeToType (Just x) = x

data DList a = DCons { val  :: a
                     , prev :: Maybe (DList a)
                     , next :: Maybe (DList a) }

toDList :: [a] -> Maybe (DList a)
toDList [] = Nothing
toDList xs = toDListHelper xs Nothing
  where toDListHelper [] _ = Nothing
        toDListHelper (val:next) prev =
          let thisNode = Just (DCons val prev (toDListHelper next thisNode)) in thisNode

bounce :: Int -> DList a -> a
bounce = go prev next where
  go dir anty 0 ds = val ds
  go dir anty n ds = case dir ds of
                       Just ds' -> go dir anty (n-1) ds'
                       Nothing  -> go anty dir n ds