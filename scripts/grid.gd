extends GridContainer

const WIDTH = 20
const HEIGHT = 10

var Game_of_life = load("res://scripts/game_of_life.gd")
var Slot = load("res://scripts/Slot.gd")
var game = null

onready var timer = get_parent().get_node("Timer")

export var cell_count = 10

func _ready() -> void:
	
	self.set_columns(WIDTH)
	for _i in range (HEIGHT * WIDTH):
		var slot = Slot.new()
		self.add_child(slot)
		
	game = Game_of_life.new()
	game.init(HEIGHT, WIDTH)
	game.populate(cell_count)


func _on_Timer_timeout() -> void:
	game.compute_next_generation() 
	refresh_grid()
	timer.start(0)


func refresh_grid():
	var index = 0
	for y in range(HEIGHT):
		for x in range(WIDTH):
			var slot = get_child(index)
			if game.is_alive(y, x):
				slot.set_alive()
			else:
				slot.set_dead()
							
			index += 1
			
func _on_gui_input(event:InputEvent):
	print("toto")
