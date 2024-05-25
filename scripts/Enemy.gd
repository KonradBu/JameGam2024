extends Node2D
@export var distanceFromWalls = 50
@export var health = 3
@export var speed = 0.01
enum state {alive, trapped, dead}
var healthcheck = health
var enemyspeed = 100

# Change both!!!!
enum type {skeleton, zombie, archer}
var amountOfEnemieTypes = 3
#!!!

var currentType
var currentState
var character
var targetposition
var distanceToPlayer
var distanceToCompanion
var player
var companion
var companionposition
var playerposition


func _ready():
	character = get_node("../Player")
	currentState = state.alive
	currentType = type.values().pick_random()
	add_to_group("enemy")
	if(currentType == type.skeleton):
		var skeleton_texture = load("res://textures/skeleton.png")
		$Sprite2D.texture = skeleton_texture
	if(currentType == type.zombie):
		var zombie_texture = load("res://textures/zombie.png")
		$Sprite2D.texture = zombie_texture
	if(currentType == type.archer):
		var archer_texture = load("res://textures/archer.png")
		$Sprite2D.texture = archer_texture
	spawn()
	
	
func _physics_process(delta):
	var new_position
	match currentType:
		type.archer:
			if(position.distance_to(targetposition) > 100):
				new_position = position.move_toward(targetposition, enemyspeed * delta)
			elif(position.distance_to(targetposition) < 70):
				new_position = position.move_toward(targetposition, -enemyspeed * delta)
			else:
				new_position = position
		_:
			new_position = position.move_toward(targetposition, enemyspeed * delta)
	position = new_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	if healthcheck != health:
		$Healthbar.value = health
		healthcheck = health
	if currentState == state.trapped:
		#change to trapped animation
		pass
	if currentState == state.alive and health < 1:
		currentState = state.dead
		var room = get_parent()
		room.minus_enemycount()
	if currentState == state.dead:
		#change to dead animation
		pass
		
	#finding target
	player = get_node("../Player")
	playerposition = player.get_position_body()
	companion = get_node("../companion")
	companionposition = companion.get_position_body() 
	
	distanceToPlayer = position.distance_to(playerposition)
	distanceToCompanion = position.distance_to(companionposition)
	var target
	if(distanceToCompanion > distanceToPlayer):
		target = player
	else:
		target = companion
	print (target.name)
	targetposition = target.get_position_body()
	print (targetposition)

func spawn():
	var room = get_parent()
	var topleft = room.top_left
	var bottomright = room.bottom_right
	character = get_node("../Player")
	var companion = get_node("../companion")
	var spawnposition = randomspawnpoint(topleft, bottomright)
	while (spawnposition.distance_to(character.position) < 100 or spawnposition.distance_to(companion.position) < 100):
		spawnposition = randomspawnpoint(topleft, bottomright)
	position = spawnposition

func randomspawnpoint(topleft, bottomright):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var spawnposition = Vector2(rng.randi_range(topleft.x + distanceFromWalls, bottomright.x - distanceFromWalls), rng.randi_range(topleft.y + distanceFromWalls, bottomright.y - distanceFromWalls))
	return spawnposition


func hit(cause):
	match (cause):
		"needle":
			health -= 1
			currentState = state.trapped
		_:
			health = 0
