extends Area2D


signal eaten


func _on_head_entered(area: Area2D) -> void:
	emit_signal("eaten")
	set_deferred("disabled", true)
	queue_free()
