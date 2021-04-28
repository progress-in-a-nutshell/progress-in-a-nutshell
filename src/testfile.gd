extends Node2D


func _ready():
	# var world := load_world();
	# world is false for now as we don't want saving and loading
	var world: bool = false
	if not world:
		randomize()
		$TileMap.generate(0, 0, 128)
		$ResourceTileMap.generate(0, 0, 128)


func save_world():
	var savefile: File = File.new()
	savefile.open("user://saved.map", File.WRITE)

	for c in $TileMap.get_used_cells():
		savefile.store_double(c.x)
		savefile.store_double(c.y)

		for x in range(32):
			for y in range(32):
				savefile.store_8(
					$TileMap.get_cell(x + c.x * 32, y + c.y * 32)
				)
				savefile.store_8(y + c.y * 32)
		savefile.close()


func load_world():
	var savefile: File = File.new()
	# check if savefile exists
	if not savefile.file_exists("user://saved.map"):
		return false
	savefile.open("user://saved.map", File.READ)

	while savefile.get_position() != savefile.get_len():
		var c = Vector2()
		c.x = savefile.get_double()
		c.y = savefile.get_double()
		$TileMap.set_cellv(c, 0)
		for x in range(32):
			for y in range(32):
				$TileMap.set_cell(
					x + c.x * 32, y + c.y * 32, savefile.get_8()
				)
	return true
