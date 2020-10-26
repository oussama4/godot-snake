extends Area2D


signal eaten


func _on_head_entered(area: Area2D) -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("eaten")
	#queue_free()
