extends Label
@onready var type_timer: Timer = $typeTimer
@onready var pause_timer: Timer = $pauseTimer

var lines

signal buttons

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible_characters = 0
	type_timer.timeout.connect(_on_timeout)
	pause_timer.timeout.connect(_on_pause)
	type_timer.start()
	self.get_line_count()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lines = get_line_count()

func _on_timeout():
	if visible_characters <= text.length():
		visible_characters += 1
	else:
		buttons.emit()
		type_timer.stop()
	
	if lines == 3:
		print("timerstarted")
		pause_timer.start()
		type_timer.stop()

func _on_pause():
	print("ding")
	type_timer.start()
	pause_timer.stop()
