extends CharacterBody2D

@onready var ghost = preload("res://Shared/Soul/Ghost.tscn")

@export var currentFunction: String # (String, "", "red", "blue")

var speed = 190
var motion := Vector2.ZERO
var gravity = 3

var jump = Vector2(40, 240)

var inputList := [0, 0, 0, 0]
var input := Vector2.ZERO

var floor_rotation = 0.0

var main_scene

func _ready():
	main_scene = owner
	modulate = Color(1, 0, 0, 1)
	changeMovement(currentFunction)

func _physics_process(delta):
	if currentFunction:
		call(currentFunction, delta)

func changeMovement(value: String):
	var negate = ["", "still"]
	if !(currentFunction in negate) and !(value in negate):
		var ghost_inst = ghost.instantiate()
		self.add_child(ghost_inst)
	currentFunction = value

func still(_delta):
	set_velocity(Vector2.ZERO)
	move_and_slide()

func red(_delta):
	modulate = Color(1, 0, 0, 1)
	inputList = [
		int(Input.is_action_pressed("ui_right")),
		int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")),
		int(Input.is_action_pressed("ui_up")),
		]
	input.x = inputList[0] - inputList[1]
	input.y = inputList[2] - inputList[3]
	motion = speed * input
	set_velocity(motion)
	move_and_slide()

func blue(_delta):
	modulate = Color(0, 0, 1, 1)
	inputList = [
		int(Input.is_action_pressed("ui_right")),
		int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_up")),
		]
	if not is_on_floor():
		motion.y += gravity * 2
	input.x = inputList[0] - inputList[1]
	input.y = inputList[2]
	motion.x = speed * input.x

	if is_on_floor():
		motion.y = 0
		if inputList[2]:
			motion.y = - jump.y
	else:
		if not inputList[2] and motion.y < - jump.x:
			motion.y = - jump.x

	if is_on_ceiling() and motion.y < - jump.x:
		motion.y = - jump.x / 2.0
	
	set_velocity(motion)
	set_up_direction(Vector2.UP)
	move_and_slide()

func _on_body_entered(body):
	if body.is_in_group("damage"):
		hit(body.damage)
		body.queue_free()

func hit(damage = 0):
	Data.hp -= damage
	$Hurt.play()
	main_scene.emit_signal("shake_camera")
