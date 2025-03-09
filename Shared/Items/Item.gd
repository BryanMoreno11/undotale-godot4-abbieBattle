class_name Item extends Node

var item_name := "Item"
var inventory_name := "Item"

func use() -> String:
	Data.hp += 1
	return "You used the " + item_name
