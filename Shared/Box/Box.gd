class_name GameCombatBox extends Control

@export var border = 5

@onready var attacks = $Attacks
@onready var shapes = $Collisions

func _ready():
	#resize(Vector2(100,100), 0)
	pass

func _process(_delta):
	update_size()
	pass

func update_size():
	shapes.get_child(0).position.x = -100 + border
	shapes.get_child(1).position.y = -100 + border
	shapes.get_child(2).position.y = self.size.y + 100 - border
	shapes.get_child(3).position.x = self.size.x + 100 - border

func resize(dimension: Vector2, newpos = null, top = 1, bot = 1, time = 1.5):
	var tween := get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "size", Vector2(dimension.x, dimension.y), time)

	match top:
		0:
			print("a")
			pass
		1:
			tween.tween_property(self, "position:y", self.position.y + ((size.y - dimension.y) / 2.0), time)
		2:
			tween.tween_property(self, "position:y", self.position.y + ((size.y - dimension.y)), time)
	match bot:
		0:
			pass
		1:
			tween.tween_property(self, "position:x", self.position.x + ((size.x - dimension.x) / 2.0), time)
		2:
			tween.tween_property(self, "position:x", self.position.x + ((size.x - dimension.x)), time)
	
	if newpos != null:
		tween.tween_property(self, "position", newpos, time + 0.1)

func move(newpos: Vector2, time = 1.0):
	var tween := get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", newpos, time)

func add_attack(node):
	attacks.add_child(node)
