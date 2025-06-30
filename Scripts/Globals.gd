extends Node

var pomodoro = 25
var short_break = 5
var long_break = 30

var config_path = "user://pomodoro_config.json"

func _ready():
	load_config()

func save_config():
	var config = {
		"pomodoro": pomodoro,
		"short_break": short_break,
		"long_break": long_break
	}
	
	var file = FileAccess.open(config_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(config, "\t"))
	file.close()

func load_config():
	if FileAccess.file_exists(config_path):
		var file = FileAccess.open(config_path, FileAccess.READ)
		var json_text = file.get_as_text()
		file.close()
		
		var result = JSON.parse_string(json_text)
		if result is Dictionary:
			pomodoro = result.get("pomodoro", pomodoro)
			short_break = result.get("short_break", short_break)
			long_break = result.get("long_break", long_break)
		else:
			print("Erro ao fazer parse do JSON, usando valores padrão.")
	else:
		print("Nenhum arquivo de configuração encontrado. Usando valores padrão.")
