class Requirement:
	
	var type: String
	var name: String
	var amount: int
	
	func init(type: String, name:String, amount:int = 1):
		self.type = type
		self.name = name
		self.amount = amount
	
	func RequirementsCompleted():
		match type:
			"research":
				return ResearchRequirementCheck()
			"resource":
				return ResourceRequirementCheck()
		return true
	
	func ResourceRequirementCheck():
		# pass logic here for the check
		return false
	func ResearchRequirementCheck():
		# pass logic here for the check
		return false
