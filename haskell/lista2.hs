module Lista2 where

-- Zad 1. (Enigma) nie dziala

data Rotor = Rotor { wiring   :: [Char]
                   , turnover :: [Char] }
  deriving(Show)

rotateRotor :: Rotor -> (Rotor, Bool)
rotateRotor (Rotor (w:tail) turnover) =
  (Rotor (tail ++ [w]) turnover, w `elem` turnover)

rotorUpdater :: [Rotor] -> [[Rotor]]
rotorUpdater initialRotors = unfoldStream getNextState (initialRotors, True) where
  getNextState ([], _) = (([], False), [])
  getNextState (rotors, shouldRotate) = if shouldRotate
    then
      let (updatedRotor, shouldRotateNext) = rotateRotor (head rotors) in
        let finalRotors = updatedRotor : snd (getNextState (tail rotors, shouldRotateNext)) in
          ((finalRotors, True), rotors)
    else
      ((rotors, False), rotors)

charToNumber :: Char -> Int
charToNumber c = fromEnum c - fromEnum 'A' + 1

-- numberToChar :: Int -> Char
-- numberToChar n = toEnum (n + fromEnum 'A' - 1)

findIndex :: Char -> String -> Int
findIndex _ [] = error "Couldn't find given letter!"
findIndex x (y:ys)
    | x == y    = 0
    | otherwise = findIndex x ys + 1

encode :: [Rotor] -> String -> String
encode rotors = encodeHelper (rotorUpdater rotors)
  where
    encodeHelper :: [[Rotor]] -> String -> String
    encodeHelper _ "" = ""
    encodeHelper rotorStream (letter:tail) =
      let ([rotors], remainingStream) = splitAt 1 rotorStream in
        encodeLetter rotors letter : encodeHelper remainingStream tail

    encodeLetter :: [Rotor] -> Char -> Char
    encodeLetter [] letter = letter
    encodeLetter (rotor:rest) letter =
      let letterIndex = charToNumber letter
          newLetterIndex = (letterIndex - 1) -- `mod` 26
          encodedChar = wiring rotor !! newLetterIndex
      in encodeLetter rest encodedChar

decode :: [Rotor] -> String -> String
decode rotor s = s

rotors1 :: [Rotor]
rotors1 =
  [ Rotor "EKMFLGDQVZNTOWYHXUSPAIBRCJ" "Q"
  , Rotor "AJDKSIRUXBLHWTMCQGZNPYFVOE" "E"
  , Rotor "BDFHJLCPRTXVZNYEIWGAKMUSQO" "V"
  , Rotor "ESOVPZJAYQUIRHXLNFTGKDCMWB" "J"
  , Rotor "VZBRGITYUPSDNHLXAWMJQOFECK" "Z"
  , Rotor "JPGVOUMFYQBENHZRDKASXLICTW" "ZM"
  , Rotor "NZJHGRCXMYSWBOUFAIVLPEKQDT" "ZM"
  , Rotor "FKQHTLXOCBJSPDZRAMEWNIUYGV" "ZM" 
  ]

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

-- Zad 5 (lista dwukierunkowa) ???

data DList a = DCons { val  :: a
                     , prev :: Maybe (DList a)
                     , next :: Maybe (DList a) }

toDList :: [a] -> Maybe (DList a)
toDList = undefined

bounce :: Int -> DList a -> a
bounce = go prev next where
  go dir anty 0 ds = val ds
  go dir anty n ds = case dir ds of
                       Just ds' -> go dir anty (n-1) ds'
                       Nothing  -> go anty dir n ds