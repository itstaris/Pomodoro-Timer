extends Panel

@export var work_spinbox : SpinBox
@export var short_break_spinbox : SpinBox
@export var long_break_spinbox : SpinBox

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
