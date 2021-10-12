extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var barResourceTypes = [
	TileProperties.ResourceTypes.energy,
	TileProperties.ResourceTypes.wood,
	TileProperties.ResourceTypes.food,
	TileProperties.ResourceTypes.materials
]


func _addResources(resourceAdded):
	if resourceAdded != TileProperties.ResourceTypes.none:
		self.get_child(barResourceTypes.find(resourceAdded)).get_child(0).value += 1




# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
