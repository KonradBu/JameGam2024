extends Node2D
@onready var player := $"."
@export var distanceFromWalls = 50
@export var health = 3
@export var speed = 0.01
enum state {alive, trapped, dead}

# Change both!!!!
enum type {skeleton, zombie, archer}
var amountOfEnemieTypes = 3
#!!!

var currentType
var currentState


func _physics_process(delta):
	if(currentState == state.alive):
		look_at(player.global_position)
		self.position = lerp(self.position,player.global_position,speed)
		
		
func _ready():
	currentState = state.alive
	currentType = type.values().pick_random()
	if(currentType == type.skeleton):
		$Sprite2D.texture = "res://textures/skeleton.png"
	if(currentType == type.zombie):
		$Sprite2D.texture = "res://textures/zombie.png"
	if(currentType == type.archer):
		$Sprite2D.texture = "res://textures/archer.png"
	spawn()
		
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	var topleft = room.topleft
	var bottomright = room.bottomright
	var children = room.get_children()
	var character
	for child in children:
		if child == "character":
			character = child
	var spawnposition = randomspawnpoint(topleft, bottomright)
	while (spawnposition.distance_to(character.position) < 300):
		spawnposition = randomspawnpoint(topleft, bottomright)
		
func randomspawnpoint(topleft, bottomright):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var spawnposition = Vector2(rng.randi_range(topleft.x + distanceFromWalls, bottomright.x - distanceFromWalls), rng.rand_range(topleft.y + distanceFromWalls, bottomright.y - distanceFromWalls))
