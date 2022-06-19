extends Node2D

signal player_died
signal score_count
signal power_up

func _on_player_coin_collected() -> void:
	emit_signal("score_count")

func _on_player_dead() -> void:
	emit_signal("player_died")
	queue_free()

func _on_player_power_up() -> void:
	emit_signal("power_up")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_pos = get_local_mouse_position().x
		$player.global_position.x = mouse_pos 
	if event is InputEventScreenTouch:
		var touch_pos = event.position.x
		$player.global_position.x = touch_pos
