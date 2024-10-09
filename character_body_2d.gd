extends CharacterBody2D

const JUMP_VELOCITY = -400.0

func _ready() -> void:
	position.y = DisplayServer.screen_get_size().y / 2.0

func _process(_delta: float) -> void:
	if position.y > DisplayServer.screen_get_size().y:
		queue_free()

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	move_and_slide()
