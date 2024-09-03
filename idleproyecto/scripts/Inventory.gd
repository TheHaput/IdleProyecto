# Inventory.gd
extends Node  # Or use a non-Node resource if it's just data

var items: Array = []

func add_item(item: Item) -> void:
	items.append(item)

func remove_item() -> Item:
	if items.size() > 0:
		return items.pop_front()
	return null
