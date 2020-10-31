extends CanvasLayer


onready var tween: = $Tween


func appear() -> void:
	tween.interpolate_property(self, "offset:x", 640, 0, 1.0, 
				Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()
	
	
func disappear() -> void:
	tween.interpolate_property(self, "offset:x", 0, 640, 1.0,
				Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()
