extends Panel

@export var header : Control
@export var option_button : OptionButton
@onready var container = $BoxContainer

var dragging = false
var drag_offset = Vector2.ZERO

# Pré-carregando as cenas diretamente
var scenes := {
	"Work Time": preload("res://Scenes/pomodoro.tscn"),
	"Short Break": preload("res://Scenes/shortbreak.tscn"),
	"Long Break": preload("res://Scenes/longbreak.tscn")
}

func _ready():
	for name in scenes.keys():
		option_button.add_item(name)
	option_button.item_selected.connect(_on_scene_selected)

func _on_scene_selected(index: int):
	var scene_name = option_button.get_item_text(index)
	
	# Verifica se a cena foi pré-carregada corretamente
	if scenes.has(scene_name):
		var packed_scene: PackedScene = scenes[scene_name]
		var scene_instance = packed_scene.instantiate()

		# Remove filhos anteriores, se houver
		for child in container.get_children():
			child.queue_free()

		container.add_child(scene_instance)
	else:
		print("Erro: cena não encontrada para", scene_name)

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
