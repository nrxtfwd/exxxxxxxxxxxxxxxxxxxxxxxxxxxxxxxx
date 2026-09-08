extends Camera2D

# Panning configuration
var is_panning: bool = false
var pan_start_position: Vector2 = Vector2.ZERO

# Zoom configuration
@export var min_zoom: float = 0.5
@export var max_zoom: float = 3.0
@export var zoom_speed: float = 0.1
@export var zoom_smoothness: float = 10.0

var target_zoom: Vector2 = Vector2.ONE

func _ready() -> void:
	target_zoom = zoom

func _unhandled_input(event: InputEvent) -> void:
	# Panning controls (Left Mouse Button)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_panning = true
			pan_start_position = event.position
		else:
			is_panning = false

	if event is InputEventMouseMotion and is_panning:
		# Move the camera in the opposite direction of the mouse drag
		position -= (event.position - pan_start_position) / zoom.x
		pan_start_position = event.position

	# Zooming controls (Mouse Scroll Wheel)
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_zoom += Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_zoom -= Vector2(zoom_speed, zoom_speed)

		# Clamp zoom level within bounds
		target_zoom.x = clamp(target_zoom.x, min_zoom, max_zoom)
		target_zoom.y = clamp(target_zoom.y, min_zoom, max_zoom)

func _process(delta: float) -> void:
	# Smoothly interpolate current zoom towards target zoom
	zoom = zoom.lerp(target_zoom, zoom_smoothness * delta)
