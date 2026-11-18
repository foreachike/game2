extends AnimatedSprite2D
@onready var char: Node2D = $"../../Character"
@onready var pizzaCountLabel: Label = $"../../CanvasLayer/pizzaCounter"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = 0
	char.moved.connect(_on_moved)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if char.pizzas == 5:
	#	sprite_frames.set_animation_loop("cook", false)
	#else:
	#	sprite_frames.set_animation_loop("cook", true)
	
	pizzaCountLabel.text = str(char.pizzas)
	pass

func _on_animation_looped() -> void:
	char.pizzas += 1
	if char.pizzas >= 5:
		stop() 

func _on_moved() -> void:
	if char.pos == 1 and char.pizzas < 5:
		print("hi")
		play()
	else:
		pause()
