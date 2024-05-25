extends CharacterBody2D

@export var companionSpeed = 200
@export var health = 1
@export var hitknockback = 50

enum armParts {default}
enum legParts {default}
enum headParts {default}
enum torsoParts {default}


var currentArm = armParts.default
var currentLeg = legParts.default
var currentHead = headParts.default
var currentTorso = torsoParts.default

enum state {alive, dead}
enum attackingstate {attacking, followingplayer} 

var currentstate
var currentattackingstate

var targetposition = Vector2(0,0)

func _on_ready():
	currentstate = state.alive
	currentattackingstate = attackingstate.followingplayer

	
func _physics_process(delta):
	var newposition
	if currentattackingstate == attackingstate.attacking:
		newposition = position.move_toward(targetposition, companionSpeed * delta)
	else:
		if position.distance_to(targetposition) > 150:
			newposition = position.move_toward(targetposition, companionSpeed * delta)
		else:
			newposition = position.move_toward(targetposition, -companionSpeed * delta)
	position = newposition

func _input(event):
	if(Input.is_action_just_pressed("Ability 1")):
		pass
	if(Input.is_action_just_pressed("Ability 2")):
		pass

func _process(delta):
	var room = get_parent().get_parent()
	var children = room.get_children()
	var enemies = []
	for child in children:
		if child.is_in_group("enemy") and child.currentState != child.state.dead:
			enemies.append(child)
	var target
	var temptargetdistance = 10000
	if enemies != []:
		currentattackingstate = attackingstate.attacking
		for enemy in enemies:
			if position.distance_to(enemy.position) < temptargetdistance:
				target = enemy
				targetposition = enemy.position
				temptargetdistance = position.distance_to(enemy.position)
	else:
		currentattackingstate = attackingstate.followingplayer
	
func hit(enemyposition):
	position = position.move_toward(enemyposition, -hitknockback)
	health -= 10
	$ProgressBar.value -= 10
