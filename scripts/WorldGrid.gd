extends TileMap

signal tileClicked

# Declare member variables here. Examples:
# var a = 2
# var b = "text"




func getClickedCellID(position):
	return get_cellv(world_to_map(position))
	
func getResourceID(cellID):
	return TileProperties.tileProperties[str(cellID)][TileProperties.Properties.ResourceProduced]
	

func _ready():
	generate(5, 5, 5)



func _input(event):
	if Input.is_action_pressed("ui_left_click"):
		emit_signal("tileClicked", getResourceID(getClickedCellID(get_global_mouse_position())))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




# BEWARE! TEST FUNCTION! Swap the functions if you want random terrain.
func generate(cx, cy, len_):
	for x in range(len_):
		for y in range(len_):
			set_cell(x, y, 5 * x / len_);

func generate_actually(cx, cy, len_):
	#Terrain generation
	if(get_cell(cx, cy) >= 0): return; # checking for existing tiles
	set_cell(cx, cy, 0);
	# noise tweaks for now
	var noise := OpenSimplexNoise.new();
	noise.seed = randi();
	noise.octaves = 5;
	noise.persistence = 0.2;
  
	for x in range(len_):
		for y in range(len_):
			set_cell(x + cx * 32, y + cy * 32, noise.get_noise_2d(x + cx * 32, y + cy * 32) * 3 + 3);
