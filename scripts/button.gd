extends Button
@onready var label: Label = $"../CenterContainer/Label"

@export var button: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	label.buttons.connect(_on_buttons)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_buttons():
	visible = true


func _on_pressed() -> void:
	if button == 1:
		get_tree().change_scene_to_file("res://main.tscn")
	else:
		get_tree().change_scene_to_file("res://start.tscn")
