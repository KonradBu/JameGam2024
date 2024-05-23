extends Label

var textCounter = 0
@onready var animation_player = $AnimationPlayer
var menu = preload("res://scenes/menu.tscn")

func _ready():
	TextAnimation()
	text = "CONGRATULATIONS, YOU HAVE PASSED NECROMANCER SCHOOL!!!"
	textCounter += 1

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if textCounter == 1:
			TextAnimation()
			text = "Looks like the tests you endured managed to shrink your health down to one!
					Hey at least you have better control of your abilities."
			textCounter += 1
		elif textCounter == 2:
			TextAnimation()
			text = "Anyways, you know what they say, practice makes perfect! And that perfection
					can land you an honorable title."
			textCounter += 1
		elif textCounter == 3:
			TextAnimation()
			text = "Necromancer Master, a title given to the strongest of necromancers."
			textCounter += 1
		elif  textCounter == 4:
			TextAnimation()
			text = "Prove yourself worthy of the title, or you might just end up a failure!"
			textCounter += 1
		elif textCounter == 5:
			get_tree().change_scene_to_packed(menu)

func TextAnimation():
	animation_player.play("TextAppearing")
