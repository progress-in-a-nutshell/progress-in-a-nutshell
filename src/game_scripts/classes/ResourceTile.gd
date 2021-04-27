extends "Tile.gd"

# The tile class is used to define any 2d position on the map
# and give it attributes 
class ResourceTile:

	var remaining:int 		setget  SetRemaining, GetRemaining
	var level:int 			setget  SetLevel, GetLevel
	var max_level:int 		setget  SetMaxLevel, GetMaxLevel
	var output:int 			setget  SetOutput, GetOutput
	var resource 			setget  SetResource, GetResource
	var level_cost:int 		setget  SetLevelCost, GetLevelCost
	
	# The constructor for this class
	# Is used when making a instance of this class and has as purpose
	# To initilize its varibles
	func _init(remaining:int, level:int, max_level:int, output:int, resource, level_cost:int):
		self.remaining = remaining
		self.level = level
		self.max_level = max_level
		self.output = output
		self.resource = resource
		self.level_cost = level_cost
		
	# getter & setter ( remaining:Int)
	func SetRemaining(value: int ):
		remaining = value
	func GetRemaining():
		return remaining # Getter must return a value.
	
	# getter & setter ( level:Int)
	func SetLevel(value: int ):
		level = value
	func GetLevel():
		return level
	
	# getter & setter ( max_level:Int)
	func SetMaxLevel(value: int ):
		max_level = value
	func GetMaxLevel():
		return max_level
	
	# getter & setter ( output:Int)
	func SetOutput(value: int ):
		output = value
	func GetOutput():
		return output
	
	# getter & setter ( resource:Int)
	func SetResource(value ):
		resource = value
	func GetResource():
		return resource
	
	# getter & setter ( level_cost:Int)
	func SetLevelCost(value: int ):
		level_cost = value
	func GetLevelCost():
		return level_cost
