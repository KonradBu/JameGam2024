extends Node2D
@export var distanceFromWalls = 50
@export var health = 3
@export var speed = 0.01
enum state {alive, trapped, dead}
var healthcheck = health

# Change both!!!!
enum type {skeleton, zombie, archer}
var amountOfEnemieTypes = 3
#!!!

var currentType
var currentState
var character

func _physics_process(delta):
	if(currentState == state.alive):
		look_at(character.global_position)
		self.position = lerp(self.position,character.global_position,speed)
		

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
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
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
	var character = get_node("../Player")
	var spawnposition = randomspawnpoint(topleft, bottomright)
	while (spawnposition.distance_to(character.position) < 300):
		spawnposition = randomspawnpoint(topleft, bottomright)
		
func randomspawnpoint(topleft, bottomright):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var spawnposition = Vector2(rng.randi_range(topleft.x + distanceFromWalls, bottomright.x - distanceFromWalls), rng.randi_range(topleft.y + distanceFromWalls, bottomright.y - distanceFromWalls))
	return spawnposition
