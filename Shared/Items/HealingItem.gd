class_name HealingItem extends Item

var hp := 5
var healingSound := preload("res://Shared/Soul/snd_heal_c.wav")
var audioPlayer = AudioStreamPlayer.new()

func _init(_name: String, _inventory_name: String, _hp: int):
	item_name = _name
	inventory_name = _inventory_name
	hp = _hp
	audioPlayer.stream = healingSound

func use() -> String:
	add_child(audioPlayer)
	Data.hp = min(Data.hp + hp, Data.maxhp)
	audioPlayer.play()
	return "You ate the " + item_name
