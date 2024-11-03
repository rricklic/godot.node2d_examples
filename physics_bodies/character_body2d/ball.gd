class_name Ball extends CharacterBody2D

@export var speed: float = 500.0
@export var seed: int = 1
@export var is_random: bool = true
@export var init_direction: Vector2

func _ready() -> void:
	if (is_random):
		var rng: RandomNumberGenerator = RandomNumberGenerator.new()
		rng.seed = seed
		velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * speed
	else:
		velocity = init_direction.normalized() * speed

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if (collision):
		velocity = velocity.bounce(collision.get_normal())
