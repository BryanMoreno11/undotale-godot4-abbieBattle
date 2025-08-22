extends Fight_Manager

# MAKE CUSTOM CUTSCENES AS YOU WISH
@onready var bone_tscn = preload("res://BattleEngine/Fight_Manager/Revenge Papyrus/Attacks/Bone.tscn")
@onready var bear_tscn = preload("res://BattleEngine/Fight_Manager/Abbie/Attacks/bear/bear.tscn")
@onready var cat_tscn= preload("res://BattleEngine/Fight_Manager/Abbie/Attacks/cat/cat.tscn")

var cutscene_counter = 0
var box

func cutscene(varbox: Control): #YOU CAN CHOOSE WHAT PARAMETERS TO PASS IN
	box = varbox
	soul.position = varbox.position + (varbox.size / 2)
	soul.changeMovement("still")
	match cutscene_counter:
		0:
			varbox.resize(Vector2(300,140), null, 1, 1, 1.5)
			$Abbie.bubble("Oh! Purple Girl!, I love your outfit! ")
			await $Abbie.blitter.next
			$Abbie/Bubble.visible = false
	
	emit_signal("cutscene_end")
	
func attack():
	var firstBearAttackXPostions=[50,100,150,200,250]
	var offsetX=50
	var secondBearAttackPositions=[box.global_position+Vector2(-offsetX,0 ), box.global_position+Vector2(box.size.x+offsetX,0),
	box.global_position+Vector2(-offsetX,box.size.y),box.global_position+Vector2(box.size.x+offsetX,box.size.y) ]
	var bearsSecondAttack=[]
	soul.changeMovement("red")
	##First Pattern
	for i in range(5):
		await get_tree().create_timer(0.05).timeout	
		var bear= bear_tscn.instantiate()
		box.attacks.add_child(bear)
		var xPosition= firstBearAttackXPostions[randi_range(0,len(firstBearAttackXPostions)-1)]
		bear.position= Vector2(xPosition, -90)
		firstBearAttackXPostions.erase(xPosition)
		await get_tree().create_timer(0.5).timeout	
		if bear:
			bear.motion=Vector2(0,300)
	#Second Pattern
	await get_tree().create_timer(1).timeout	
	for i in range(len(secondBearAttackPositions)):
		var bear= bear_tscn.instantiate()
		box.attacks.add_child(bear)
		bear.global_position=secondBearAttackPositions[i]
		bearsSecondAttack.append(bear)
	await get_tree().create_timer(0.5).timeout
	for bear in bearsSecondAttack:
		var direction= (soul.global_position-bear.global_position).normalized()
		var sped=250
		bear.motion=direction*sped
	#Third Pattern
	var time=0.0
	var amplitude=200.0
	var speed=-250
	await get_tree().create_timer(2).timeout
	var cat= cat_tscn.instantiate()
	box.attacks.add_child(cat)
	cat.global_position= box.global_position+Vector2(box.size.x+70,box.size.y/2 - amplitude/2)
	while cat:
		time+= get_process_delta_time()
		var y_movement= amplitude*sin(time*3.0)
		print("El y movement es ", y_movement)
		cat.motion= Vector2(speed,y_movement)
		await get_tree().process_frame

	await get_tree().create_timer(5).timeout
	box_adopts(soul, get_parent(), true)

	for child in box.attacks.get_children():
		child.queue_free()
	emit_signal("cutscene_end")

func box_adopts(node, from = self, reverse = false):
	if reverse and !from.has_node("Soul"):
		var node_pos = node.global_position 
		box.remove_child(node)
		from.add_child(node)
		node.global_position = node_pos
	elif !reverse and !box.has_node("Soul"):
		var node_pos = node.global_position 
		from.remove_child(node)
		box.add_child(node)
		node.global_position = node_pos
