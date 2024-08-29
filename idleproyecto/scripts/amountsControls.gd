extends Control

var copperAmount := 0

var money := 0

var moneyLabel

var oreLabel 


func _ready():
	moneyLabel = $VBoxContainer/MoneyLabel
	oreLabel = $VBoxContainer/OreLabel

func _on_timer_timeout():
	copperAmount += 1
	updateOreLabel()

func _on_button_pressed():
	sell()
	## int to string 
	moneyLabel.text = "Money: %d" %money 

func sell():
	money += copperAmount * 3
	copperAmount = 0
	updateOreLabel()

func updateOreLabel():
	oreLabel.text ="Ore: %d" %copperAmount
