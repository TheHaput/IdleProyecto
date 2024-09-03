extends Node2D


var conveyor_nodes = []
var iron_resource
var copper_resource

func _ready():
	# Referencia al nodo Conveyor
	for child in get_children():
		if "Conveyor" in child.name:
			conveyor_nodes.append(child)

	iron_resource = preload("res://resources/IronResource.tres")
	copper_resource = preload("res://resources/Copper.tres")
	
	# Llamar a la función add_item en el Conveyor nada mas carga la escena
	#conveyor.add_item(iron_resource)
	
	# Start timer that creates ores every X seconds
	var timer = Timer.new()
	timer.wait_time = 1.5  # Añadir un nuevo iron_resource cada 2 segundos
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	timer.start()
		
func _on_timer_timeout():
	print_debug("Timer timeout")
	# Llamar a add_item repetidamente
	for i in range(conveyor_nodes.size()):
		var conveyor = conveyor_nodes[i]
		# Si es un numero par
		if i % 2 == 0:
			conveyor.add_item(iron_resource)
		else:
			conveyor.add_item(copper_resource)
