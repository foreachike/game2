extends Sprite2D
var viewport

const START = preload("uid://cog6jybcii07d")
const MAIN = preload("uid://dbu4bctvgkyiq")
const GAMEOVER = preload("uid://dlhexnk2qnsyg")

const CROSSHAIR = preload("uid://bw0cy0qfkc0ai")
const CURSOR = preload("uid://ckpcbh6uqxug0")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 100
	viewport = get_viewport()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mousePos = viewport.get_mouse_position()
	global_position = mousePos
	
	var current := get_tree().current_scene
	if current:
		if current.scene_file_path in [START.resource_path, GAMEOVER.resource_path]:
			texture = CURSOR
		else:
			texture = CROSSHAIR
