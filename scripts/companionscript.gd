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


var targetposition

func _on_ready():
	targetposition = find_target()
	var newposition = position.move_toward(targetposition, companionSpeed)
	position = newposition
	
func _physics_process(delta):
	pass

func _input(event):
	if(Input.is_action_just_pressed("Ability 1")):
		pass
	if(Input.is_action_just_pressed("Ability 2")):
		pass



func find_target():
	var room = get_parent().get_parent()
	var children = room.get_children()
	var enemies = []
	for child in children:
		if child.is_in_group("enemy") and child.state != child.state.dead:
			enemies.append(child)
	var target
	targetposition = 100000
	if enemies != []:
		for enemy in enemies:
			if position.distance_to(enemy.position) < position.distance_to(targetposition):
				target = enemy
				targetposition = enemy.position
	$find_new_target.start
	return targetposition

func _on_find_new_target_timeout():
	targetposition = find_target()
