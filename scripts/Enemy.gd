extends Node2D
@onready var player := $"."

@export var health = 3
@export var speed = 0.01
enum state {alive, trapped, dead}
var currentState = state.alive


func _physics_process(delta):
	if(currentState == state.alive):
		look_at(player.global_position)
		self.position = lerp(self.position,player.global_position,speed)
		
		
func _ready():
	pass # Replace with function body.


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
