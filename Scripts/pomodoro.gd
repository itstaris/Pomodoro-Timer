extends Node

@onready var timer: Timer = $Timer
@export var start_button : TextureButton
@export var restart_button : TextureButton
@export var timer_label : Label

var pomodoro = Globals.pomodoro

var total_seconds = 0
var minutes = pomodoro
var paused : bool = false
var running : bool = false

func _ready():
	timer_label.text = "%02d:00" % [pomodoro]
	timer.timeout.connect(_on_timer_timeout)
	
	
func _on_timer_timeout():
	total_seconds -= 1
	update_timer_label()
	if total_seconds <= 0:
		timer.stop()
		$Alarm.play()

func _on_start_button_up() -> void:
	if running == false:
		total_seconds = minutes * 60
		running = true
		paused = false
		
		timer.wait_time = 1.0
		timer.start()
		update_timer_label()
	elif paused:
		paused = false
		timer.start()
	else:
		paused = true
		timer.stop()
	
func update_timer_label():
	@warning_ignore("integer_division", "shadowed_variable")
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _on_restart_button_up() -> void:
	paused = false
	running = false
	minutes = pomodoro
	timer_label.text = "%02d:00" % [pomodoro]
	timer.stop()
