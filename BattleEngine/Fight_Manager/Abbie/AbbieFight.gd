extends Fight_Manager

# MAKE CUSTOM CUTSCENES AS YOU WISH

@onready var bone_tscn = preload("res://BattleEngine/Fight_Manager/Revenge Papyrus/Attacks/Bone.tscn")
@onready var bear_tscn = preload("res://BattleEngine/Fight_Manager/Abbie/Attacks/bear.tscn")


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
			
		#bear.position.x=initialPositionBear+(initialPositionBear*randf_range(1,6))
		#bear.position.y=50
		#bear.global_position= Vector2(xPosition, box.size.y-100)
		
		#var bone = bone_tscn.instantiate()
		#bone.motion = Vector2(100,0)
		#bone.switch_from("bot")
		#box.attacks.add_child(bone)
		#bone.global_position = box.global_position + Vector2(-30, box.size.y - 16)
		#bone.visual.size.y = 30
		
	#soul.changeMovement("blue")
	#box_adopts(soul, get_parent())
	#box.move(Vector2.ZERO)
	#for i in range(3):
		#var bone = bone_tscn.instantiate()
		#bone.motion = Vector2(100,0)
		#bone.switch_from("bot")
		#box.attacks.add_child(bone)
		#bone.global_position = box.global_position + Vector2(-30, box.size.y -16)
		#bone.visual.size.y = 30
		#await get_tree().create_timer(1).timeout
	#
	#box.resize(Vector2(575,140), Vector2(33,250), 1, 1, 0.8)
#
	#for i in range(5):
		#var bone = bone_tscn.instantiate()
		#bone.motion = Vector2(100,0)
		#bone.switch_from("bot")
		#box.attacks.add_child(bone)
		#bone.global_position = box.global_position + Vector2(-30, box.size.y - 16)
		#bone.visual.size.y = 30
		#await get_tree().create_timer(1).timeout
		#box_adopts(soul, get_parent(), true)
		#box.resize(Vector2(box.size.x - 100, 140), null, 0, 1)
	
	await get_tree().create_timer(1).timeout
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
