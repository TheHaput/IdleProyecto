extends Node2D

# Conveyor settings
var slot_count = 10  # Number of slots on the conveyor
var slot_speed = 1.0  # Time between movements in seconds
var slot_width = 64  # Width of each slot, adjust based on your setup
var conveyor_y_position = 200  # Y position of the conveyor belt

# Conveyor state
var conveyor_slots = [] # Array to store items on the conveyor

func _ready():
    conveyor_slots.resize(slot_count)
    for i in range(slot_count):
        conveyor_slots[i] = null  # Initialize all slots as empty

    start_conveyor()

func start_conveyor():
    var timer = Timer.new()
    timer.wait_time = slot_speed
    timer.connect("timeout", _move_items)
    add_child(timer)
    timer.start()

func _move_items():
    # slot_count - 1 to avoid out of bounds access (array begins at 0)
    # Begins at last element and goes backward
    for i in range(slot_count - 1, 0, -1):
        conveyor_slots[i] = conveyor_slots[i - 1] # Shift items to the right
    conveyor_slots[0] = null  # First slot gets new item or stays empty
    update_display()

func add_item(item: ResourceData):
    conveyor_slots[0] = item  # Place a new item in the first slot

func update_display():
    # Remove all existing children (previous item sprites)
    for child in get_children():
        if child is Sprite2D:
            child.queue_free()

    # Visualize the items moving on the conveyor
    for i in range(slot_count):
        if conveyor_slots[i]:
            var sprite_instance = Sprite2D.new()
            sprite_instance.texture = conveyor_slots[i].sprite
            sprite_instance.position = Vector2(i * slot_width, conveyor_y_position)
            add_child(sprite_instance)
