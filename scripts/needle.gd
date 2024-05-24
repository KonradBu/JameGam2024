extends CharacterBody2D
@export var needleSpeed = 4000
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_2d = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var mousePosition = get_viewport().get_mouse_position()
	look_at(mousePosition)

func _physics_process(delta):
	position += transform.x * needleSpeed * delta
	animated_sprite_2d.play("Spin")
	
	if ray_cast_2d.is_colliding() == true:
		velocity.x = 0
		velocity.y = 0
		

