extends Panel

var living_cell_texture = preload("res://assets/images/living_cell.png")
var dead_cell_texture = preload("res://assets/images/dead_cell.png")
var slot_style:StyleBoxTexture = null

func _ready() -> void:
	self.set_custom_minimum_size(Vector2(32,32))

func _init() -> void:
	slot_style = StyleBoxTexture.new()
	set('custom_styles/panel', slot_style)


func set_alive():
	print("alive")
	slot_style.texture = living_cell_texture


func set_dead():
	print("dead")
	slot_style.texture = dead_cell_texture

