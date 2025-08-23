class_name PlayerSoul extends CharacterBody2D

@onready var ghost = preload("res://Shared/Soul/Ghost.tscn")

@export var currentFunction: String # (String, "", "red", "blue")

var speed := 170
var motion := Vector2.ZERO
var gravity := 6 * 60

var jump = Vector2(40, 240)

var inputList := [0, 0, 0, 0]
var input := Vector2.ZERO

var floor_rotation = 0.0

var main_scene

func _ready():
	main_scene = owner
	modulate = Color.WEB_PURPLE
	changeMovement(currentFunction)

func _process(delta: float):
	if currentFunction:
		inputList = [
			int(Input.is_action_pressed("ui_right")),
			int(Input.is_action_pressed("ui_left")),
			int(Input.is_action_pressed("ui_down")),
			int(Input.is_action_pressed("ui_up")),
		]
		input.x = inputList[0] - inputList[1]
		input.y = inputList[2] - inputList[3]
		call(currentFunction, delta)

func changeMovement(value: String):
	#updateColor(value) No cambio el color del alma, se mantiene en morado
	var negate = ["", "still"]
	if !(currentFunction in negate) and !(value in negate):
		var ghost_inst = ghost.instantiate()
		self.add_child(ghost_inst)
	currentFunction = value

func updateColor(value: String):
	if (value == "red"): modulate = Color(1, 0, 0, 1)
	if (value == "blue"): modulate = Color(0, 0, 1, 1)

func still(_delta):
	set_velocity(Vector2.ZERO)
	move_and_slide()

func red(_delta):
	motion = speed * input
	set_velocity(motion)
	move_and_slide()

func blue(delta: float):
	if not is_on_floor():
		motion.y += gravity * delta
		if (inputList[2]):
			motion.y += gravity * delta

	motion.x = 190 * input.x

	if is_on_floor():
		motion.y = 0
		if inputList[3]:
			motion.y = - jump.y
	else:
		if not inputList[3] and motion.y < - jump.x:
			motion.y = - jump.x

	if is_on_ceiling() and motion.y < - jump.x:
		motion.y = - jump.x / 2.0
	
	set_velocity(motion)
	set_up_direction(Vector2.UP)
	move_and_slide()

func _on_body_entered(body):
	print("El grupo del body que entro es", body.get_groups())
	if body.is_in_group("damage"):
		hit(body.damage)
		body.queue_free()
	if body.is_in_group("damageNotDisappear"):
		hit(body.damage)

func hit(damage = 0):
	var finalDamage := int(max(damage - Data.def / 5., 0))
	Data.hp = max(Data.hp - finalDamage, 0)
	if (damage > 0):
		$Hurt.play()
		main_scene.emit_signal("shake_camera")
