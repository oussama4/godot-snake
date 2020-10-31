extends Node

var score: = 0 setget set_score
var died: = false setget set_died
var high_score: = 0

signal score_changed
signal game_over


func set_score(value: int) -> void:
	score = value
	emit_signal("score_changed")
	if value > high_score:
		high_score = value


func set_died(value: bool) -> void:
	died = value
	emit_signal("game_over")
	self.score = 0
