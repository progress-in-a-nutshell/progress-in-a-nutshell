class Player:
	var knowledge: Object
	var inventory:	Object
	
	func _init():
		inventory = preload("res://src/game_scripts/classes/Inventory.gd").Inventory.new()
