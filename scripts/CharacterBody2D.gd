extends CharacterBody2D


@export var speed = 400
@export var friction = 0.3
@export var acceleration = 0.1



func get_input():
	var input = Vector2()
	if Input.is_action_pressed('MoveRight'):
		input.x += 1
	if Input.is_action_pressed('MoveLeft'):
		input.x -= 1
	if Input.is_action_pressed('MoveDown'):
		input.y += 1
	if Input.is_action_pressed('MoveUp'):
		input.y -= 1
	return input

func _physics_process(_delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
