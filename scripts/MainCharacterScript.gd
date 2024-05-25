extends CharacterBody2D

var leftorright = false
var up = false
var down = false

@export var speed = 170
@export var friction = 0.3
@export var acceleration = 0.1
@export var canThrowNeedle = true
@export var retractspeed = 600
@export var health = 1
@export var hitknockback = 25
@onready var _animated_sprite = $Player


var needle_instance
var currentState
enum state {walking, retracting, in_cutscene, dead}
var world


func _ready():
	currentState = state.walking
	world = get_tree().root.get_node("world")

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
	
	#var left = false
	#var right = false
	#var front = false
	#var back = false
	
	if(currentState == state.walking):
		if direction.length() > 0:
			velocity = velocity.lerp(direction.normalized() * speed, acceleration)
		else:
			velocity = velocity.lerp(Vector2.ZERO, friction)
	
	move_and_slide()
		
func _process(delta):
	if currentState == state.dead:
		world.die()

	#animations
	if Input.is_action_pressed("MoveDown"):
		_animated_sprite.play("Walk Down")
	elif Input.is_action_just_released("MoveDown"):
		_animated_sprite.play("front Idle")
		
	if Input.is_action_pressed("MoveUp"):
		_animated_sprite.play("walk up")
	elif Input.is_action_just_released("MoveUp"):
		_animated_sprite.play("back Idle")
		
	if Input.is_action_pressed("MoveRight") and not Input.is_action_pressed("MoveDown") and not Input.is_action_pressed("MoveUp"):
		_animated_sprite.play("Run")
	elif Input.is_action_just_released("MoveRight"):
		_animated_sprite.play("Right Idle")
		if Input.is_action_just_released("MoveDown"):
			_animated_sprite.play("front Idle")
		if Input.is_action_just_released("MoveUp"):
			_animated_sprite.play("back Idless")
	
	if Input.is_action_pressed("MoveLeft") and not Input.is_action_pressed("MoveDown") and not Input.is_action_pressed("MoveUp"):
		_animated_sprite.play("Run Left")
	elif Input.is_action_just_released("MoveLeft"):
		_animated_sprite.play("Left Idle")
		if Input.is_action_just_released("MoveDown"):
			_animated_sprite.play("front Idle")
		if Input.is_action_just_released("MoveUp"):
			_animated_sprite.play("back Idle")
	
	
	
	#throwing the needle
	if(Input.is_action_just_pressed("leftClick") and canThrowNeedle == true):
		var needleScene: PackedScene = preload("res://scenes/needle.tscn")
		canThrowNeedle = false
		needle_instance = needleScene.instantiate()
		var room = get_parent().get_parent()
		room.add_child(needle_instance) 
		var positionPlayer = get_global_position()
		needle_instance.global_position = positionPlayer

	#throwing needle
	if Input.is_action_just_pressed("rightClick"):
		if needle_instance.get_velocity().x == 0 and needle_instance.get_velocity().y:
			currentState = state.retracting
			position = position.move_toward(needle_instance.position, delta * retractspeed)
	
	#beeing able to move after the needle is thrown + deleting the needle
	if currentState == state.retracting and position == needle_instance.position:
		currentState = state.walking
		needle_instance.free()
		

func _on_area_2d_body_entered(body):
	if (body.is_in_group("enemy")):
		currentState = state.dead
		print("die")
	
