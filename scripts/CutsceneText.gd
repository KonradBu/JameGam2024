extends Label

var textCounter = 0
@onready var animation_player = $AnimationPlayer
var menu = preload("res://scenes/menu.tscn")
var world = preload("res://scenes/world.tscn")

func _ready():
	TextAnimation()
	text = "CONGRATULATIONS, YOU HAVE PASSED NECROMANCER SCHOOL!!!"
	textCounter += 1

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if textCounter == 1:
			$"../Cutscene2".visible = true
			$"../Cutscene1".visible = false
			TextAnimation()
			text = "Looks like the tests you endured managed to shrink your health down to one!
					Hey at least you have better control of your abilities."
			textCounter += 1
		elif textCounter == 2:
			$"../Cutscene2".visible = false
			$"../Cutscene3".visible = true
			TextAnimation()
			text = "Anyways, you know what they say, practice makes perfect! And that perfection
					can land you an honorable title."
			textCounter += 1
		elif textCounter == 3:
			$"../Cutscene3".visible = false
			$"../Cutscene4".visible = true
			TextAnimation()
			text = "Necromancer Master, a title given to the strongest of necromancers."
			textCounter += 1
		elif  textCounter == 4:
			$"../Cutscene4".visible = false
			$"../Cutscene2".visible = true
			TextAnimation()
			text = "Prove yourself worthy of the title, or you might just end up a failure!"
			textCounter += 1
		elif textCounter == 5:
			get_tree().change_scene_to_packed(world)

func TextAnimation():
	animation_player.play("TextAppearing")
