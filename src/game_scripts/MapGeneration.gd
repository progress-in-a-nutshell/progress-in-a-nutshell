tool
extends TileMap

# used only to call redraw function in the editor
# to see the generated terrain without starting game
export(bool)  var redraw setget redraw

#the width and heigh of the map that wil be generated
export(int)   var map_w         = 64
export(int)   var map_h         = 64



func redraw(value):
	if !Engine.is_editor_hint(): return
	generate(0, 0, 64)

func generate(cx, cy, len_):
	for x in range(len_):
		for y in range(len_):
			set_cell(x, y, 5 * x / len_)


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
