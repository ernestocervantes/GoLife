# /usr/env/bin python
# encoding:utf-8


from __future__ import print_function

import copy
import random
import itertools
import time
import os

UNIX = True

clear = lambda: os.system('clear') if UNIX else os.system('cls')

class GameOfLife(object):
	
	def __init__(self, rows, cols):

		self.rows = rows
		self.cols = cols

		row_life = lambda: [random.randint(0,1) for n in range(self.cols)]
		self.game = [row_life() for n in range(self.rows)]

		self.life = 1
		self.dead =1

	def __str__(self):

		table = ''
		for row in self.game:
			for cell in row:
				table += '▓ ' if cell else '░ '
			table += '\n\n'

		#table += "life: {0} dead: {1}".format(self.life, self.dead)
		return table

	def eval(self, row, col):

		distance = list(set(itertools.permutations([-1, -1, 1, 1, 0], 2)))
		into_table = lambda x, y: (x in range(self.rows) and y in range(self.cols))

		total = 0

		for f, g in distance:
			if into_table(f +  row, g + col):
				total += self.game[f +row][g + col]
		return total

	def test(self):

		game_test = copy.deepcopy(self.game)
		self.life = 0
		self.dead = 0

		for f in range(self.rows):
			for g in range(self.cols):
				total = self.eval(f,g)

				if (total < 2 or total > 3) and game_test[f][g]:
					game_test[f][g] = 0
					self.dead = 1
				elif total == 3 and not game_test[f][g]:
					game_test[f][g] = 1
					self.life = 1

		self.game = copy.deepcopy(game_test)

rows, cols = int(input("Rows : ")), int(input("Cols : "))

game = GameOfLife(rows, cols)

iterations = 0
while game.life > 0 or game.dead >0:
	try:
		clear()
		game.test()
		print(game)
		time.sleep(1)
		iterations += 1

	except KeyboardInterrupt:
		break

print("Total of: ", iterations," Iterations")
