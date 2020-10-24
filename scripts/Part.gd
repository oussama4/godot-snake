extends Area2D

var next_pos: = Vector2.ZERO


func move() -> void:
	position += next_pos
