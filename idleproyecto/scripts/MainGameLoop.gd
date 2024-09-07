extends Node2D

var conveyor_scene
var conveyors = []
var money = 0
var warehouse = Warehouse.new()

func _ready():
	#Carga al escena conveyor
	conveyor_scene = preload("res://scenes/conveyor.tscn")
	for conveyor in get_tree().get_nodes_in_group("Conveyors"):
		conveyors.append(conveyor)
	#Boton de comprar nueva linea
	var button = $GUI/VBoxContainer2/Button 
	button.connect("pressed", on_buy_line_button_press)
	
func _on_conveyor_sell_item(item: Item) -> void:
	money += item.value
	$GUI/Labels/MoneyLabel.text = "Money: %d" %money
	
func _on_conveyor_store_item(item: Item) -> void:
	warehouse.add_item(item)
	$GUI/Labels/IronLabel.text = "Iron: %d" %warehouse.items["Iron"]

func on_buy_line_button_press():
	const new_conveyor_price = 100
	
	#Si no tiene dinero paramos la funcion con return
	if money <= new_conveyor_price:
		print("No tienes dinero")
		return 
	
	#Quitamos el dinero
	money -= new_conveyor_price 
	$GUI/Labels/MoneyLabel.text = "Money: %d" %money
	const conveyor_margin = 5
	#Instanciamos el conveyor, lo hacemos un nodo.
	var conveyor_instance = conveyor_scene.instantiate()
	var conveyor_names = []
	
	
	#Guardar en un array los nombres de los conveyors ya existentes
	for conveyor in $FactoryManager.get_children():
		conveyor_names.append(int(str(conveyor.name)))
		
	
	
	#Coger el numero mas alto del array
	var last_conveyor_name = conveyor_names.max()
	#Coje el nodo que corresponde al numero mas alto
	var last_conveyor_node = get_node("FactoryManager/%d" %last_conveyor_name)
	var conveyor_position = last_conveyor_node.position
	
	conveyor_instance.name = str(last_conveyor_name + 1)
	#Creamos nuevo nodo del conveyor
	last_conveyor_node.add_sibling(conveyor_instance)
	#Coje la posicion del ultimo conveyor y su altura multiplicado por la escala y lo suma al conveyor padre para dejar un hueco
	conveyor_instance.position.y = last_conveyor_node.position.y + last_conveyor_node.texture.get_height() * last_conveyor_node.scale.y + conveyor_margin
	
