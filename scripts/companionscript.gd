extends CharacterBody2D

@export var companionSpeed = 200
@export var health = 20

enum armParts {default}
enum legParts {default}
enum headParts {default}
enum torsoParts {default}


var currentArm = armParts.default
var currentLeg = legParts.default
var currentHead = headParts.default
var currentTorso = torsoParts.default


func _physics_process(delta):
	pass


func _input(event):
	if(Input.is_action_just_pressed("Ability 1")):
		pass
	if(Input.is_action_just_pressed("Ability 2")):
		pass
