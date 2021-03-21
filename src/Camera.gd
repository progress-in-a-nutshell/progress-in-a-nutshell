extends Camera2D

#Global and exported variables and constants
export(float) var camSpeed: float = 100.0;
export(float) var maxZoom: float = 10.0;
export(float) var minZoom: float = .1;
export(float) var zoomSpeed: float = .2;
export(float) var zoomTime: float = .2;

var defaultZoom: Vector2;
var targetZoom: float;
var crntZoom: float;
var zoomEaseTime: float;



func _ready():
	defaultZoom = zoom;
	targetZoom = 1;
	crntZoom = 1;

func _process(dt: float):
	#camera motion control
	var inputVector : Vector2 = Vector2.ZERO;
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	inputVector.y= Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
  #Position updates
	if inputVector != Vector2.ZERO: 
		position += camSpeed * dt * inputVector * zoom;
		if inputVector > Vector2(1,1) and inputVector < Vector2(0,0):
			position = position.normalized();

	get_tree().get_root().get_node("Node2D/TileMap").move_selection();
	
	#zoom ease
	if zoomEaseTime > 0:
		zoomEaseTime -= dt / zoomTime if zoomTime > 0 else 1.0;
		if zoomEaseTime < 0: zoom = defaultZoom * targetZoom;
		else: zoom = (defaultZoom * targetZoom).linear_interpolate(defaultZoom * crntZoom, zoomEaseTime * zoomEaseTime);

func setZoom(zoomIn: bool):
	crntZoom = zoom.x / defaultZoom.x;
	zoomEaseTime = 1;
	if zoomIn: targetZoom -= zoomSpeed;
	elif !zoomIn: targetZoom += zoomSpeed;
	targetZoom = clamp(targetZoom, minZoom, maxZoom);

func _input(e: InputEvent):
	#Camera Zooming
	# for a normal mouse
	if e is InputEventMouseButton:
		if e.is_pressed(): #We may have to use match or an enum here soon
			if (e.button_index == BUTTON_WHEEL_UP):
				setZoom(true);
			if (e.button_index == BUTTON_WHEEL_DOWN):
				setZoom(false);

	#for macos and touchpads
	if e is InputEventPanGesture:
		if(e.delta.y > 0.0):
			setZoom(true);
		if(e.delta.y < 0.0):
			setZoom(false);
