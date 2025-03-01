extends HBoxContainer

func _ready():
	$Name.text = Data.human
	$LV.text = str(Data.lv)
	$ProgressBar.max_value = Data.maxhp
	$HP/HBoxContainer/MaxHP.text = str(Data.maxhp)


func _process(_delta):
	# $ProgressBar.value = lerp($ProgressBar.value, float(max(Data.hp, 0)), 0.1)
	$ProgressBar.value = float(max(Data.hp, 0))
	$HP/HBoxContainer/CurrentHP.text = str(max(Data.hp, 0))
