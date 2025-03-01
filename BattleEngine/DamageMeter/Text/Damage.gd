extends Node2D

func _ready():
	if int($Label.text) > 0:
		$Label.set("theme_override_colors/font_color", Color(1,0,0,1))
		$AudioStreamPlayer.play()
	position.x = -($Label.size.x / 2.0) + global_position.x
	$AnimationPlayer.play("jump")

func _on_animation_finished(_anim_name):
	$AnimationPlayer.stop()
	queue_free()
