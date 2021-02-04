extends Camera2D

#Global and exported variables and constants
export var CAM_VEL : int = 600;
const SCROLL_LIM : float = 0.1;
const ZOOMCAM:Vector2 = Vector2(SCROLL_LIM,SCROLL_LIM)*10;

func _ready():
  pass

func _process(dt):
  #Motion controls. Thanks to HeartBeast
  var input_vector : Vector2 = Vector2.ZERO;

  input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
  input_vector.y= Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");

  #Position updates
  if input_vector != Vector2.ZERO: 
    position += CAM_VEL * dt * input_vector * zoom;

  get_tree().get_root().get_node("Node2D/TileMap").move_selection();


func _input(e):
  #Camera Zooming
  # for a normal mouse
  if e is InputEventMouseButton:
    if e.is_pressed(): #We may have to use match or an enum here soon
      if (e.button_index == BUTTON_WHEEL_UP):
        zoomfunc(0);
      if (e.button_index == BUTTON_WHEEL_DOWN):
        zoomfunc(1);

  #for macos and touchpads
  if e is InputEventPanGesture:
        if(e.delta.y > 0):
            zoomfunc(0)
        if(e.delta.y < 0):
            zoomfunc(1)

  #Zoom Limit
  zoom.x = clamp(zoom.x, 1, 100);
  zoom.y = clamp(zoom.y, 1, 100);
  
#ABSTRACTION
func zoomfunc(var x):
  match x:
    0:
      self.zoom -= ZOOMCAM;
    1:
      self.zoom += ZOOMCAM;
