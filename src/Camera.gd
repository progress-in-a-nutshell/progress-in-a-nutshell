extends Camera2D

export (float) var camSpeed := 720.0
# export(float) var accelerateTime := .125    
# export(float) var deaccelerateTime := .15    

const SCROLL_LIM: float = 0.1
const ZOOMCAM: Vector2 = (
	Vector2(SCROLL_LIM, SCROLL_LIM)
	* 10
)


func _process(dt: float):
	# camera motion control, VERY optimised :P
	position += (
		Vector2(
				int(Input.is_action_pressed("ui_right")) 
					- int(Input.is_action_pressed("ui_left")), 
				int(Input.is_action_pressed("ui_down")) 
					- int(Input.is_action_pressed("ui_up"))
			).normalized()
		* camSpeed
		* self.zoom
		* dt
	)


func _input(e):
	# Camera Zooming
	# for a normal mouse
	if e is InputEventMouseButton:
		# we may have to use match or an enum here soon
		if e.is_pressed():
			if e.button_index == BUTTON_WHEEL_UP:
				self.zoom -= ZOOMCAM
			elif e.button_index == BUTTON_WHEEL_DOWN:
				self.zoom += ZOOMCAM
	# for macos and touchpads
	if e is InputEventPanGesture:
		if e.delta.y > 0.0:
			self.zoom -= ZOOMCAM
		elif e.delta.y < 0.0:
			self.zoom += ZOOMCAM
	zoom.x = clamp(zoom.x, 1.0, 100.0)
	zoom.y = clamp(zoom.y, 1.0, 100.0)
