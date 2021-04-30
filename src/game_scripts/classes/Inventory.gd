class Inventory:
	
	var resources = {
		# Init all resources in the game in here 
	}
	
	func getResourceAmount(name:String):
		return resources[name]
	
	func init():
		print("init")
