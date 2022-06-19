extends Node2D

func _ready() -> void:
	pass
	
func move(target):
	var move_tween = get_node("Move_Tween")
	move_tween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()











