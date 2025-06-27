extends Control

@onready var timer: Timer = $Timer
@export var start_button : Button
@export var restart_button : Button
@export var timer_label : Label

var longbreak = Globals.long_break

var total_seconds = 0
var minutes = longbreak
var paused : bool = false
var running : bool = false

func _ready():
	timer_label.text = "%02d:00" % [longbreak]
	timer.timeout.connect(_on_timer_timeout)
	restart_button.disabled = true
	
func _on_timer_timeout():
	total_seconds -= 1
	restart_button.disabled = false
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
		start_button.text = "Pause"
	elif paused:
		paused = false
		timer.start()
		start_button.text = "Pause"
	else:
		paused = true
		timer.stop()
		start_button.text = "Resume"

func update_timer_label():
	@warning_ignore("integer_division", "shadowed_variable")
	var minutes = total_seconds / 60
	var seconds = int(total_seconds) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _on_restart_button_up() -> void:
	paused = false
	running = false
	minutes = longbreak
	timer_label.text = "%02d:00" % [longbreak]
	timer.stop()
	restart_button.disabled = true
	start_button.text = "Start"
