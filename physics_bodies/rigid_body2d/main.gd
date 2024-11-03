extends Node2D

const FLOATING_BALL = preload("res://physics_bodies/rigid_body2d/floating_ball.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("p1_up"):
		var ball: FloatingBall = FLOATING_BALL.instantiate()
		ball.global_position = Vector2(randf_range(50, 500), randf_range(50, 500))
		add_child(ball)
