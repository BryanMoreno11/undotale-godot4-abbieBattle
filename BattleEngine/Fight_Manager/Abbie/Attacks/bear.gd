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
	
#func _physics_process(delta: float) -> void:
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("El oso ha salido de la pantalla")
	queue_free()
	pass 
