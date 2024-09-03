# Conveyor.gd
extends Node2D

var items := []
var item_sprites := []
var item_spawn_timer: Timer

# Constants
const ITEM_TYPE = preload("res://resources/IronResource.tres") # TODO This will be assigned by the main game loop
const SPAWN_FREQUENCY = 1.5
const MOVEMENT_SPEED = 10

func ready():
	# Create a timer 
	item_spawn_timer = Timer.new()
	item_spawn_timer.wait_time = SPAWN_FREQUENCY
	item_spawn_timer.autostart = true
	add_child(item_spawn_timer)
	item_spawn_timer.connect("timeout", _on_item_spawn_timeout)

func _on_item_spawn_timeout():
	var new_item = ITEM_TYPE.new()
	add_item(new_item)

func _process(delta):
	move_items()

func add_item(item: Item):
	# Create a sprite for the item
	var sprite = Sprite2D.new()
	sprite.texture = item.sprite
	sprite.position = Vector2.ZERO
	sprite.scale = Vector2(0.125, 0.3)
	
	# Add the item to the queue and scene
	items.append(item)
	item_sprites.append(sprite)
	add_child(sprite)

func get_item() -> Item:
	# Remove the sprite and return the item data
	if items.size() > 0:
		item_sprites.pop_front().queue_free()
		return items.pop_front()

	return null

func move_items():
	# Logic to move items along the conveyor
	for sprite in item_sprites:
		sprite.position.x += MOVEMENT_SPEED * get_process_delta_time()
		check_machine_interaction(sprite)
		check_end_of_line(sprite)
		
func check_machine_interaction(sprite: Sprite2D):
	# Check if an item should interact with a machine along the conveyor
	for machine in get_tree().get_nodes_in_group("Machines"):
		if sprite.position.distance_to(machine.position) < 3:  # Example proximity check
			machine.interact_with_conveyor(self)

func check_end_of_line(sprite: Sprite2D):
	# Logic for when an item reaches the end of the conveyor
	if sprite.position.x > get_viewport_rect().size.x:
		sprite.queue_free()  # Remove the sprite from the scene
		item_sprites.erase(sprite)  # Remove the sprite from the array
		# TODO sell or store in warehouse
		
