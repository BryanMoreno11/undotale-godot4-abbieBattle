extends Enemy

func _ready() -> void:
	NAME = "Abbie"
	HP = 100
	ATK = 15
	DEF = 30
	spareable = false

func acting(selection: int):
	if selection == 0:
		return "A nice and clumsy girl"
	return "Not implemented"
