extends Enemy

func _ready():
	NAME = "Papyrus"
	HP = 100
	ATK = 15
	DEF = 30
	spareable = false

	$Animations.play("Idle")
	var click = preload("res://Shared/Text/Clicks/Files/papyrus.wav")
	$Bubble/Blitter/Click.stream = click

func acting(selection: int):
	if selection == 0:
		return "It's Papyrus omg !!!!"
	return "Not implemented"
