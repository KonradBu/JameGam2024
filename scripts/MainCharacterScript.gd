extends CharacterBody2D

@export var speed = 400
@export var friction = 0.3
@export var acceleration = 0.1
@export var canThrowNeedle = true
@export var retractspeed = 600
@export var health = 1
@onready var _animated_sprite = $Player
signal needleThrown (mouseDirection, position)
var needleScene: PackedScene = preload("res://scenes/needle.tscn")
var currentState
enum state {walking, retracting, in_cutscene, dead}
	
func _init():
	currentState = state.walking

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
	#moving
	var direction = get_input()
	
	var left = false
	var right = false
	var front = false
	var back = false
	
	if(currentState == state.walking):
		if direction.length() > 0:
			velocity = velocity.lerp(direction.normalized() * speed, acceleration)
		else:
			velocity = velocity.lerp(Vector2.ZERO, friction)
		move_and_slide()
	
func _process(delta):
	if currentState == state.dead:
		#play death animation here
		var startScene = load("res://scenes/roomEntrance.tscn")

	#animations
	if Input.is_action_pressed("MoveDown"):
		_animated_sprite.play("Walk Down")
	elif Input.is_action_just_released("MoveDown"):
		_animated_sprite.play("front Idle")
		
	if Input.is_action_pressed("MoveUp"):
		_animated_sprite.play("walk up")
	elif Input.is_action_just_released("MoveUp"):
		_animated_sprite.play("back Idle")
		
	if Input.is_action_pressed("MoveRight"):
		_animated_sprite.play("Run")
	elif Input.is_action_just_released("MoveRight"):
		_animated_sprite.play("Right Idle")
	
	if Input.is_action_pressed("MoveLeft"):
		_animated_sprite.play("Run Left")
	elif Input.is_action_just_released("MoveLeft"):
		_animated_sprite.play("Left Idle")
		
	#throwing needle
	if(Input.is_action_just_pressed("rightClick")):
		var parent = get_parent().get_parent()
		var needleInstance = parent.get_node_or_null("needle")
		if needleInstance.velocity == 0:
			currentState = state.retracting
			position = position.move_toward(needleInstance.position, delta * retractspeed)
	
	#beeing able to move after the needle is thrown + deleting the needle
	if currentState == state.retracting and position == $needle.position:
		currentState = state.walking
		var parent = get_parent().get_parent()
		var needle = parent.get_node("needle")
		needle.free() 
	
	#throwing the needle
	if(Input.is_action_just_pressed("leftClick") and canThrowNeedle == true):
		canThrowNeedle = false
		var needle_instance = needleScene.instantiate()
		var parent = get_parent().get_parent()
		parent.add_child(needle_instance) 
		var positionPlayer = get_global_position()
		needle_instance.global_position = positionPlayer

#collision detection and dying
func _on_area_2d_body_entered(body):
	if body.is_in_group("enemies"):
		if currentState == state.walking:
			health -= 1
			if health == 0:
				currentState = state.dead
		if currentState == state.retracting:
			body.currentState = body.state.trapped
			body.health -= 1
