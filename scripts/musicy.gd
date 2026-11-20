extends Node2D
@onready var char: Node2D = $"../Character"
@onready var music_sounds: AudioStreamPlayer2D = $musicSounds


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	char.moved.connect(_on_move)
	music_sounds.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_move():
	if char.pos == 0:
		music_sounds.volume_db = 0
	else:
		music_sounds.volume_db = -10
