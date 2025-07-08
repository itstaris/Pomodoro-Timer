extends Control

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $AnimationTimer
@onready var drag_area: ColorRect = $DragArea  # Certifique-se do nome

var animations := ["backflip", "globe", "sunglasses"]
var has_finished_appearing := false
var should_close := false

var dragging = false
var drag_offset = Vector2.ZERO

func _ready():
	# Começa com a animação de aparição
	sprite.animation = "appearing"
	sprite.play()
	sprite.animation_finished.connect(_on_animation_finished)
	
	# Inicia o timer aleatório após a animação appearing
	timer.timeout.connect(_on_timer_timeout)
	
	# Conecta entrada de mouse da área de arrasto
	drag_area.mouse_filter = Control.MOUSE_FILTER_STOP
	drag_area.gui_input.connect(_on_drag_area_input)

func _on_animation_finished():
	match sprite.animation:
		"appearing":
			has_finished_appearing = true
			sprite.animation = "idle"
			sprite.play()
			_start_random_animation_timer()
		"leaving":
			queue_free()
		_:
			if has_finished_appearing and not should_close:
				sprite.animation = "idle"
				sprite.play()
				_start_random_animation_timer()

func _start_random_animation_timer():
	timer.wait_time = randf_range(15.0, 30.0)
	timer.start()

func _on_timer_timeout():
	if not should_close:
		var anim = animations[randi() % animations.size()]
		sprite.animation = anim
		sprite.play()

func close():
	should_close = true
	timer.stop()
	sprite.animation = "leaving"
	sprite.play()

func _on_drag_area_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_offset = get_global_mouse_position() - global_position
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - drag_offset
