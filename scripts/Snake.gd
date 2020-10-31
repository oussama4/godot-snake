extends Node2D


export var speed: = 100

onready var head: = $Head
onready var part = preload("res://scenes/Part.tscn")

var direction: = Vector2.UP
var min_dist
var part_size
var parts = []
var screen_size


func _ready() -> void:
	$MoveTimer.start()
	screen_size = get_viewport_rect().size
	min_dist = head.get_node("Sprite").texture.get_size().x / 2
	part_size = head.get_node("Sprite").texture.get_size().x / 5



func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down") and direction != Vector2.UP:
		direction = Vector2.DOWN
	if Input.is_action_pressed("ui_left")  and direction != Vector2.RIGHT:
		direction = Vector2.LEFT
	if Input.is_action_pressed("ui_right") and direction != Vector2.LEFT:
		direction = Vector2.RIGHT
	if Input.is_action_pressed("ui_up") and direction != Vector2.DOWN:
		direction = Vector2.UP


# checks if the next random food position is occupied by the snake
func is_position_full(pos: Vector2) -> bool:
	if pos.distance_to(head.global_position) < min_dist:
		return true
	for p in parts:
		if pos.distance_to(p.global_position) < min_dist:
			return true
	return false


func add_part() -> void:
	var p = part.instance()
	if parts.empty():
		p.position = head.position
		head.position += direction * speed
	else:
		p.position = parts.back().position
	parts.append(p)
	call_deferred("add_child", p)


func move_snake() -> void:
	if not parts.empty():
		parts.back().position = head.position
		parts.insert(0, parts.back())
		parts.pop_back()
	if is_screen_exited():
		enter_screen()
	else:
		head.position += direction * speed


func enter_screen() -> void:
	if head.global_position.x < 0:
		head.global_position.x = screen_size.x
	elif head.global_position.x > screen_size.x:
		head.global_position.x = 0
	elif head.global_position.y < 0:
		head.global_position.y = screen_size.y
	elif head.global_position.y > screen_size.y:
		head.global_position.y = 0


func is_screen_exited() -> bool:
	var left = head.global_position.x < 0
	var right = head.global_position.x > screen_size.x
	var up = head.global_position.y < 0
	var down = head.global_position.y > screen_size.y
	if left or right or up or down:
		return true
	return false


func _on_Head_area_entered(area: Area2D) -> void:
	Global.died = true
