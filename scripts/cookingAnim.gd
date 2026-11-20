extends AnimatedSprite2D
@warning_ignore("shadowed_global_identifier")
@onready var char: Node2D = $"../../Character"
@onready var pizzaCountLabel: Label = $"../../CanvasLayer/pizzaCounter"
@onready var cooking_sounds: AudioStreamPlayer2D = $"../cookingSounds"
@onready var bip: AudioStreamPlayer2D = $"../bip"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = 0
	char.moved.connect(_on_moved)
	animation_looped.connect(_on_animation_looped)
	frame_changed.connect(_on_frame_changed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	#if char.pizzas == 5:
	#	sprite_frames.set_animation_loop("cook", false)
	#else:
	#	sprite_frames.set_animation_loop("cook", true)
	speed_scale = char.get_difficulty()
	pizzaCountLabel.text = str(char.pizzas)
	pass

func _on_animation_looped() -> void:
	cooking_sounds.play()
	char.pizzas += 1
	if char.pizzas >= 5:
		stop() 

func _on_moved() -> void:
	if char.pos == 1 and char.pizzas < 5:
		play()
	else:
		pause()


func _on_frame_changed() -> void:
	bip.play()
