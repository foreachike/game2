extends Node2D
@onready var char: Node2D = $"../Character"
@onready var drinking_sounds: AudioStreamPlayer2D = $drinkingSounds


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	char.moved.connect(_on_move)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_move():
	if char.pos == -1:
		drinking_sounds.play()
	else:
		drinking_sounds.stop()
