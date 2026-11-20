extends Node2D
@onready var label: Label = $CanvasLayer/Label
@onready var main_music: AudioStreamPlayer2D = $mainMusic

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_music.play()
	var tween := create_tween().set_loops()
	tween.tween_property(label, "scale", Vector2(1.5, 1.5), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(label, "scale", Vector2(1.0, 1.0), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
