extends Node2D

@onready var kitchen: Node2D = $"../KitchenP"
@onready var music: Node2D = $"../MusicP"
@onready var drink: Node2D = $"../DrinkP"
@onready var dMeter: ProgressBar = $"../CanvasLayer/drinkBar"
@onready var mMeter: ProgressBar = $"../CanvasLayer/musicBar"
@onready var fMeter: ProgressBar = $"../CanvasLayer/foodBar"

var prevPos := 0
var pos := 0
var d := 50.0
var m := 50.0
var f := 50.0
var pizzas: int

signal moved

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	prevPos = pos
	if Input.is_action_pressed("ui_right"):
		pos = 1
	elif Input.is_action_pressed("ui_left"):
		pos = -1
	else:
		pos = 0
	
	_move()
	d = _drain(d, 5 * delta, dMeter)
	m = _drain(m, 6 * delta, mMeter)
	f = _drain(f, 4 * delta, fMeter)
	
	if pos == 0:
		if not m >= 50:
			m += 18 * delta
		
		if pizzas > 0 and Input.is_action_just_pressed("ui_down"):
			pizzas -= 1
			if f + 10 > 50:
				f = 50
			else:
				f += 10
	
	if pos == -1:
		if not d >= 50:
			d += 18 * delta
	
	
	if pos != prevPos:
		moved.emit()
	
func _move():
	if pos == 1:
		global_position = kitchen.global_position
	elif pos == -1:
		global_position = drink.global_position
	else:
		global_position = music.global_position

func _drain(meter, dps: float,visual: ProgressBar):
	if not meter <= 0:
		meter -= dps
	visual.value = meter
	return meter
