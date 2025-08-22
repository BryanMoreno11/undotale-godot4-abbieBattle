extends CharacterBody2D
@export var damage = 15

var from = ""
var motion = Vector2(0,0)
var save_size = 11
var save_position = 0
@onready var visual=$Bear

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	move_and_collide(motion*delta)
	pass
	
	
