import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from random import choice

def CreateSquareTable(size, value, f = None):
    if f is None:
        return [[value for _ in range(size)] for _ in range(size)]
    return [[f(value) for _ in range(size)] for _ in range(size)]

class GameOfLife:
    def __init__(self, n):
        self.n = n
        self.board = CreateSquareTable(self.n, [0, 1], choice) # losowa plansza n x n
        
    def CountAliveNeighbours(self, x, y):
        min_x, max_x = max(0, x-1), min(self.n-1, x+1)
        min_y, max_y = max(0, y-1), min(self.n-1, y+1)
        alive = 0

        for x1 in range(min_x, max_x+1):
            for y1 in range(min_y, max_y+1):
                if x1 != x or y1 != y: # pole jest istniejacym sasiadem (x, y), sprawdz, czy jest zywe
                    alive += self.board[y1][x1]
        return alive

    def next(self, _):
        new_board = CreateSquareTable(self.n, 0)
        for x in range(self.n):
            for y in range(self.n):
                alive_neighs = self.CountAliveNeighbours(x, y)
                if self.board[y][x]: # komorka dotychczas zywa
                    if 2 <= alive_neighs <= 3: # pozostaje zywa
                        new_board[y][x] = 1
                elif alive_neighs == 3: # komorka dotychczas martwa ozywa
                    new_board[y][x] = 1
        self.board = new_board
        
        mat.set_data(self.board)
        return [mat]

game = GameOfLife(16)
figure, ax = plt.subplots()
mat = ax.matshow(game.board)
animation = FuncAnimation(figure, game.next, interval=200)
plt.show()