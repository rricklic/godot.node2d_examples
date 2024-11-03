class_name PlayerTopDown extends CharacterBody2D

const SPEED = 300.0

@onready var starting_position: Vector2

var direction: int = 0

func _ready() -> void:
	starting_position = global_position

func _physics_process(delta: float) -> void:
	var direction_x: float = Input.get_axis("p1_left", "p1_right")
	if (direction_x > 0):
		direction = 0
	elif (direction_x < 0):
		direction = 1
	var direction_y: float = Input.get_axis("p1_up", "p1_down")
	velocity.x = move_toward(velocity.x, direction_x * SPEED, SPEED)
	velocity.y = move_toward(velocity.y, direction_y * SPEED, SPEED)
	if (starting_position != global_position):
		pass
	move_and_collide(velocity * delta)
