extends CharacterBody2D
@export var damage = 15

var motion = Vector2(0,0)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	move_and_collide(motion*delta)
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("El helado ha salido de la pantalla")
	pass 
