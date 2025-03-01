extends Node2D

var stopped : bool = false

signal slaughter(intensity: float)
signal enemys_turn

func _ready():
	$AnimationPlayer.play_backwards("Out")

func _process(delta):
	if not stopped:
		$Bar.position.x += 350 * delta
		if (Input.is_action_just_pressed("ui_accept") or $Bar.position.x > 280):
			hit()

func hit():
	stopped = true
	slaughter.emit(float(0.3 + 0.7 / max(1, abs($Bar.position.x) / 25.))) # to improve ...
	$Bar.play()
	await get_tree().create_timer(2).timeout
	disappear()

func disappear():
	emit_signal("enemys_turn")
	$Bar.queue_free()
	$AnimationPlayer.play("Out")

func _on_animation_finished(_anim_name):
	if get_node_or_null("Bar") == null:
		queue_free()
