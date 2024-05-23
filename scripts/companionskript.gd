extends CharacterBody2D

@export var companionSpeed = 200
@export var health = 20

enum armParts {default, shout, posion}
enum legParts {default, sprint, stomp}
enum coreParts {default, heavy, light}

var currentArm = armParts.default
var currentLeg = legParts.default
var currentCore = coreParts.default

func _physics_process(delta):
	match currentArm:
		armParts.shout:
			pass
		armParts.posion:
			pass
		armParts.default:
			pass
	match (currentLeg):
		legParts.default:
			pass
		legParts.stomp:
			pass
		legParts.sprint:
			pass
	match (currentCore):
		coreParts.heavy:
			pass
		coreParts.light:
			pass
		coreParts.default:
			pass
			
