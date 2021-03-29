const LIVING_CELL = 1
const DEAD_CELL = 0

var grid
var rng = RandomNumberGenerator.new()
var columns = 0
var rows = 0

func init(_rows, _columns):
	self.rows = _rows
	self.columns = _columns
	grid = []
	for y in range(rows):
		grid.append([])
		for _x in range(columns):
			grid[y].append(DEAD_CELL)

func get_grid():
	return grid


func count_living_neighbours(row, column) -> int:
	
	var neighbourhood = []
	neighbourhood.append([row - 1, column - 1])
	neighbourhood.append([row - 1, column])
	neighbourhood.append([row - 1, column + 1])
	neighbourhood.append([row, column + 1])
	neighbourhood.append([row + 1, column + 1])
	neighbourhood.append([row + 1, column])
	neighbourhood.append([row + 1, column - 1])
	neighbourhood.append([row, column - 1])	

	var living_neighbours = 0
	
	for i in range(neighbourhood.size()):
		var row_to_check = neighbourhood[i][0]
		var col_to_check = neighbourhood[i][1]
		if is_in_the_grid(row_to_check, col_to_check) and is_alive(row_to_check, col_to_check):
			living_neighbours += 1

	return living_neighbours


func is_in_the_grid(row, col):
	return row >= 0 and col >= 0 and row < grid.size() and col < grid[0].size()


func is_alive(row, col) -> bool:
	return grid[row][col] == LIVING_CELL


func is_dead(row, col) -> bool:
	return grid[row][col] == DEAD_CELL


func set_living_cell(y, x):
	grid[y][x] = LIVING_CELL


func populate(total):
	var count = 0
	while (count < total):
		rng.randomize()
		var y = rng.randi_range(0, self.rows - 1)	
		var x = rng.randi_range(0, self.columns - 1)
		if !is_alive(y, x):
			set_living_cell(y, x)
			count += 1


func compute_next_generation():
	
	var next_generation = []
	for y in range(self.rows):
		next_generation .append([])
		for _x in range(self.columns):
			next_generation [y].append(DEAD_CELL)
	
	for y in range(self.rows):
		for x in range(self.columns):
			if this_cell_is_alive_and_has_less_than_two_neighbours(y, x):
				next_generation[y][x] = DEAD_CELL
			elif this_cell_is_alive_and_two_or_three_neighbour(y,x):
				next_generation[y][x] = LIVING_CELL	
			elif this_cell_is_alive_and_has_more_than_three_neighbours(y,x):
				next_generation[y][x] = DEAD_CELL	
			elif this_cell_is_dead_and_has_three_neighbours(y,x):
				next_generation[y][x] = LIVING_CELL
			else:					
				next_generation[y][x] = grid[y][x]
				
	grid = next_generation


func this_cell_is_alive_and_has_less_than_two_neighbours(row, col) -> bool:
	return is_alive(row, col) and count_living_neighbours(row, col) < 2


func this_cell_is_alive_and_two_or_three_neighbour(row, col) -> bool:
	return is_alive(row, col) and (count_living_neighbours(row, col) == 2 or count_living_neighbours(row, col) == 3)


func this_cell_is_alive_and_has_more_than_three_neighbours(row, col) -> bool:
	return is_alive(row, col) and count_living_neighbours(row, col) > 3

func this_cell_is_dead_and_has_three_neighbours(row, col) -> bool:
	return is_dead(row, col) and count_living_neighbours(row, col) == 3

