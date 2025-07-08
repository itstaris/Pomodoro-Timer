extends Control

@export var config_window : PackedScene
@export var pomodoro_app : PackedScene
@export var credits_image : PackedScene
@onready var startup_sound : AudioStreamPlayer = $Startup_soud

@onready var start_button : Button = $start_button
@onready var popup_menu : PopupMenu = $start_button/PopupMenu
@onready var assistant_scene := preload("res://Scenes/bonzi_buddy.tscn")
var assistant_instance: Node = null

@onready var settings_button := $GridContainer/icon_settings/settings_app
@onready var pomodoro_button := $GridContainer/icon_pomodoro/pomodoro_app
@onready var credits_button := $GridContainer/icon_credits/credits_image

var click_counts = {}
var timers = {}

func _ready():
	startup_sound.play()
	
	# icon settings
	setup_double_click(settings_button, abrir_config_janela)
	setup_double_click(pomodoro_button, abrir_pomodoro)
	setup_double_click(credits_button, abrir_credits)
	
	popup_menu.id_pressed.connect(_on_menu_option_selected)

func _on_start_button_pressed() -> void:
	popup_menu.popup()  # Exibe o menu primeiro (necessário para ele calcular o tamanho)

	call_deferred("_reposition_popup_menu")
	
func _reposition_popup_menu():
	var button_pos = start_button.get_global_position()
	var menu_size = popup_menu.size

	var position = button_pos - Vector2(0, menu_size.y)
	popup_menu.position = position
	
func _on_menu_option_selected(id):
	match id:
		1:
			get_tree().quit()
		2:
			if assistant_instance:
				assistant_instance.call("close")
				assistant_instance = null
			else:
				assistant_instance = assistant_scene.instantiate()
				add_child(assistant_instance)


func setup_double_click(button: Node, callback: Callable):
	click_counts[button] = 0
	
	var timer := Timer.new()
	timer.wait_time = 0.3
	timer.one_shot = true
	timer.timeout.connect(func():
		click_counts[button] = 0
	)
	add_child(timer)
	timers[button] = timer
	
	button.pressed.connect(func():
		click_counts[button] += 1
		if click_counts[button] == 1:
			timers[button].start()
		elif click_counts[button] == 2:
			callback.call()
			click_counts[button] = 0
			timers[button].stop()
	)

# Ações específicas
func abrir_config_janela():
	var instance = config_window.instantiate()
	add_child(instance)

func abrir_pomodoro():
	var instance = pomodoro_app.instantiate()
	add_child(instance)

func abrir_credits():
	var instance = credits_image.instantiate()
	add_child(instance)
