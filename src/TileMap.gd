extends TileMap

# last tile hover stuff
var lastTile : Vector2 = Vector2(0, 0);

func _ready():
  pass;

func _input(event):
  # Mouse in viewport coordinates.
  if (event is InputEventMouseButton):
    #  print("Mouse Click/Unclick at: ", event.position)
    pass;
  elif (event is InputEventMouseMotion):
    # print(world_to_map(get_global_mouse_position()));
    move_selection();
    pass;


func move_selection():
  var pos : Vector2 = world_to_map(get_global_mouse_position());
  if(lastTile != pos):
    var cell : int = get_cell(pos.x, pos.y);
    var lastCell : int = get_cell(lastTile.x, lastTile.y);

    set_cell(lastTile.x, lastTile.y, lastCell - 6);

    lastTile = pos;
    set_cell(pos.x, pos.y, cell + 6);

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
  var noise : OpenSimplexNoise = OpenSimplexNoise.new();
  noise.seed = randi();
  noise.octaves = 5;
  noise.persistence = 0.2;
  
  
  for x in range(len_):
    for y in range(len_):
      set_cell(x + cx * 32, y + cy * 32, noise.get_noise_2d(x + cx * 32, y + cy * 32) * 3 + 3);
