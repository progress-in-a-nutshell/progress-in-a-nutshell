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
			tiles[x][y] = GenerateTile(x, y)
			tiles[x][y].UpdateTileTexture(self,width,height)
	update_bitmask_region()


# uses the noise value to select what Textures should be placed where
# here is where "rules" regarding terrain generation should be applied

func GenerateTile(x, y):
	var noise = simplex.get_noise_2d(float(x), float(y))
	if noise <= 0.05:
		return tileClass.Tile.new("tile namee", "description", "normal",Vector2(x,y), TILE_TEXTURES.water, "owner", "status")
	if noise <= 0.08: 
		return tileClass.Tile.new("tile namee", "description", "normal",Vector2(x,y), TILE_TEXTURES.sand, "owner", "status")
	if noise <= 0.25: 
		return tileClass.Tile.new("tile namee", "description", "normal",Vector2(x,y), TILE_TEXTURES.light_grass, "owner", "status")
	if noise <= 0.40: 
		return tileClass.Tile.new("tile namee", "description", "normal",Vector2(x,y),TILE_TEXTURES.dark_grass, "owner", "status")
	if noise <= 1:
		return tileClass.Tile.new("tile namee", "description", "normal",Vector2(x,y), TILE_TEXTURES.stone, "owner", "status")

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

# gets rid of double clicks registering for now
var clicked = 0

# Handles mouse input / movement related events
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if clicked % 2 == 0:
				var x = world_to_map(get_global_mouse_position()).x
				var y = world_to_map(get_global_mouse_position()).y
				tiles[x][y].Clicked()
			clicked += 1
	elif event is InputEventMouseMotion:
		# print(world_to_map(get_global_mouse_position()));

		pass

# gets called when the game starts
func _on_TileMap_ready():
	Init2DTileArray()
	InitSimplexNoiseValues()
	GenerateWorld()
