extends Node2D

var conveyors = []
var money = 0
var warehouse = Warehouse.new()

func _ready():
	for conveyor in get_tree().get_nodes_in_group("Conveyors"):
		conveyors.append(conveyor)

func _on_conveyor_sell_item(item: Item) -> void:
	money += item.value
	$GUI/Labels/MoneyLabel.text = "Money: %d" %money
	
func _on_conveyor_store_item(item: Item) -> void:
	warehouse.add_item(item)
	$GUI/Labels/IronLabel.text = "Iron: %d" %warehouse.items["Iron"]
