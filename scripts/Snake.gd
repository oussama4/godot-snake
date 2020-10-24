extends Node2D


export var speed: = 100

onready var head: = $Head
onready var part = preload("res://scenes/Part.tscn")

var direction: = Vector2(0, -1)
var min_dist
var parts = []


func _ready() -> void:
	min_dist = head.get_node("Sprite").texture.get_size().x / 2


func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		direction = Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		direction = Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		direction = Vector2(1, 0)
	if Input.is_action_pressed("ui_up"):
		direction = Vector2(0, -1)
	move_snake(delta)


# checks if the next random food position is occupied by the snake
func is_position_full(pos: Vector2) -> bool:
	if pos.distance_to(head.position) < min_dist:
		return true
	for p in parts:
		if pos.distance_to(p.position) < min_dist:
			return true
	return false


func add_part() -> void:
	var p = part.instance()
	p.position = Vector2(-100, -100)
	parts.append(p)
	add_child(p)


func move_snake(delta: float) -> void:
	var next_pos = head.position
	head.position += direction * speed * delta
	for p in parts:
		var pos = p.position
		p.position = next_pos
		next_pos = pos
