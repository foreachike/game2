extends Control
@onready var button: Button = $Button
@onready var trect: TextureRect = $Button/buttonDisplay
@onready var bg: ColorRect = $Button/buttonDisplay/buttonBackground
@onready var bText: Label = $Button/buttonText
@onready var infoBg: Panel = $infoBg
@onready var infoText: Label = $infoBg/infoText


@export var modeTexture: Texture
@export var modeName: String
@export var Mode: Resource
@export var info: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trect.texture = modeTexture
	bText.text = modeName
	infoText.text = info

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if Game.currentMode != Mode:
		Game.currentMode = Mode
		print("Mode is now: " + str(Mode))


func _on_button_mouse_entered() -> void:
	infoBg.visible = true


func _on_button_mouse_exited() -> void:
	infoBg.visible = false
