extends Node2D

var rotation_speed=PI
func _ready():
	pass
func _process(delta: float) -> void:
	rotation+=rotation_speed*delta
