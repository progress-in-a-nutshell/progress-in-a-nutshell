class Player:
	
	var knowledge: Object setget SetKnowledge, GetKnowledge
	var inventory:	Object setget SetInventory, GetInventory
	
	func _init():
		inventory = preload("res://src/game_scripts/classes/Inventory.gd").Inventory.new()
	
	# getter & setter ( knowledge:Object )
	func SetKnowledge(value: Object):
		knowledge = value
	func GetKnowledge():
		return knowledge # Getter must return a value.
	
	# getter & setter ( inventory:Object )
	func SetInventory(value: Object):
		inventory = value
	func GetInventory():
		return inventory # Getter must return a value.
