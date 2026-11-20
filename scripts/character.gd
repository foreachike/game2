extends Node2D

@onready var kitchen: Node2D = $"../KitchenP"
@onready var music: Node2D = $"../MusicP"
@onready var drink: Node2D = $"../DrinkP"
@onready var dMeter: ProgressBar = $"../CanvasLayer/drinkBar"
@onready var mMeter: ProgressBar = $"../CanvasLayer/musicBar"
@onready var fMeter: ProgressBar = $"../CanvasLayer/foodBar"
@onready var chomp: AudioStreamPlayer2D = $"../MusicP/chomp"
@onready var scoreLabel: Label = $"../CanvasLayer/scoreLabel"

const GAMEOVER = preload("uid://dlhexnk2qnsyg")

var prevPos := 0
var pos := 0
var d := 50.0
var m := 50.0
var f := 50.0
var pizzas: int
var score := 0.0
var shown_score := 0.0

const RECOVER := 18.0        # your recovery rate at the drink/music stations
const PIZZA_FOOD := 15.0     # food restored per pizza
const COOK_TIME := 3.0       # seconds for one "cook" cycle (frames / FPS) - set this to yours!

const D_BASE := 5.0
const M_BASE := 6.0
const F_BASE := 4.0

const START_LOAD := 0.4     # how busy the player is at the start
const MAX_LOAD := 0.9       # the hardest it ever gets (keep below 1.0)
const RAMP := 60.0          # seconds; ~63% of the way to max at 150s, ~95% at 450s

const POINTS_PER_SECOND := 10.0
const POINTS_PER_PIZZA := 50

const MULT_START := 1.0   # 1.0 = your original 5 / 6 / 4 drains
const MULT_MAX := 1.4     # hardest it ever gets

var time := 0.0

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
	
	if d <= 0 or f <= 0 or m <= 0:
		Game.submit(int(score))
		get_tree().change_scene_to_packed(GAMEOVER)
		return
	
	_move()
	
	if pos == 0:
		if not m >= 50:
			m += 18 * delta
		
		if pizzas > 0 and Input.is_action_just_pressed("ui_down"):
			chomp.play()
			pizzas -= 1
			score += POINTS_PER_PIZZA
			
			scoreLabel.pivot_offset = scoreLabel.size / 2
			var pop := create_tween()
			pop.tween_property(scoreLabel, "scale", Vector2(1.3, 1.3), 0.05)
			pop.tween_property(scoreLabel, "scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			
			if f + 15 > 50:
				f = 50
			else:
				f += 15
	
	if pos == -1:
		if not d >= 50:
			d += 18 * delta
	
	
	if pos != prevPos:
		moved.emit()
	
	@warning_ignore("narrowing_conversion")
	score += POINTS_PER_SECOND * delta
	shown_score = move_toward(shown_score, score, max(200.0 * delta, (score - shown_score) * 5.0 * delta))
	scoreLabel.text = "%05d" % int(shown_score)
	time += delta
	var mult := _drain_mult()
	d = _drain(d, D_BASE * mult * delta, dMeter)
	m = _drain(m, M_BASE * mult * delta, mMeter)
	f = _drain(f, F_BASE * mult * delta, fMeter)
	
	
func _move():
	if pos == 1:
		global_position = kitchen.global_position
	elif pos == -1:
		global_position = drink.global_position
	else:
		global_position = music.global_position

func _drain(meter, dps: float,visual: ProgressBar):
	if not meter <= 0:
		meter = max(meter - dps, 0.0)
	visual.value = meter
	return meter

func _drain_mult() -> float:
	return lerpf(MULT_START, MULT_MAX, 1.0 - exp(-time / RAMP))

func get_difficulty() -> float:
	return _drain_mult() - .3
