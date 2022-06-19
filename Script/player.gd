extends KinematicBody2D

export var max_speed = 400
var acct = 2000
var motion = Vector2.ZERO
var move = 1
var rotation_speed = 0.1

signal dead
signal coin_collected
signal power_up

func _ready() -> void:
	pass


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		emit_signal("dead")
		body.queue_free()
	if body.is_in_group("point"):
		emit_signal("coin_collected")
		body.queue_free()
	if body.is_in_group("power_up"):
		emit_signal("power_up")
		body.queue_free()




