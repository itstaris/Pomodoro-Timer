extends Control

func _on_config_button_pressed() -> void:
	var config_window_scene = preload("res://Scenes/ConfigWindow.tscn")
	var config_window_instance = config_window_scene.instantiate()
	add_child(config_window_instance)

	config_window_instance.popup_centered()  # Exibe o pop-up centralizado
