extends Sprite2D # Keep extending Sprite2D since it's still the root node

var slot_count = 10
var slot_width = 25
var conveyor_y_position = 0
var slot_speed = 2.4
var conveyor_slots = []
var item_sprites = []

func _ready():
	# Initialize conveyor slots and item sprites
	var item_container = $ItemContainer # Reference to the ItemContainer Node2D
	for i in range(slot_count):
		conveyor_slots.append(null)
		var sprite_instance = Sprite2D.new()
		sprite_instance.visible = false # Initially invisible
		item_sprites.append(sprite_instance)
		item_container.add_child(sprite_instance) # Add to ItemContainer

	start_conveyor()

func start_conveyor():
	var timer = Timer.new()
	timer.wait_time = slot_speed
	timer.connect("timeout", _move_items)
	add_child(timer)
	timer.start()

func _move_items():
	# Shift items to the right, from the last slot to the first
	for i in range(slot_count - 1, 0, -1):
		conveyor_slots[i] = conveyor_slots[i - 1]
	conveyor_slots[0] = null # First slot gets new item or stays empty
	update_display()

func add_item(item: ResourceData):
	conveyor_slots[0] = item # Place a new item in the first slot
	update_display()

func update_display():
	# Update the item sprites based on conveyor_slots
	for i in range(slot_count):
		if conveyor_slots[i]:
			item_sprites[i].texture = conveyor_slots[i].sprite
			item_sprites[i].position = Vector2(i * slot_width, conveyor_y_position) # Adjust position based on slot index
			item_sprites[i].scale = Vector2(0.125, 0.3)
			print_debug(item_sprites[i].position)
			item_sprites[i].visible = true
		else:
			item_sprites[i].visible = false
