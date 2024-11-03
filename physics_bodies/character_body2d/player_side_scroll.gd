class_name PlayerSideScroll extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("p2_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("p2_left", "p2_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# NOTE: Using move_and_slide() may result in this node being moved by other colliding CharacterBody2Ds
	move_and_slide()
