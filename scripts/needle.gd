extends CharacterBody2D
@export var needleSpeed = 20000

# Called when the node enters the scene tree for the first time.
func _ready():
	var mousePosition = get_viewport().get_mouse_position()
	look_at(mousePosition)
	print(rotation_degrees)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	#var movement_vector = Vector2(1,1)
	
	#movement_vector = movement_vector.rotated(deg_to_rad(global_rotation_degrees))
	#movement_vector = movement_vector * needleSpeed * delta
	#velocity = movement_vector
	#move_and_slide()
	pass
