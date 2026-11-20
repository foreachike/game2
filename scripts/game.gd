extends Node

const SAVE_PATH := "user://save.cfg"

var score := 0
var high_score := 0

func _ready() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		high_score = cfg.get_value("save", "high_score", 0)

func submit(final_score: int) -> void:
	score = final_score
	if score > high_score:
		high_score = score
		var cfg := ConfigFile.new()
		cfg.set_value("save", "high_score", high_score)
		cfg.save(SAVE_PATH)
