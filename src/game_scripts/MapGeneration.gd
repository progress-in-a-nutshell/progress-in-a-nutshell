tool
extends GridMap

# used only to call redraw function in the editor
# to see the generated terrain without starting game
export(bool)  var redraw setget redraw

#the width and heigh of the map that wil be generated
export(int)   var width  = 128
export(int)   var height = 128
export(int)   var depth = 2

# SimplexNoise varibles used in generation
export(float)   var octaves = 4
export(float)   var period = 270
export(float)   var lacunarity = 3.5
export(float)   var persistance = 0.35

# initilization of SimplexNoise class
var simplex = OpenSimplexNoise.new()

# Used to track Tile user is pointing to
var lastTile := Vector3(-1, -1, -1)

# Tile related classes
var tileClass = preload("res://src/game_scripts/classes/Tile.gd")
var resourceTileClass = preload("res://src/game_scripts/classes/ResourceTile.gd")
var buildingTileClass = preload("res://src/game_scripts/classes/BuildingTile.gd")

# 3D array of classes to help with tile related classes
var tiles = [[[]]]

# Enum of texture names and index 
var TILE_TEXTURES = {
	"stone": 0,
	"dark_grass": 1,
	"light_grass":2 ,
	"sand": 3,
	"water": 4,
	"hut": 12
}

# Used in editor to redraw the World generation
func redraw(value):
	if !Engine.is_editor_hint(): return
	Init3DTileArray()
	InitSimplexNoiseValues()
	GenerateWorld()

# Used to generate the world with the SimplexNoise varibles above
func GenerateWorld():
	for x in width:
		for y in height:
			for z in depth:
				tiles[x][y] = GenerateTile(x, y, z)
	for x in width:
		for y in height:
			for z in depth:
				tiles[x][y].UpdateTileTexture(self)


# uses the noise value to select what Textures should be placed where
# here is where "rules" regarding terrain generation should be applied

func GenerateTile(x, y, z):
	randomize()
	var noise = simplex.get_noise_2d(x, y)
	if noise <= 0.05:
		return tileClass.Tile.new("water", "description", "normal",Vector3(x,z,y), TILE_TEXTURES.water, "owner", "status")
	if noise <= 0.08: 
		return buildingTileClass.BuildingTile.new(0,0,0,0, "building namee", "description", "normal",Vector3(x,z,y), TILE_TEXTURES.sand, "owner", "status")
	if noise <= 0.25: 
		var random:int = rand_range(0,100)
		if int(random) <= 1:
			return buildingTileClass.BuildingTile.new(0,0,0,0, "Hut ", "description", "normal",Vector3(x,z,y), TILE_TEXTURES.hut, "owner", "status")
		return tileClass.Tile.new("light_grass", "description", "normal",Vector3(x,z,y), TILE_TEXTURES.light_grass, "owner", "status")
	if noise <= 0.40: 
		return tileClass.Tile.new("dark_grass", "description", "normal",Vector3(x,z,y),TILE_TEXTURES.dark_grass, "owner", "status")
	if noise <= 1:
		return tileClass.Tile.new("Stone", "description", "normal",Vector3(x,z,y), TILE_TEXTURES.stone, "owner", "status")

# Used to initilize the 2D tile array
func Init3DTileArray():
		for x in width:
			tiles.resize(width)
			for y in height:
				tiles[x] = []
				tiles[x].resize(height)
				for z in depth:
					tiles[x][y] = []
					tiles[x][y].resize(depth)

# initilizes simplexnoise its values
func InitSimplexNoiseValues():
	randomize()
	simplex.seed = randi()
	
	simplex.octaves = octaves
	simplex.period = period
	simplex.lacunarity = lacunarity
	simplex.persistence = persistance

# gets rid of double clicks registering for now
var clicked = 0

# Handles mouse input / movement related events
#func _input(event):
	# Mouse in viewport coordinates.
	#if event is InputEventMouseButton:
		#if event.button_index == 1:
			#if clicked % 2 == 0:
				#var x = GetRealMousePosition().x
				#var y = GetRealMousePosition().y
			#	var z = GetRealMousePosition().z
			#	tiles[x][y][z].Clicked()
			#clicked += 1
	#elif event is InputEventMouseMotion:
	#	move_selection()
		#pass


#func move_selection():
	#var pos = GetRealMousePosition()
	#if lastTile != pos:
		#var cell: int = get_cell_item(pos.x, pos.y, pos.z)
		#var lastCell: int = get_cell_item(lastTile.x, lastTile.y, lastTile.z)
		#set_cell_item(lastTile.x, lastTile.y, lastTile.z, lastCell - 6)

		#lastTile = pos
		#set_cell_item(pos.x, pos.y, pos.z, cell + 6)
# gets called when the game starts
func _on_TileMap_ready():
	Init3DTileArray()
	InitSimplexNoiseValues()
	GenerateWorld()

func GetRealMousePosition():
	return Vector3(get_viewport().get_mouse_position().x - 63, get_viewport().get_mouse_position().y - 18, 1)
