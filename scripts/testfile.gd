extends Node2D

export var CAM_VEL = 600;

var noise = OpenSimplexNoise.new();

func _ready():
	var world = load_world(); 
	if not world:
		randomize();
		for x in range(2):
			for y in range(2):
				generate(x, y);

func generate(cx, cy):
	print("poggers")
	# if($TileMap.get_cell(cx, cy) >= 0): return; # checking for no tiles
	$TileMap.set_cell(cx, cy, 0);
	for x in range(32):
		for y in range(32):
			$TileMap.set_cell(x + cx * 32, y + cy * 32, noise.get_noise_2d(x + cx * 32, y + cy * 32) * 4 + 4);


func _process(dt):
	if(Input.is_action_pressed("ui_left")):
		$Camera2D.position.x -= CAM_VEL * dt;
	if(Input.is_action_pressed("ui_right")):
		$Camera2D.position.x += CAM_VEL * dt;
	if(Input.is_action_pressed("ui_up")):
		$Camera2D.position.y -= CAM_VEL * dt;
	elif(Input.is_action_pressed("ui_down")):
		$Camera2D.position.y += CAM_VEL * dt;

func save_world():
	var savefile = File.new();
	savefile.open("user://saved.map", File.WRITE);
	for c in $TileMap.get_used_cells():
		savefile.store_double(c.x);
		savefile.store_double(c.y);
		for x in range(32):
			for y in range(32):
				savefile.store_8(x + c.x * 32, y + c.y * 32);
	savefile.close();

func load_world():
	var savefile = File.new();
	# check if savefile exists
	if not savefile.file_exists("user://saved.map"): return false;
	savefile.open("user://saved.map", File.READ);	
	while savefile.get_position() != savefile.get_len():
		var c = Vector2();
		c.x = savefile.get_double();
		c.y = savefile.get_double();
		$TileMap.set_cellv(c, 0);
		for x in range(32):
			for y in range(32):
				$TileMap.set_cell(x + c.x * 32, y + c.y * 32, savefile.get_8())
		return true;

