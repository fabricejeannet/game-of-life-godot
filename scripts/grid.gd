extends Node2D

const WIDTH = 20
const HEIGHT = 10

var Game_of_life = load("res://scripts/game_of_life.gd")
var Slot = load("res://scripts/grid_slot.gd")
var game = null
var iteration = 0

onready var timer = get_node("Timer")

onready var grid_container = get_node("GridContainer")

export var cell_count = 10

func _ready() -> void:
	init_game()
	init_grid()	
	init_timer()
	
	
func init_timer():	
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start(0)


func init_game():
	game = Game_of_life.new()
	game.init(HEIGHT, WIDTH)
	game.populate(cell_count)


func init_grid():
	grid_container.set_columns(WIDTH)
	for i in range (HEIGHT * WIDTH):
		var slot = Slot.new()
		slot.connect("gui_input", self, "_on_gui_input")
		grid_container.add_child(slot)
	refresh_grid()
	
	
func _on_Timer_timeout() -> void:
	if iteration % 2 == 0:
		refresh_grid()
		game.compute_next_generation() 
	else:
		show_dying_cell()
	
	iteration +=1	
	timer.start(0)

func show_dying_cell():
	var index = 0
	for y in range(HEIGHT):
		for x in range(WIDTH):
			var slot = grid_container.get_child(index) 
			if slot.is_alive() and game.is_dead(y, x):
				slot.set_dying()
							
			index += 1

func refresh_grid():
	var index = 0
	for y in range(HEIGHT):
		for x in range(WIDTH):
			var slot = grid_container.get_child(index)
			if game.is_alive(y, x):
				slot.set_alive()
			else:
				slot.set_dead()
							
			index += 1


func _on_gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print(event.as_text())
