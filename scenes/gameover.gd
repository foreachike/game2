extends Node2D
@onready var label: Label = $Control/CenterContainer/Label
@onready var game_over_sound: AudioStreamPlayer2D = $gameOverSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_sound.seek(1.0)
	label.buttons.connect(_on_buttons)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_buttons():
	game_over_sound.play()
