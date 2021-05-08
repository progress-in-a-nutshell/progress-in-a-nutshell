extends Camera

export var camSpeed : float = 720.0
# export var accelerateTime : float = .125
# export var deaccelerateTime : float = .15

var mouseInFocus : bool = true
var mouseVec : Vector2
export var mouseCamSpeed : float = 360.0

const SCROLL_LIM : float = 0.1
const ZOOMCAM: Vector2 = Vector2(1, 1) * SCROLL_LIM * 10

func _init():
	# simple trick to make mouse be inside the window at the beginning
	# to avoid issues with mouseVec
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# _process(dt: float):
	# camera motion control, quite optimized :P
	#position += (
	#	(
		#	Vector2(
		#			int(Input.is_action_pressed("ui_right"))
		#				- int(Input.is_action_pressed("ui_left")),
		#			int(Input.is_action_pressed("ui_down"))
		#				- int(Input.is_action_pressed("ui_up"))
		#	)
		#).normalized()
		#* camSpeed
		#* self.zoom
		#* dt
	#)
	#position += mouseVec.normalized() * mouseCamSpeed * self.zoom * dt

#func _input(e):
	## Camera Zooming for a normal mouse
	##if e is InputEventMouseButton:
		# we may have to use match or an enum here soon
	#	if e.is_pressed():
		#	if e.button_index == BUTTON_WHEEL_UP:
		#		self.zoom -= ZOOMCAM
		#	elif e.button_index == BUTTON_WHEEL_DOWN:
		#		self.zoom += ZOOMCAM
	# moved from _process as this is more optimized
	#elif e is InputEventMouseMotion:
	#	mouseVec = Vector2(0, 0)
		# FIRST check if we've already moved
		# we don't want to add to position twice
		# TODO: optimize lol
		#if(
		#	not int(Input.is_action_pressed("ui_right"))
			#	- int(Input.is_action_pressed("ui_left"))
			#and not int(Input.is_action_pressed("ui_down"))
			#	- int(Input.is_action_pressed("ui_up"))
		#	and mouseInFocus
		#):
			# XXX: do we need mouse stuff all the time?
			# maybe just when fullscreen?
			# XXX: should we implement a limit to mouse-controlled move?
			#var mousepos := get_viewport().get_mouse_position()
			#var viewrect := get_viewport_rect().size

			# added mouse controls, if mouse is within 1/8th
			# of the screen bounds
			#if mousepos.x < viewrect.x / 7.5: mouseVec.x = -0.1
			#elif mousepos.x > viewrect.x * 7 / 7.5: mouseVec.x = 0.1
			#if mousepos.y < viewrect.y / 7.5: mouseVec.y = -1
			#elif mousepos.y > viewrect.y * 7 / 7.5: mouseVec.y = 0.1
	# for macos and touchpads
	#elif e is InputEventPanGesture:
		#if e.delta.y > 0.0:
	#		self.zoom -= ZOOMCAM
		#elif e.delta.y < 0.0:
		#	self.zoom += ZOOMCAM
		#zoom.x = clamp(zoom.x, 1.0, 100.0)
		#zoom.y = clamp(zoom.y, 1.0, 100.0)


#func _notification(notif):
	# check if mouse outside window
	#match(notif):
		#NOTIFICATION_WM_MOUSE_EXIT: mouseInFocus = false
		#NOTIFICATION_WM_MOUSE_ENTER: mouseInFocus = true
