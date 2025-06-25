extends Control

@export var config_window : PackedScene
@export var pomodoro_app : PackedScene
@export var credits_image : PackedScene

func _ready():
	# Preparar o Timer
	#double_click_timer.wait_time = 0.3
	#double_click_timer.one_shot = true
	#double_click_timer.timeout.connect(_on_double_click_timeout)
	#add_child(double_click_timer)
	pass
	# ctrl K pra tirar o comentário

func _on_settings_app_button_up() -> void:
	var settings_instance = config_window.instantiate()
	add_child(settings_instance)
