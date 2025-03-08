extends RichTextLabel

@onready var click_node = $Click

var dataText := ""
var animated := true
var pause := 0.035
var longPausesIndexes := []
var longPause := 0.5

var click = preload("res://Shared/Text/Clicks/Files/generic2.wav")

var ongoing = false
@export var skippable = false

signal next

@onready var timer = $Timer

func _ready():
	next.connect(_on_next)
	click_node.stream = click

func _process(_delta):
	if skippable:
		if Input.is_action_just_pressed("ui_accept") and !ongoing:
			emit_signal("next")
		elif Input.is_action_just_pressed("ui_cancel") and ongoing:
			freeze()

func freeze():
	timer.stop()
	ongoing = false
	visible_characters = len(dataText)

func feed(_dataText = "", _animated = true, _pause = 0.035, _longPausesIndexes = [], _longPause = 0.5):
	ongoing = true
	
	timer.stop()
	
	dataText = _dataText
	animated = _animated
	pause = _pause
	longPausesIndexes = _longPausesIndexes
	longPause = _longPause

	text = dataText
	visible_characters = 0
	
	await get_tree().create_timer(0.1).timeout
	
	if !animated:
		visible_characters = len(dataText)
		ongoing = false
		return

	nextChar()

func nextChar():
	if visible_characters < len(dataText):
		visible_characters += 1
		click_node.play()
		if visible_characters in longPausesIndexes:
			timer.start(longPause)
		else:
			timer.start(pause)
	else:
		ongoing = false

func _on_next():
	visible_characters = 0

func _on_text_timeout():
	nextChar()
