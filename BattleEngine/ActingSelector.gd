extends Node2D

var input = Vector2.ZERO
var selection = 0

var enabled = false # was "enable"

var positionArray = [Vector2(73, 286), Vector2(321, 286),
					Vector2(73, 318), Vector2(321, 318),
					Vector2(73, 350), Vector2(321, 350)]
var soul

var list = []

signal select

func enable(_soul):
	self.soul = _soul
	connect("select", Callable(self, "disable"))
	await get_tree().create_timer(0.1).timeout
	self.enabled = true

func _process(_delta):
	if enabled:
		input.x = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
		input.y = (int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))) * 2
		
		if input:
			get_parent().get_node("Squeak").play()
		
		selection = int(selection + input.x + input.y) % list.size()
		
		soul.position = positionArray[selection]
		
		if Input.is_action_just_pressed("ui_accept"):
			self.enabled = false
			get_parent().get_node("Select").play()
			select.emit()
		elif Input.is_action_just_pressed("ui_cancel"):
			get_parent().get_node("Squeak").play()
			select.emit()

func string():
	var _string = ""
	for index in range(list.size()):
		var option = list[index]
		if index % 2 == 1:
			for spaces in range(14 - len(list[index - 1])):
				_string += " "
			_string += "* " + option + "\n"
		else:
			_string += "   * " + option
	return _string

func disable():
	disconnect("select", Callable(self, "disable"))

func get_selection(): # was "selection
	return list[selection]
