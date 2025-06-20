extends Window

func _on_save_button_pressed():
	Globals.pomodoro = int(work_time_input.text)
	Globals.short_break = int(short_break_input.text)
	Globals.long_break = int(long_break_input.text)
	
	Globals.save_config()
