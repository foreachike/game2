extends Sprite2D
var viewport
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport = get_viewport()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mousePos = viewport.get_mouse_position()
	global_position = mousePos
