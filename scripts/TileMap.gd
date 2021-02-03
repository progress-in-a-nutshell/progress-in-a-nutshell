extends TileMap

# last tile hover stuff
var lastTile : Vector2 = Vector2(0, 0);
var tileType : int = -1;

func _ready():
  pass;

func _input(event):
  # Mouse in viewport coordinates.
  if (event is InputEventMouseButton):
    #  print("Mouse Click/Unclick at: ", event.position)
    pass;
  elif (event is InputEventMouseMotion):
    # print(world_to_map(get_global_mouse_position()));
    set_cell(lastTile.x, lastTile.y, tileType);
    lastTile = world_to_map(get_global_mouse_position());
    tileType = get_cell(lastTile.x, lastTile.y);
    set_cell(lastTile.x, lastTile.y, 0);
    pass;


func generate(cx, cy, len_):
  print("poggers");
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
  tileType = get_cell(0, 0);
