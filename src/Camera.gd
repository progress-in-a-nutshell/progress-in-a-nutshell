extends Camera2D

#Global and exported variables and constants
export(float) var camSpeed := 1500.0;
export(float) var accelerateTime := .125;
export(float) var deaccelerateTime := .15;
const SCROLL_LIM: float = 0.1;
const ZOOMCAM:Vector2 = Vector2(SCROLL_LIM,SCROLL_LIM)*10;
var axis: Vector2;

func moveTowards(crnt: float, target: float, speed: float) -> float:
	var diff := target - crnt;
	if abs(diff) > speed: return crnt + sign(diff) * speed;
	return target;

func _process(dt: float):
	#camera motion control
	var rawAxis: Vector2;
	if Input.is_key_pressed(KEY_W): rawAxis.y -= 1.0;
	if Input.is_key_pressed(KEY_S): rawAxis.y += 1.0;
	if Input.is_key_pressed(KEY_D): rawAxis.x += 1.0;
	if Input.is_key_pressed(KEY_A): rawAxis.x -= 1.0;
	
	axis.x = moveTowards(axis.x, rawAxis.x, dt / accelerateTime if rawAxis.x != 0.0 else deaccelerateTime);
	axis.y = moveTowards(axis.y, rawAxis.y, dt / accelerateTime if rawAxis.x != 0.0 else deaccelerateTime);

	if axis.length_squared() > 1.0: axis = axis.normalized();

	transform.origin += axis * dt * camSpeed;

	get_tree().get_root().get_node("Node2D/TileMap").move_selection();

func _input(e):
	#Camera Zooming
	# for a normal mouse
	if e is InputEventMouseButton:
		if e.is_pressed(): #We may have to use match or an enum here soon
			if (e.button_index == BUTTON_WHEEL_UP):
				self.zoom += ZOOMCAM;
			if (e.button_index == BUTTON_WHEEL_DOWN):
				self.zoom -= ZOOMCAM;

	#for macos and touchpads
	if e is InputEventPanGesture:
		if(e.delta.y > 0.0):
			self.zoom += ZOOMCAM;
		if(e.delta.y < 0.0):
			self.zoom -= ZOOMCAM;
	#Zoom Limit
	zoom.x = clamp(zoom.x, 1.0, 100.0);
	zoom.y = clamp(zoom.y, 1.0, 100.0);