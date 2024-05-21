extends CharacterBody2D
@export var needleSpeed = 20000

# Called when the node enters the scene tree for the first time.
func _ready():
	var mousePosition = get_global_mouse_position()
	look_at(mousePosition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var movement_vector = Vector2(1,1)
	
	movement_vector = movement_vector.rotated(deg_to_rad(global_rotation_degrees))
	movement_vector = movement_vector * needleSpeed * delta
	velocity = movement_vector
	move_and_slide()
