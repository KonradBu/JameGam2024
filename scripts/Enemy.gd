extends Node2D
@onready var player := $"."

func _physics_process(delta):
	var speed: float = 0.01 # put wanted speed here
	look_at(player.global_position)
	self.position = lerp(self.position,player.global_position,speed)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
