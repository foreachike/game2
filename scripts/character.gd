extends Node2D

@onready var kitchen: Node2D = $"../KitchenP"
@onready var music: Node2D = $"../MusicP"
@onready var drink: Node2D = $"../DrinkP"

var pos := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		pos = 1
	elif Input.is_action_pressed("ui_left"):
		pos = -1
	else:
		pos = 0
	
	_move()

func _move():
	if pos == 1:
		global_position = kitchen.global_position
	elif pos == -1:
		global_position = drink.global_position
	else:
		global_position = music.global_position
