extends Panel

var living_cell_texture = preload("res://assets/images/living_cell.png")
var dead_cell_texture = preload("res://assets/images/dead_cell.png")
var dying_cell_texture = preload("res://assets/images/dying_cell.png")

var slot_style:StyleBoxTexture = null
var alive = false

func _init() -> void:
	slot_style = StyleBoxTexture.new()
	set('custom_styles/panel', slot_style)
	self.set_custom_minimum_size(Vector2(32,32))

func set_dying():
	slot_style.texture = dying_cell_texture

func set_alive():
	alive = true
	slot_style.texture = living_cell_texture


func set_dead():
	alive = false
	slot_style.texture = dead_cell_texture

func is_alive() -> bool:
	return alive
