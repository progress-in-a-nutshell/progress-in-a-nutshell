extends "Tile.gd"

class BuildingTile:
	
	var remaining:int 		setget  SetRemaining, GetRemaining
	var level:int 			setget  SetLevel, GetLevel
	var max_level:int 		setget  SetMaxLevel, GetMaxLevel
	var level_cost:int 		setget  SetLevelCost, GetLevelCost


	
	# The constructor for this class
	# Is used when making a instance of this class and has as purpose
	# To initilize its varibles
	func _init(remaining:int, level:int, max_level:int, level_cost:int):
		self.remaining = remaining
		self.level = level
		self.max_level = max_level
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
	
	# getter & setter ( max_level:Int)
	func SetLevelCost(value: int ):
		level_cost = value
	func GetLevelCost():
		return level_cost
