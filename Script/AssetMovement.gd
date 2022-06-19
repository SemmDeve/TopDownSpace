extends KinematicBody2D

class_name Movement

export var speed = 200
var velocity = Vector2()

func movement():
	velocity = Vector2()
	
	if velocity.y == 0:
		velocity.y += 1
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	movement()
	velocity = move_and_slide(velocity)

