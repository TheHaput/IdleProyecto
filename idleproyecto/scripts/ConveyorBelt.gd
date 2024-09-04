# Conveyor.gd
extends Node2D

# Maybe this will need to be connected through code in _ready() when conveyors are created through code
signal sell_item(item: Item)
signal store_item(item: Item)

var items := []
var item_sprites := []
var item_spawn_timer: Timer
var items_to_store_percentage: int = 20 # TODO do these through the UI later
var is_storing: bool = true 

# Constants
const ITEM_TYPE = preload("res://resources/IronResource.tres") # TODO This will be assigned by the main game loop
const SPAWN_FREQUENCY = 0.5
const MOVEMENT_SPEED = 20

func _ready():
	# Create a timer 
	item_spawn_timer = Timer.new()
	item_spawn_timer.wait_time = SPAWN_FREQUENCY
	item_spawn_timer.autostart = true
	add_child(item_spawn_timer)
	item_spawn_timer.connect("timeout", _on_item_spawn_timeout)

func _on_item_spawn_timeout():
	add_item(ITEM_TYPE)

func _process(_delta):
	move_items()

func add_item(item: Item):
	# Create a sprite for the item
	var sprite = Sprite2D.new()
	sprite.texture = item.sprite
	sprite.position = Vector2.ZERO
	sprite.scale = Vector2(0.1, 0.1)
	
	# Add the item to the queue and scene
	items.append(item)
	item_sprites.append(sprite)
	add_child(sprite)

func move_items():
	var indices_to_remove = []
	
	for i in range(item_sprites.size()):
		var sprite = item_sprites[i]
		sprite.position.x += MOVEMENT_SPEED * get_process_delta_time()
		# TODO bring back later check_machine_interaction(item_sprites[sprite])
		
		if is_at_end_of_line(sprite):
			if is_for_storage():
				emit_signal("store_item", items[i])
			else:
				emit_signal("sell_item", items[i])
			
			indices_to_remove.append(i)
	
	# Remove items from the arrays after iteration
	if indices_to_remove != null:
		#indices_to_remove.reverse()
		for i in indices_to_remove:
			items.remove_at(i)
			item_sprites.remove_at(i)
		
func check_machine_interaction(sprite: Sprite2D):
	# Check if an item should interact with a machine along the conveyor
	for machine in get_tree().get_nodes_in_group("Machines"):
		if sprite.position.distance_to(machine.position) < 3:
			machine.interact_with_conveyor(self)

func is_at_end_of_line(sprite: Sprite2D) -> bool:
	# Logic for when an item reaches the end of the conveyor
	if sprite.position.x > get_viewport_rect().size.x:
		sprite.queue_free()  # Remove the sprite from the scene
		return true
	
	return false

func is_for_storage() -> bool:
	var random_number = randi_range(1, 100)
	if random_number <= items_to_store_percentage:
		return true
	return false
	
