extends CanvasLayer

onready var tween = $Tween

func appear():
	tween.interpolate_property(self, "offset:x", 576, 0, 0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()
func disappear():
	tween.interpolate_property(self, "offset:x", 0, 576, 0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()

