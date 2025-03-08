extends Node2D
class_name Enemy

@export var NAME = "Monster"

var ATK = 15
var DEF = 30

var actings = ["Check"]

var HP = 100
@export var spareable = true
var spared = false
var store_amnt = 0

@onready var blitter = $Bubble/Blitter

func spare():
	spared = true
	self.modulate.a = 0.3

func shake(amount):
	if store_amnt == 0:
		store_amnt = (amount/100.0) + 0.01
	var offset_sign = (int($Sprite2D.position.x >= 0) * 2) - 1
	$Sprite2D.position.x = -(amount * offset_sign)
	amount -= 1
	var test = amount/100.0
	await get_tree().create_timer(store_amnt - test).timeout
	if amount != 0:
		shake(amount)
	else:
		store_amnt = 0

func acting(_selection: int):
	return "Not implemented"

func bubble(dataText = "", animation = true, pause = 0.035, longPausesIndexes = [], longPause = 0.5):
	$Bubble.visible = true
	blitter.feed(dataText, animation, pause, longPausesIndexes, longPause)
