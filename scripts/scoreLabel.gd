extends Label
@onready var label: Label = $"../CenterContainer/Label"

func _ready() -> void:
	visible = false
	label.buttons.connect(_on_buttons)

func _on_buttons():
	visible = true
	text = "SCORE %05d\nBEST  %05d" % [Game.score, Game.high_score]
