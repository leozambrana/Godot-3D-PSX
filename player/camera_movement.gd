class_name CameraPlayer extends Camera3D

# Sensibilidade do mouse
var mouse_sensitivity: float = 0.2
# Limite para o ângulo de visão vertical (pitch)
var vertical_limit: float = 90.0

# Rotação vertical (pitch)
var rotation_x: float = 0.0

func _ready() -> void:
	# Travar o cursor na tela para o modo FPS
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Controle da rotação da câmera via movimento do mouse
		rotate_camera(event.relative)

func rotate_camera(relative_motion: Vector2) -> void:
	# Movimento horizontal (yaw) baseado no eixo X do mouse
	rotate_y(deg_to_rad(-relative_motion.x * mouse_sensitivity))

	# Movimento vertical (pitch) baseado no eixo Y do mouse
	rotation_x -= relative_motion.y * mouse_sensitivity
	# Limitar a rotação vertical para não virar completamente o pescoço
	rotation_x = clamp(rotation_x, -vertical_limit, vertical_limit)
	
	# Aplicar a rotação vertical à câmera
	rotation.x = deg_to_rad(rotation_x)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
