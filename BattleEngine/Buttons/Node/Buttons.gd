extends Node2D

var input
var selection = 0

var enabled = false

var positionArray = [50,205,362,517]
var soul

@onready var children = self.get_children()

signal select(selection: String)

func enable(_soul):
	self.soul = _soul
	select.connect(disable) # connect("select", Callable(self, "disable"))
	self.enabled = true

func _process(_delta):
	if enabled:
		input = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
		
		if input:
			get_parent().get_node("Squeak").play()

		children[selection].frame = 0
		selection = (selection + input) % 4
		children[selection].frame = 1
		
		soul.position = Vector2(positionArray[selection], 453)
		if Input.is_action_just_pressed("ui_accept"):
			print("acept button")
			get_parent().get_node("Select").play()
			select.emit(children[selection].name)
			print("el children selection es ", children[selection].name)

func disable(_selection: String):
	self.enabled = false
	select.disconnect(disable) # disconnect("select", Callable(self, "disable"))
	pass

func turn_off():
	for child in get_children():
		await get_tree().create_timer(0.1).timeout
		child.frame = 0
