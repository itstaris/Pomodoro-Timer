extends Control

@export var config_window : PackedScene

func _on_config_button_pressed() -> void:
	var instance = config_window.instantiate()
	add_child(instance)
