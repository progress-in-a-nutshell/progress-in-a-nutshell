extends Node

# The tile class is used to define any 2d position on the map
# and give it attributes 
class Tile:
	
	var name: String 			setget  SetName, GetName
	var description: String 	setget  SetDescription, GetDescription
	var type:String 			setget  SetType, GetType
	var position: Vector2 		setget  SetPosition, GetPosition
	var texture: Texture3D 		setget  SetTexture, GetTexture
	var owner:String 			setget  SetOwner, GetOwner
	var status:String 			setget  SetStatus, GetStatus

	
	# The constructor for this class
	# Is used when making a instance of this class and has as purpose
	# To initilize its varibles
	func _init(name: String, description: String, type:String, position:Vector2, texture:Texture3D, owner:String, status:String):
		self.name = name
		self.description = description
		self.type = type
		self.position = position
		self.texture = texture
		self.owner = owner
		self.status = status
		
	# getter & setter ( name:String )
	func SetName(value: String):
		name = value
	func GetName():
		return name # Getter must return a value.
	
	# getter & setter ( description:String )
	func SetDescription(value: String):
		description = value
	func GetDescription():
		return description # Getter must return a value.
	
	# getter & setter ( type: String )
	func SetType(value: String):
		type = value
	func GetType():
		return type # Getter must return a value.
	
	# getter & setter ( position:Vector2 )
	func SetPosition(value: Vector2):
		position = value
	func GetPosition():
		return position # Getter must return a value.
	
	# getter & setter ( texture: Texture3D )
	func SetTexture(value: Texture3D):
		texture = value
	func GetTexture():
		return texture # Getter must return a value.
	
	# getter & setter ( Owner:String/ENUM )
	func SetOwner(value: String):
		owner = value
	func GetOwner():
		return owner # Getter must return a value.
	
	# getter & setter ( status:String/ENUM )
	func SetStatus(value: String ):
		status = value
	func GetStatus():
		return status # Getter must return a value.
	
