class Inventory:
	
	var resources = {
		"wood": 50
		# Init all resources in the game in here 
	}
	
	func getResourceAmount(name:String):
		return resources[name]
	
	
	func init():
		print("init")
