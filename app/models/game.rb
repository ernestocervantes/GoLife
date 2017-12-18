class Game

	
	attr_accessor :grid, :cols, :rows


	def initialize(cols, rows)
		@cols = cols
		@rows = rows
		@grid = load_game_grid
	end

	def load(cells)
		cells.each { |y, x| grid[y][x] = 1 }
	end

	def neighbors_counter(y, x)
		neighbors(y, x).count { |cell| cell == 1 }
	end

	def execute
		new_game_grid = load_game_grid
		grid.each_with_index do |row, y|
			row.each_with_index do |cell, x|
				counter = neighbors_counter(y, x)
				new_game_grid[y][x] = begin
					if cell.zero?
						[3].include?(counter) ? 1 : 0
					else
						[2, 3].include?(counter) ? 1 : 0
					end
				end
			end
		end
		return @grid = new_game_grid
	end

	def neighbors(y, x)
		(-1..1).inject [] do |values, f|
			(-1..1).each do |g|
				unless f == 0 and g == 0
					i = y + f
					j = x + g
					i = 0 unless i < rows
					j = 0 unless j < cols
					values << grid[i][j]
				end
			end
			values
		end
	end

	def load_game_grid
		Array.new(rows) { Array.new(cols, 0) }
	end
end