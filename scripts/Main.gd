extends Node2D


onready var food = preload("res://scenes/Food.tscn")
onready var snake: = $Snake

var screen_size


func _ready() -> void:
	randomize()
	screen_size = get_viewport_rect().size
	spawn_food()
	
	
func random_pos() -> Vector2:
	var x = randi() % (int(screen_size.x) - 40) + 20
	var y = randi() % (int(screen_size.y) - 40) + 20
	var p =  Vector2(x, y)
	if snake.is_position_full(p):
		return random_pos()
	else:
		return p
	
	
func spawn_food() -> void:
	var p = random_pos()
	var f = food.instance()
	f.position = p
	f.connect("eaten", self, "on_eaten")
	add_child(f)
	
	
func on_eaten() -> void:
	snake.add_part()
	spawn_food()
