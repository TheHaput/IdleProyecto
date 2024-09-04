extends Resource

class_name Warehouse
# Contains {"name" : totalValue}
var items: Dictionary = {}

func add_item(item: Item) -> void:
	if items.has(item.name):
		items[item.name] += item.value
	else:
		items[item.name] = item.value

func remove_items(item_type: String, quantity: int):
	if items.has(item_type):
		items[item_type] -= quantity
		if items[item_type] <= 0:
			items.erase(item_type)  # Remove the item type if no items left
