class Inventory:
	
	var ResourceClass = preload("res://src/game_scripts/classes/GameResource.gd").GameResource
	
	var resources = {
		"wood" : ResourceClass.new("wood" , "this is wood", null,true),
		"food" : ResourceClass.new("food" , "this is food", null,true),
		"stone": ResourceClass.new("stone", "this is stone",null,true)
	}
	
	var resourceAmounts = {
		"wood" : 100,
		"food" : 100,
		"stone": 100
	}

	func GetResourceAmount(name:String):
		return resourceAmounts[name]

	func AddResourceAmount(name:String, amount:int):
		resourceAmounts[name] += amount

	func SubstractResourceAmount(name:String, amount:int):
		resourceAmounts[name] -= amount
