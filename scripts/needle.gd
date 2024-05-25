extends CharacterBody2D
@export var needleSpeed = 1000
@onready var animated_sprite_2d = $AnimatedSprite2D
var mousePosition

# Called when the node enters the scene tree for the first time.
func _ready():
	mousePosition = get_global_mouse_position()
	look_at(mousePosition)
	var direction = (mousePosition - get_global_position()).normalized()
	print(direction)
	velocity = direction * needleSpeed
	animated_sprite_2d.flip_h = true
	animated_sprite_2d.play("Spin")
	
func _process(delta):
	if is_on_floor() == true:
		animated_sprite_2d.play("Static")
		
func _physics_process(delta):
	move_and_collide(velocity * delta)


func _on_area_2d_body_entered(body):
	if (body.is_in_group("enemy")):
		body.got_hit("needle")
