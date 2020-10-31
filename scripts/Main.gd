extends Node2D


onready var food_scene: = preload("res://scenes/Food.tscn")
onready var snake_scene: = preload("res://scenes/Snake.tscn")
#onready var border_res: StyleBoxFlat = preload("res://border_stylebox.tres")
var snake
var food

var screen_size
var score: = 0


func _ready() -> void:
	randomize()
	$Score.hide()
	screen_size = get_viewport_rect().size
	Global.connect("score_changed", self, "update_ui")
	Global.connect("game_over", self, "_on_game_over")


func random_pos() -> Vector2:
	var x = rand_range(20, screen_size.x - 20)
	var y = rand_range(80, screen_size.y - 20)
	var p =  Vector2(x, y)
	if snake.is_position_full(p):
		print("full")
		return random_pos()
	else:
		return p
	
	
func spawn_food() -> void:
	var p = random_pos()
	food.position = p
	food.get_node("CollisionShape2D").set_deferred("disabled", false)


func _on_Food_eaten() -> void:
	spawn_food()
	snake.add_part()
	Global.score += 1
	Engine.time_scale += 0.001


func update_ui() -> void:
	$Score/Label.text = str(Global.score)


func _on_start_game() -> void:
	$Score.show()
	food = food_scene.instance()
	snake = snake_scene.instance()
	snake.position = $Position2D.position
	add_child(snake)
	var p = random_pos()
	food.position = p
	add_child(food)
	food.connect("eaten", self, "_on_Food_eaten")


func _on_game_over() -> void:
	$Score.hide()
	food.queue_free()
	snake.queue_free()
	Engine.time_scale = 1.0
	$Screens.game_over()
