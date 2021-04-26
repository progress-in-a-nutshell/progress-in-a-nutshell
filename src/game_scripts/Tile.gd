extends Node

# The tile class is used to define any 2d position on the map
# and give it attributes 
class Tile:
	
	var name: String 			setget  SetName, GetName
	var description: String 	setget  SetDescription, GetDescription
	var type:int 				setget  SetType, GetType
	var position: Vector2 		setget  SetPosition, GetPosition
	var texture 				setget  SetTexture, GetTexture
	var owner 					setget  SetOwner, GetOwner
	var status 					setget  SetStatus, GetStatus

	
	# The constructor for this class
	# Is used when making a instance of this class and has as purpose
	# To initilize its varibles
	func _init(name: String, description: String,type:int, position:Vector2, texture, owner, status):
		self.name = name
		self.description = description
		self.type = type
		self.position = position
		self.texture = texture
		self.owner = owner
		self.status = status
		
	# getter & setter ( name:String )
	func SetName(value):
		name = value
	func GetName():
		return name # Getter must return a value.
	
	# getter & setter ( description:String )
	func SetDescription(value):
		description = value
	func GetDescription():
		return description # Getter must return a value.
	
	# getter & setter ( type )
	func SetType(value):
		type = value
	func GetType():
		return type # Getter must return a value.
	
	# getter & setter ( position:Vector2 )
	func SetPosition(value):
		position = value
	func GetPosition():
		return position # Getter must return a value.
	
	# getter & setter ( texture )
	func SetTexture(value):
		texture = value
	func GetTexture():
		return texture # Getter must return a value.
	
	# getter & setter ( Owner )
	func SetOwner(value):
		owner = value
	func GetOwner():
		return owner # Getter must return a value.
	
	# getter & setter ( status )
	func SetStatus(value):
		status = value
	func GetStatus():
		return status # Getter must return a value.
	
