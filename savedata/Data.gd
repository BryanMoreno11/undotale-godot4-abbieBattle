extends Node

var human := "PLAYER"
var lv := 20
var maxhp := 90
var hp := maxhp
var items := [
	HealingItem.new("Monster Candy", 10),
	HealingItem.new("Monster Candy", 10),
	HealingItem.new("Spider Donut", 12),
	HealingItem.new("Spider Donut", 12),
	HealingItem.new("Spider Cider", 24),
	HealingItem.new("Spider Cider", 24),
	HealingItem.new("Butterscotch Pie", 999),
]
var weapon := "Real Knife"
var armor := "Old Tutu"
var atk := 20
var def := 10

func read():
	pass
