-- zadanie 1

factorial :: Integer -> Integer
factorial 1 = 1
factorial x = factorial (x-1) * x

-- zadanie 2

ack :: Integer -> Integer -> Integer -> Integer
ack m n 0 = m + n
ack m 0 1 = 0
ack m 0 2 = 1
ack m 0 p = m
ack m n p = ack m (ack m (n-1) p) (p-1)

-- zadanie 3

removeVowels :: String -> String
removeVowels = filter (`notElem` "aeiouyAEIOUY")

-- zadanie 4

everyOtherIn :: [a] -> [a]
everyOtherIn [] = []
everyOtherIn (x:xs) = x : everyOtherEx xs

everyOtherEx :: [a] -> [a]
everyOtherEx [] = []
everyOtherEx (_:xs) = everyOtherIn xs

merge :: [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) = x : y : merge xs ys

-- zadanie 5

transpose :: [[a]] -> [[a]]
transpose [] = []
transpose ([]:_) = []
transpose x = map head x : transpose (map tail x)

-- zadanie 6

primes :: [Integer]
primes = sieve [2..]
  where
    sieve (p:xs) = p : sieve [x | x <- xs, x `mod` p > 0]

primeFactors :: Integer -> [Integer]
primeFactors number = factorize number primes 
  where
    factorize 1 _ = []
    factorize x (prime:primestream)
      | x < prime * prime = [x]
      | x `mod` prime == 0 = prime : factorize (x `div` prime) (prime:primestream)
      | otherwise = factorize x primestream
