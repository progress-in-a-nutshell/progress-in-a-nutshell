extends Node

enum Properties{
	ResourceProduced
}


enum ResourceTypes{
	none = -1,
	energy = 0,
	wood = 1,
	food = 2,
	materials = 3
}

enum TileMapIDs{
	desert,
	plains,
	forest,
	water_shallow,
	water_deep,
	mountain
}


var tileProperties = {
	"0":[ResourceTypes.none],
	"1":[ResourceTypes.none],
	"2":[ResourceTypes.wood],
	"3":[ResourceTypes.food],
	"4":[ResourceTypes.food],
	"5":[ResourceTypes.materials]
	
	
}
