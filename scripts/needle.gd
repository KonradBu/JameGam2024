extends CharacterBody2D
@export var needleSpeed = 700

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _init():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var movement_vector2: Vector2 = Vector2.RIGHT.rotated(rotation)
	movement_vector2 = movement_vector2 * needleSpeed
	velocity = movement_vector2
	move_and_slide()
