extends Node2D

var conveyors = []
var money = 0

func _ready():
	# Referencia al nodo Conveyor
	for conveyor in get_tree().get_nodes_in_group("Conveyors"):
		conveyors.append(conveyor)

func _on_conveyor_sell_item(item: Item) -> void:
	money += item.value
	update_gui()

func update_gui():
	var money_label = $GUI/Labels/MoneyLabel
	money_label.text = "Money: %d" %money
