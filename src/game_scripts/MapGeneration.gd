tool
extends TileMap

# used only to call redraw function in the editor
# to see the generated terrain without starting game
export(bool)  var redraw setget redraw

#the width and heigh of the map that wil be generated
export(int)   var map_size  = 5

var tileClass = preload("res://src/game_scripts/classes/tile.gd")

var tiles = [[]]

func redraw(value):
	if !Engine.is_editor_hint(): return
	for x in map_size:
		tiles.resize(map_size)
		for y in map_size:
			tiles[x] = []
			tiles[x].resize(map_size)
	generate(0, 0, map_size)

func generate(cx, cy, len_):
	for x in range(len_):
		for y in range(len_):
			tiles[x][y] = tileClass.Tile.new("tile name", "description", "normal",Vector2(x,y), 1, "owner", "status")
			print(tiles[x][y])
			set_cell(x, y, 1)


var lastTile := Vector2(-1, -1)


func _ready():
	pass


func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#  print("Mouse Click/Unclick at: ", event.position)
		pass
	elif event is InputEventMouseMotion:
		# print(world_to_map(get_global_mouse_position()));
		move_selection()
		pass


func move_selection():
	var pos := world_to_map(get_global_mouse_position())
	if lastTile != pos:
		var cell: int = get_cell(pos.x, pos.y)
		var lastCell: int = get_cell(lastTile.x, lastTile.y)

		set_cell(lastTile.x, lastTile.y, lastCell - 6)

		lastTile = pos
		set_cell(pos.x, pos.y, cell + 6)


func create_2d_array(width, height, value):
	var a = []

	for y in range(height):
		a.append([])
		a[y].resize(width)

		for x in range(width):
			a[y][x] = value

	return a
