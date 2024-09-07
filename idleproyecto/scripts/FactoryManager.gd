extends Node

class_name FactoryManager

var conveyor_scene = preload("res://scenes/conveyor.tscn")

func _ready():
	
	pass
	
func calculate_last_conveyor_name() -> int:
	var conveyor_names = []
	
	#Guardar en un array los nombres de los conveyors ya existentes
	for conveyor in get_children():
		conveyor_names.append(int(str(conveyor.name)))
		
	#Coger el numero mas alto del array
	var last_conveyor_name = conveyor_names.max()
	return last_conveyor_name
	
func create_new_conveyor():
	#Coje el nodo que corresponde al numero mas alto
	var last_conveyor_name = calculate_last_conveyor_name()
	var last_conveyor_node = get_node("%d" %last_conveyor_name)
	#Instanciamos el conveyor, lo hacemos un nodo.
	var conveyor_instance = conveyor_scene.instantiate()
	
	conveyor_instance.name = str(last_conveyor_name + 1)
	#Creamos nuevo nodo del conveyor
	last_conveyor_node.add_sibling(conveyor_instance)
	#Coje la posicion del ultimo conveyor y su altura multiplicado por la escala y lo suma al conveyor padre para dejar un hueco
	const conveyor_margin = 5
	conveyor_instance.position.y = last_conveyor_node.position.y + last_conveyor_node.texture.get_height() * last_conveyor_node.scale.y + conveyor_margin
	
	return conveyor_instance
