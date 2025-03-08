extends Node2D

func _ready():
	$AnimationPlayer.play("slice")

func _on_animation_finished(_anim_name):
	$AnimationPlayer.stop()
	queue_free()

func random_rotation():
	rotation_degrees = randf_range(0, 360)
