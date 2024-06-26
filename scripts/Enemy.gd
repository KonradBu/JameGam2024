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
var targetposition = Vector2(0,0)
var tempdelta = 0.0

func _physics_process(delta):
	var new_position
	match type:
		type.archer:
			if(position.distance_to(targetposition) > 100):
				new_position = position.move_toward(targetposition, enemyspeed * tempdelta)
			elif(position.distance_to(targetposition) < 70):
				new_position = position.move_toward(targetposition, -enemyspeed * tempdelta)
			else:
				new_position = position
		_:
			new_position = position.move_toward(targetposition, enemyspeed * tempdelta)
	position = new_position
	#if(currentState == state.alive):
	#	look_at(character.global_position)
	#	self.position = lerp(self.position,character.global_position,speed)
		

func _ready():
	character = get_node("../Player")
	currentState = state.alive
	currentType = type.values().pick_random()
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
	targetposition = find_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	tempdelta = delta
	if healthcheck != health:
		$Healthbar.value = health
	if currentState == state.trapped:
		#change to trapped animation
		pass
	if currentState == state.alive and health < 1:
		currentState = state.dead
		var room = get_parent()
		room.enemycount -= 1
	if currentState == state.dead:
		#change to dead animation
		pass
	
	
	
func spawn():
	var room = get_parent()
	var topleft = room.top_left
	var bottomright = room.bottom_right
	character = get_node("../Player")
	var spawnposition = randomspawnpoint(topleft, bottomright)
	while (spawnposition.distance_to(character.position) < 300):
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

func find_target():
	var player = get_parent().get_node("Player")
	var companion = get_parent().get_node("companion") 
	var distanceToPlayer = position.distance_to(player.position)
	var distanceToCompanion = position.distance_to(companion.position)
	var target
	if(distanceToCompanion > distanceToPlayer):
		target = companion
	else:
		target = player
	$find_new_target.start()
	targetposition = target.position

func _on_find_new_target_timeout():
	targetposition = find_target()
