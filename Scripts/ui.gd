extends Control

@export var config_window : PackedScene
@export var pomodoro_app : PackedScene
@export var credits_image : PackedScene
@onready var startup_sound : AudioStreamPlayer = $Startup_soud

#func _ready():
	# Preparar o Timer
	#double_click_timer.wait_time = 0.3
	#double_click_timer.one_shot = true
	#double_click_timer.timeout.connect(_on_double_click_timeout)
	#add_child(double_click_timer)
	#pass
	# ctrl K pra tirar o comentário

#func _on_settings_app_button_up() -> void:
	#var settings_instance = config_window.instantiate()
	#add_child(settings_instance)

@onready var settings_button := $GridContainer/icon_settings/settings_app
@onready var pomodoro_button := $GridContainer/icon_pomodoro/pomodoro_app
@onready var credits_button := $GridContainer/icon_credits/credits_image

var click_counts = {}
var timers = {}

func _ready():
	# Configurar ícones
	setup_double_click(settings_button, abrir_config_janela)
	setup_double_click(pomodoro_button, abrir_pomodoro)
	setup_double_click(credits_button, abrir_credits)
	startup_sound.play()

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
