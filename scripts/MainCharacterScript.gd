extends CharacterBody2D

@export var speed = 400
@export var friction = 0.3
@export var acceleration = 0.1
@export var canThrowNeedle = true
@onready var _animated_sprite = $Player
signal needleThrown (mouseDirection, position)
var needleScene: PackedScene = preload("res://scenes/needle.tscn")

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

func _process(delta):
	#animation processing
	if Input.is_action_pressed('MoveDown'):
		_animated_sprite.stop()
		_animated_sprite.play("Walk Down")
	if Input.is_action_just_released('MoveDown'):
		_animated_sprite.stop()
		_animated_sprite.play("front Idle")
	if Input.is_action_pressed('MoveUp'):
		_animated_sprite.stop()
		_animated_sprite.play("walk up")
	if Input.is_action_just_released('MoveUp'):
		_animated_sprite.stop()
		_animated_sprite.play("back Idle")
	if Input.is_action_pressed("MoveLeft"):
		_animated_sprite.stop()
		_animated_sprite.play("Run left")
	if Input.is_action_just_released('MoveLeft'):
		_animated_sprite.stop()
		_animated_sprite.play("Left Idle")
	if Input.is_action_pressed("MoveRight"):
		_animated_sprite.stop()
		_animated_sprite.play("Run right")
	if Input.is_action_just_released('MoveRight'):
		_animated_sprite.stop()
		_animated_sprite.play("Right Idle")
		
		
		
	#Direction Processing
	if(Input.is_action_just_pressed("rightClick")):
		canThrowNeedle = true
	if(Input.is_action_just_pressed("leftClick") and canThrowNeedle == true):
		canThrowNeedle = false
		var mousePosition = get_local_mouse_position()
		var angle = atan2(mousePosition.y, mousePosition.x)
		var needle_instance = needleScene.instantiate()
		var parent = get_parent()
		parent.add_child(needle_instance) 
		var positionPlayer = $".".get_global_position()
		needle_instance.position = positionPlayer
		needle_instance.rotation = rad_to_deg(angle)
