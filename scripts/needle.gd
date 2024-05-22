extends CharacterBody2D
@export var needleSpeed = 4000

# Called when the node enters the scene tree for the first time.
func _ready():
	var mousePosition = get_viewport().get_mouse_position()
	look_at(mousePosition)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	position += transform.x * needleSpeed * delta
