extends Panel

@export var work_spinbox : SpinBox
@export var short_break_spinbox : SpinBox
@export var long_break_spinbox : SpinBox

@export var header : Control

var dragging = false
var drag_offset = Vector2.ZERO

func _ready() -> void:
	work_spinbox.value = Globals.pomodoro
	short_break_spinbox.value = Globals.short_break
	long_break_spinbox.value = Globals.long_break

func _on_save_button_button_up() -> void:
	Globals.pomodoro = work_spinbox.value
	Globals.short_break = short_break_spinbox.value
	Globals.long_break = long_break_spinbox.value
	
	print(Globals.pomodoro)
	print(Globals.short_break)
	print(Globals.long_break)
	
	Globals.save_config()

func _on_exit_button_button_up() -> void:
	queue_free()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if header.get_global_rect().has_point(get_global_mouse_position()):
				dragging = true
				drag_offset = get_global_mouse_position() - global_position
		else:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - drag_offset
