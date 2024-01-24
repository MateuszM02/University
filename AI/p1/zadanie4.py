def opt_dist(bits, D):
    n = len(bits)  # długość listy bitów
    min_ops = float('inf')  # minimalna liczba operacji potrzebna do uzyskania oczekiwanego wyniku
    for startPos in range(n - D + 1):  # iterujemy po możliwych pozycjach bloku o długości D (czyli 0-(D-1), 1-D,2-(D+1),...)
        ops = 0  # liczba operacji dla aktualnej pozycji bloku
        for i in range(startPos, startPos + D - 1):  # sprawdzamy bity wewnątrz bloku
            if bits[i] == 0:  # jeśli bit jest równy 0, zwiększamy liczbę operacji
                ops += 1
        #for i in range(i - 1, max(-1, i - D), -1):  # sprawdzamy bity przed blokiem
        for i in range(0, startPos):  # sprawdzamy bity przed blokiem
            if bits[i] == 1:  # jeśli bit jest równy 1, zwiększamy liczbę operacji
                ops += 1
        for i in range(startPos + D, n):  # sprawdzamy bity za blokiem
            if bits[i] == 1:  # jeśli bit jest równy 1, zwiększamy liczbę operacji
                ops += 1
        for i in range(min(n, startPos + 2*D - 1), startPos + D - 1, -1):  # sprawdzamy bity przed i za blokiem
            if bits[i - 1] == 0:  # jeśli bit jest równy 0, zwiększamy liczbę operacji
                ops += 1
        min_ops = min(min_ops, ops)  # aktualizujemy minimalną liczbę operacji
    return min_ops  # zwracamy minimalną liczbę operacji

# testy poprawnosci funkcji

import unittest

class TestOptDist(unittest.TestCase):
    
    def test_D1(self):
        D = 1
        expected_result = 0
        bits = [1]
        result = opt_dist(bits, D)
        self.assertEqual(result, expected_result)

    def test_D2a(self):
        D = 2
        expected_result = 1
        bits = [0, 0, 0, 0, 1]
        # 1.   [0, 0, 0, 1, 1]
        result = opt_dist(bits, D)
        self.assertEqual(result, expected_result)

    def test_D2b(self):
        D = 2
        expected_result = 3
        bits = [1, 1, 1, 1, 1]
        # 1.   [1, 1, 0, 1, 1]
        # 2.   [1, 1, 0, 0, 1]
        # 3.   [1, 1, 0, 0, 0]
        result = opt_dist(bits, D)
        self.assertEqual(result, expected_result)

    def test_D2c(self):
        D = 2
        expected_result = 3
        bits = [1, 0, 1, 0, 1]
        # 1.   [1, 1, 1, 0, 1]
        # 2.   [1, 1, 0, 0, 1]
        # 3.   [1, 1, 0, 0, 0]
        result = opt_dist(bits, D)
        self.assertEqual(result, expected_result)

    def test_D3a(self):
        D = 3
        expected_result = 4
        bits = [0, 1, 0, 0, 1, 0, 0, 1]
        # 1.   [1, 1, 0, 0, 1, 0, 0, 1]
        # 2.   [1, 1, 1, 0, 1, 0, 0, 1]
        # 3.   [1, 1, 1, 0, 0, 0, 0, 1]
        # 4.   [1, 1, 1, 0, 0, 0, 0, 0]
        result = opt_dist(bits, D)
        self.assertEqual(result, expected_result)

    def test_D3b(self):
        D = 3
        expected_result = 4
        bits = [0, 1, 1, 0, 1, 0, 0, 1, 0, 1]
        # 1.   [0, 1, 1, 1, 1, 0, 0, 1, 0, 1]
        # 2.   [0, 1, 1, 1, 0, 0, 0, 1, 0, 1]
        # 3.   [0, 1, 1, 1, 0, 0, 0, 0, 0, 1]
        # 4.   [0, 1, 1, 1, 0, 0, 0, 0, 0, 0]
        result = opt_dist(bits, D)
        self.assertEqual(result, expected_result)

if __name__ == '__main__':
    unittest.main()