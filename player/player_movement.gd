class_name Player extends CharacterBody3D

@onready var camera_player = $Node3D/CameraPlayer3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _physics_process(delta: float) -> void:
    var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

    if not is_on_floor():
       velocity.y -= gravity * delta

    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Obter a direção de input e manipular o movimento/desaceleração.
    # Substituir ações da UI por ações personalizadas de gameplay.
    var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    var direction = Vector3.ZERO

    # Alinhar a movimentação com a rotação da câmera
    if input_dir != Vector2.ZERO:
        # Definir a direção de movimento com base na rotação da câmera
        var forward_dir = camera_player.global_transform.basis.z.normalized()
        var right_dir = camera_player.global_transform.basis.x.normalized()

        # Combinar o input com as direções frente e lateral da câmera
        direction = (forward_dir * input_dir.y) + (right_dir * input_dir.x)
        direction = direction.normalized()

        # Aplicar a velocidade de movimento na direção certa
        velocity.x = direction.x * SPEED
        velocity.z = direction.z * SPEED
    else:
        # Desaceleração quando o jogador não está se movendo
        velocity.x = move_toward(velocity.x, 0, SPEED)
        velocity.z = move_toward(velocity.z, 0, SPEED)

    # Mover o jogador e lidar com colisões
    move_and_slide()
