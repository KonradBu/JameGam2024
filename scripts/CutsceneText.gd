extends Label

var textCounter = 0
@onready var animation_player = $AnimationPlayer

func _ready():
	TextAnimation()
	text = "efhieufheiufhiefeifeifueifubeiufeiufbfiubefubefefefefefe"
	textCounter += 1

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if textCounter == 1:
			TextAnimation()
			text = "necro boy go story boi haha shing shing brrrrrrr okay i stop lol"
			textCounter += 1
		elif textCounter == 2:
			TextAnimation()
			text = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
			textCounter += 1
		elif  textCounter == 3:
			TextAnimation()
			text = "end of dialogue example, can add more in script (theres prob a better way to do this lol)"
			textCounter += 1

func TextAnimation():
	animation_player.play("TextAppearing")
