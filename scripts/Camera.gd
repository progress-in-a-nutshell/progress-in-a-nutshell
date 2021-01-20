extends Camera2D

export var CAM_VEL : int = 600;
export var SCROLL_LIM : float = 0.1;

func _ready():
  pass

func _process(dt):
  var input_vector : Vector2 = Vector2.ZERO;
  input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
  input_vector.y= Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
  if input_vector != Vector2.ZERO: 
    osition += CAM_VEL * dt * input_vector * zoom;

    # var size : Vector2 = get_viewport_rect().size;
    # if(position.x - size.x / 2 > limit_left and position.x + size.x / 2 < limit_right):
    #   position.x += CAM_VEL * dt * input_vector.x * zoom.x;
    # if(position.y - size.y / 2 > limit_top and position.y + size.y / 2 < limit_bottom):
    #   position.y += CAM_VEL * dt * input_vector.y * zoom.y;

func _input(e):
  if e is InputEventMouseButton:
    if e.is_pressed():
      if (e.button_index == BUTTON_WHEEL_UP):
        self.zoom -= Vector2(SCROLL_LIM, SCROLL_LIM);
      if (e.button_index == BUTTON_WHEEL_DOWN):
        self.zoom += Vector2(SCROLL_LIM, SCROLL_LIM);
  #for macos
  if e is InputEventPanGesture:
        if(e.delta.y > 0):
            self.zoom -= Vector2(SCROLL_LIM, SCROLL_LIM);
        if(e.delta.y < 0):
            self.zoom += Vector2(SCROLL_LIM, SCROLL_LIM);
  zoom.x = clamp(zoom.x, 0.1, 200);
  zoom.y = clamp(zoom.y, 0.1, 200);
