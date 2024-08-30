extends Control

# Amounts
var copperAmount := 0
var ironAmount := 0
var money := 0

# Labels
var moneyLabel
var ironLabel
var copperLabel

# Resources
var copperResource: ResourceData
var ironResource: ResourceData

func _ready():
    copperResource = preload("res://resources/Copper.tres")
    ironResource = preload("res://resources/Iron.tres")
    print_debug("Iron and copper values: " + str(ironResource.value) + " " + str(copperResource.value))
    

    moneyLabel = $VBoxContainer/MoneyLabel
    ironLabel = $VBoxContainer/IronLabel
    copperLabel = $VBoxContainer/CopperLabel

func _on_timer_timeout():
    copperAmount += 1
    ironAmount += 2
    updateLabels()

func _on_button_pressed():
    sell()
    ## int to string 
    moneyLabel.text = "Money: %d" % money

func sell():
    money += copperAmount * copperResource.value + ironAmount * ironResource.value
    copperAmount = 0
    ironAmount = 0
    updateLabels()

func updateLabels():
    ironLabel.text = "Iron: %d, total value: %d" % [ironAmount, ironAmount * ironResource.value]
    copperLabel.text = "Copper: %d, total value: %d" % [copperAmount, copperAmount * copperResource.value]
