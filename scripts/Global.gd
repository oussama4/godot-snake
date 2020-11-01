extends Node

var score: = 0 setget set_score
var died: = false setget set_died
var high_score: = 0
var score_file: = "user://score.save"

signal score_changed
signal game_over


func set_score(value: int) -> void:
	score = value
	emit_signal("score_changed")
	if value > high_score:
		high_score = value
		save_score()


func set_died(value: bool) -> void:
	died = value
	emit_signal("game_over")


func save_score() -> void:
	var f: = File.new()
	f.open(score_file, File.WRITE)
	f.store_var(high_score)
	f.close()


func load_score() -> void:
	var f: = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		high_score = f.get_var()
		f.close()
	else:
		high_score = 0
