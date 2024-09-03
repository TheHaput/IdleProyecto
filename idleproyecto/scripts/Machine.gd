extends Node2D

class_name Machine
#var inventory = preload("res://Inventory.gd").new()

func process_item(item: Item) -> Item:
	# Logic to transform the item
	var transformed_item = item
	transformed_item.value *= 1.5  # Example: Increase value by 50%
	return transformed_item

func interact_with_conveyor(conveyor) -> void:
	var item = conveyor.get_item()  # Get the item from the conveyor
	if item:
		var new_item = process_item(item)
		print_debug("Item processed")
		#conveyor.add_item(new_item)  # Place the transformed item back on the conveyor
