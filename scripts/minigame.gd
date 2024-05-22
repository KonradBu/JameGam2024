extends Node2D

signal minigameEnd
# Called when the node enters the scene tree for the first time.
func _ready():
	minigameEnd.connect(_on_minigame_end)
	emit_signal("minigameEnd")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
