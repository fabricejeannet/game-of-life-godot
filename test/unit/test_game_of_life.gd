extends "res://addons/gut/test.gd"

var Game_of_life = load("res://scripts/game_of_life.gd")
var game

func before_each():
	game = Game_of_life.new()
	game.init(4,8)
	
func test_can_create_grid():
	assert_not_null(game)

func test_grid_is_initialized_with_0():
	var sum = 0
	for y in range(4):
		for x in range(8):
			sum += game.get_grid()[y][x]
	
	assert_eq(sum, 0)


func test_find_no_living_neighbour_in_an_empty_grid():
	var neighbours_count = game.count_living_neighbours(1,4)
	assert_eq(neighbours_count, 0)


func test_founds_one_living_neighbour():
	game.set_living_cell(0,3)
	var neighbours_count = game.count_living_neighbours(1,4)
	assert_eq(neighbours_count, 1)


func test_founds_two_living_neighbours():
	game.set_living_cell(0,3)
	game.set_living_cell(0,4)
	var neighbours_count = game.count_living_neighbours(1,4)
	assert_eq(neighbours_count, 2)


func test_founds_three_living_neighbours():
	game.set_living_cell(0,3)
	game.set_living_cell(0,4)
	game.set_living_cell(0,5)
	var neighbours_count = game.count_living_neighbours(1,4)
	assert_eq(neighbours_count, 3)


func test_founds_four_living_neighbours():
	game.set_living_cell(0,3)
	game.set_living_cell(0,4)
	game.set_living_cell(0,5)
	game.set_living_cell(1,5)
	var neighbours_count = game.count_living_neighbours(1,4)
	assert_eq(neighbours_count, 4)

func test_founds_five_living_neighbours():
	game.set_living_cell(0,3)
	game.set_living_cell(0,4)
	game.set_living_cell(0,5)
	game.set_living_cell(1,5)
	game.set_living_cell(2,5)
	var neighbours_count = game.count_living_neighbours(1,4)
	assert_eq(neighbours_count, 5)


func test_founds_six_living_neighbours():
	game.set_living_cell(0,3)
	game.set_living_cell(0,4)
	game.set_living_cell(0,5)
	game.set_living_cell(1,5)
	game.set_living_cell(2,5)
	game.set_living_cell(2,4)
	var neighbours_count = game.count_living_neighbours(1,4)
	assert_eq(neighbours_count, 6)


func test_founds_seven_living_neighbours():
	game.set_living_cell(0,3)
	game.set_living_cell(0,4)
	game.set_living_cell(0,5)
	game.set_living_cell(1,5)
	game.set_living_cell(2,5)
	game.set_living_cell(2,4)
	game.set_living_cell(2,3)
	var neighbours_count = game.count_living_neighbours(1,4)
	assert_eq(neighbours_count, 7)


func test_founds_height_living_neighbours():
	game.set_living_cell(0,3)
	game.set_living_cell(0,4)
	game.set_living_cell(0,5)
	game.set_living_cell(1,5)
	game.set_living_cell(2,5)
	game.set_living_cell(2,4)
	game.set_living_cell(2,3)
	game.set_living_cell(1,3)
	var neighbours_count = game.count_living_neighbours(1,4)
	assert_eq(neighbours_count, 8)


func test_founds_three_living_neighbours_in_the_top_left_corner():
	game.set_living_cell(0,1)
	game.set_living_cell(1,1)
	game.set_living_cell(1,0)
	var neighbours_count = game.count_living_neighbours(0, 0)
	assert_eq(neighbours_count, 3)


func test_founds_three_living_neighbours_in_the_bottom_right_corner():
	game.set_living_cell(3,6)
	game.set_living_cell(2,6)
	game.set_living_cell(2,7)
	var neighbours_count = game.count_living_neighbours(3, 7)
	assert_eq(neighbours_count, 3)

func test_four_cells_fill_four_slots():
	game.init(4,4)
	game.populate(4)
	var sum = 0
	for y in range(4):
		for x in range(4):
			sum += game.get_grid()[y][x]
	assert_eq(sum, 4)

func test_cell_with_fewer_than_two_neighbours_dies():
	game.set_living_cell(0,0)
	game.set_living_cell(0,1)
	game.compute_next_generation()
	assert_true(game.is_dead(0,0))


func test_cell_with_two_or_three_neighbours_lives():
	game.set_living_cell(0,0)
	game.set_living_cell(0,1)
	game.set_living_cell(1,1)
	
	game.set_living_cell(0,7)
	game.set_living_cell(0,6)
	game.set_living_cell(1,6)
	game.set_living_cell(1,7)
	
	game.compute_next_generation()
	assert_true(game.is_alive(0,0) && game.is_alive(0,7))


func test_cell_with_more_than_three_neighbours_dies():
	game.set_living_cell(1,4)
	game.set_living_cell(0,3)
	game.set_living_cell(0,4)
	game.set_living_cell(0,5)
	game.set_living_cell(1,5)
	game.compute_next_generation()
	assert_true(game.is_dead(1,4))


func test_dead_cell_with_more_three_neighbours_gets_alive():
	game.set_living_cell(0,3)
	game.set_living_cell(0,4)
	game.set_living_cell(0,5)
	game.compute_next_generation()
	assert_true(game.is_alive(1,4))


