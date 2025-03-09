extends Control

func _ready():
	$Left/Name.text = Data.human
	$Left/LV.text = str(Data.lv)
	$Middle/ProgressBar.max_value = Data.maxhp
	$Middle/ProgressBar.custom_minimum_size.x = Data.maxhp + 5
	$Middle/MaxHP.text = str(Data.maxhp)

func _process(_delta):
	# $Middle/ProgressBar.value = lerp($ProgressBar.value, float(max(Data.hp, 0)), 0.1)
	$Middle/ProgressBar.value = float(max(Data.hp, 0))
	$Middle/CurrentHP.text = str(max(Data.hp, 0))
