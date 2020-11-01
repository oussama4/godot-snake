extends ColorRect


var paused: = false setget set_pause

signal go_home


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		self.paused = not paused


func set_pause(value: bool) -> void:
	paused = value
	get_tree().paused = value
	visible = value


func _on_ResumeButton_pressed() -> void:
	self.paused = not paused


func _on_HomeButton_pressed() -> void:
	emit_signal("go_home")
	self.paused = not paused
