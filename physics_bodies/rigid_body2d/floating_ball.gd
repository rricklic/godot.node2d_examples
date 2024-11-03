class_name FloatingBall extends RigidBody2D

@export var speed: float = 500.0
@export var seed: int = 1
@export var is_random: bool = true
@export var init_direction: Vector2

# NOTE: “Project” > “Project Settings” > “General” > “Physics” > “2d” > “Default Linear Damp” set to zero

func _ready() -> void:
	var velocity: Vector2
	if (is_random):
		var rng: RandomNumberGenerator = RandomNumberGenerator.new()
		rng.seed = seed
		velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * speed
	else:
		velocity = init_direction.normalized() * speed
	apply_central_impulse(velocity)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	pass
