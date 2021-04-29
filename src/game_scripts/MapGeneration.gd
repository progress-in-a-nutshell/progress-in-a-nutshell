tool
extends TileMap

# used only to call redraw function in the editor
# to see the generated terrain without starting game
export(bool)  var redraw setget redraw

#the width and heigh of the map that wil be generated
export(int)   var width  = 1024
export(int)   var height = 1024

# SimplexNoise varibles used in generation
export(float)   var octaves = 4.25
export(float)   var period = 270
export(float)   var lacunarity = 3.5
export(float)   var persistance = 0.35

# initilization of SimplexNoise class
var simplex = OpenSimplexNoise.new()

# Used to track Tile user is pointing to
var lastTile := Vector2(-1, -1)

# Tile related classes
var tileClass = preload("res://src/game_scripts/classes/Tile.gd")
var resourceTileClass = preload("res://src/game_scripts/classes/ResourceTile.gd")
var buildingTileClass = preload("res://src/game_scripts/classes/BuildingTile.gd")

# 2D array of classes to help with tile related classes
var tiles = [[]]

# Enum of texture names and index 
var TILE_TEXTURES = {
	"stone": 0,
	"dark_grass": 1,
	"light_grass":2 ,
	"sand": 3,
	"water": 4
}

# Used in editor to redraw the World generation
func redraw(value):
	if !Engine.is_editor_hint(): return
	Init2DTileArray()
	InitSimplexNoiseValues()
	GenerateWorld()

# Used to generate the world with the SimplexNoise varibles above
func GenerateWorld():
	for x in width:
		for y in height:
			#tiles[x][y] = tileClass.Tile.new("tile namee", "description", "normal",Vector2(x,y), 5 * x / map_size, "owner", "status")
			#tiles[x][y].UpdateTileTexture(self)
			set_cellv(Vector2(x - width / 2, y - height / 2), GenerateTile(GetNoise(x,y)))
	update_bitmask_region()
	print("water " + str(water))
	print("sand " + str(sand))
	print("light_grass " + str(light_grass))
	print("dark_grass " + str(dark_grass))
	print("stone " + str(stone))

# returns the noise value used to simplify getting noise
func GetNoise(x, y):
	return simplex.get_noise_2d(float(x), float(y))

# uses the noise value to select what Textures should be placed where
# here is where "rules" regarding terrain generation should be applied
var water = 0
var sand = 0
var light_grass = 0
var dark_grass = 0
var stone = 0

func GenerateTile(noise):
	if noise <= 0.05:  
		return	TILE_TEXTURES.water
	if noise <= 0.08: 
		return TILE_TEXTURES.sand
	if noise <= 0.25: 
		return TILE_TEXTURES.light_grass
	if noise <= 0.40: 
		return TILE_TEXTURES.dark_grass
	if noise <= 1:
		return TILE_TEXTURES.stone

# Used to initilize the 2D tile array
func Init2DTileArray():
		for x in width:
			tiles.resize(width)
			for y in height:
				tiles[x] = []
				tiles[x].resize(height)

# initilizes simplexnoise its values
func InitSimplexNoiseValues():
	randomize()
	simplex.seed = randi()
	
	simplex.octaves = octaves
	simplex.period = period
	simplex.lacunarity = lacunarity
	simplex.persistence = persistance

# Handles mouse input / movement related events
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#  print("Mouse Click/Unclick at: ", event.position)
		pass
	elif event is InputEventMouseMotion:
		# print(world_to_map(get_global_mouse_position()));
		move_selection()
		pass

# Highlights what tile a user is hovering on
func move_selection():
	var pos := world_to_map(get_global_mouse_position())
	if lastTile != pos:
		var cell: int = get_cell(pos.x, pos.y)
		var lastCell: int = get_cell(lastTile.x, lastTile.y)

		set_cell(lastTile.x, lastTile.y, lastCell - 6)

		lastTile = pos
		set_cell(pos.x, pos.y, cell + 6)


func _on_TileMap_ready():
	Init2DTileArray()
	InitSimplexNoiseValues()
	GenerateWorld()
