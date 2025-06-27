extends Panel

@export var header : Control
@export var option_button : OptionButton
@onready var container = $BoxContainer

var dragging = false
var drag_offset = Vector2.ZERO

var scenes := {
	"Work Time": "res://Scenes/pomodoro.tscn",
	"Short Break": "res://scenes/shortbreak.tscn",
	"Long Break": "res://scenes/longbreak.tscn"
}

func _ready():
	for name in scenes.keys():
		option_button.add_item(name)
	option_button.item_selected.connect(_on_scene_selected)

func _on_scene_selected(index: int):
	var scene_name = option_button.get_item_text(index)
	var scene_path = scenes[scene_name]
	var scene = load(scene_path).instantiate()


	# Limpa o container antes (opcional, se quiser mostrar só uma por vez)
	for child in container.get_children():
		child.queue_free()

	# Adiciona como filho
	container.add_child(scene)

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


func _on_exit_button_button_up() -> void:
	queue_free()
