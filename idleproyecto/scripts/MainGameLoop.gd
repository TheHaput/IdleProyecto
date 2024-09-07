extends Node2D

var conveyors = []
var money = 0
var warehouse = Warehouse.new()
var factory_manager 
const new_conveyor_price = 100


func _ready():
	factory_manager = $FactoryManager
	
	for conveyor in get_tree().get_nodes_in_group("Conveyors"):
		conveyors.append(conveyor)
	#Boton de comprar nueva linea
	$GUI/VBoxContainer2/Button.connect("pressed", on_buy_line_button_press)
	
func _on_conveyor_sell_item(item: Item) -> void:
	money += item.value
	$GUI/Labels/MoneyLabel.text = "Money: %d" %money
	
func _on_conveyor_store_item(item: Item) -> void:
	warehouse.add_item(item)
	$GUI/Labels/IronLabel.text = "Iron: %d" %warehouse.items["Iron"]

func on_buy_line_button_press():
	if !try_take_money():
		return 
	
	var new_conveyor = factory_manager.create_new_conveyor()
	new_conveyor.connect("sell_item", _on_conveyor_sell_item)
	new_conveyor.connect("store_item", _on_conveyor_store_item)
	
func try_take_money() -> bool:
	#Si no tiene dinero paramos la funcion con return
	if money <= new_conveyor_price:
		print("No tienes dinero")
		return false
		
	#Quitamos el dinero
	money -= new_conveyor_price 
	$GUI/Labels/MoneyLabel.text = "Money: %d" %money
	return true
	
