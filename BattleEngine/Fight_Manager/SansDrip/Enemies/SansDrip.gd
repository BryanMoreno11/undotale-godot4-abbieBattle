extends Enemy

func _ready():
	NAME = "Test Robert"
	HP = 100
	ATK = 10
	DEF = 30
	spareable = true
	actings = ["Check", "Hey", "DidYouKnw", "ThatIdont", "knowhowto", "makeaMojito"]
	var click = preload("res://Shared/Text/Clicks/Files/papyrus.wav")
	$Bubble/Blitter/Click.stream = click
