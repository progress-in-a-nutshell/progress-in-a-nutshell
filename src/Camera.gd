extends Camera2D

export var camSpeed : float = 720.0
# export var accelerateTime : float= .125
# export var deaccelerateTime : float= .15

var mouseInFocus : bool = false
const SCROLL_LIM : float = 0.1
const ZOOMCAM: Vector2 = (
	Vector2(SCROLL_LIM, SCROLL_LIM)
	* 10
)

func _process(dt: float):
	# camera motion control, VERY optimized :P
	position += (
		(
			Vector2(
					int(Input.is_action_pressed("ui_right"))
						- int(Input.is_action_pressed("ui_left")),
					int(Input.is_action_pressed("ui_down"))
						- int(Input.is_action_pressed("ui_up"))
			)
		).normalized()
		* camSpeed
		* self.zoom
		* dt
	)

	# FIRST check if we've already moved
	# we don't want to add to position twice
	# TODO: optimize lol
	if(
		not int(Input.is_action_pressed("ui_right"))
			- int(Input.is_action_pressed("ui_left"))
		and not int(Input.is_action_pressed("ui_down"))
			- int(Input.is_action_pressed("ui_up"))
		and mouseInFocus
	):
		# XXX: do we need mouse stuff all the time?
		# maybe just when fullscreen?
		# XXX: should we implement a limit to mouse-controlled move?
		var mousepos := get_viewport().get_mouse_position()
		var viewrect := get_viewport_rect().size
		var mousevec : Vector2

		# added mouse controls, if mouse is within 1/8th
		# of the screen bounds
		if mousepos.x < viewrect.x / 7.5: mousevec.x = -0.1
		elif mousepos.x > viewrect.x * 7 / 7.5: mousevec.x = 0.1
		if mousepos.y < viewrect.y / 7.5: mousevec.y = -1
		elif mousepos.y > viewrect.y * 7 / 7.5: mousevec.y = 0.1
		position += (camSpeed * (mousevec * self.zoom * dt).normalized())/25

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

func _notification(notif):
	match(notif):
		NOTIFICATION_WM_MOUSE_EXIT: mouseInFocus = false
		NOTIFICATION_WM_MOUSE_ENTER: mouseInFocus = true
	# check if mouse outise window
