class GameResource:
	
	var name: String setget SetName, GetName
	var category: String setget SetCategory, GetCategory
	var description: String setget SetDescription, GetDescription
	var requiredResearch: Array setget SetRequiredResearch, GetRequiredResearch
	var unlocked: bool setget SetUnlocked, GetUnlocked
	
	func init(Name:String, category: String, description:String, requiredResearch:Array, unlocked:bool):
		self.name = name
		self.category = category
		self.description = description
		self.requiredResearch = requiredResearch
		self.unlocked = unlocked

	# getter & setter ( name:String )
	func SetName(value: String):
		name = value
	func GetName():
		return name # Getter must return a value.

	# getter & setter ( category: String )
	func SetCategory(value: String):
		category = value
	func GetCategory():
		return category # Getter must return a value.
	
	# getter & setter ( description:String )
	func SetDescription(value: String):
		description = value
	func GetDescription():
		return description # Getter must return a value.
	
	# getter & setter ( requiredResearch:Array )
	func SetRequiredResearch(value: Array):
		requiredResearch = value
	func GetRequiredResearch():
		return requiredResearch # Getter must return a value.

		# getter & setter ( unlocked:Array )
	func SetUnlocked(value: bool):
		unlocked = value
	func GetUnlocked():
		return unlocked
