class_name Platform extends Node2D

# NOTE: if a moveable, destructable platform is moving down, the character may not register as being on the platform

# stationary platform
# moving platform (follow path, loop path, move on landing)
#   speed: entire path, from point to point
#   start_on_enter
#   stop_on_exit
# destructable platform
#   time_to_destruction
#   stop_on_exit
#   cumulative_destruction_time
# phasing platform
#   phase_out_time
#   phasing_out_time
#   phase_in_time
#   phasing_in_time

@export var is_loop: bool = false
@export var speed: float = 100

@export var is_one_way_collision: bool = false
@export var destruction_time: float = -1.0
@export var shake_factor: float = 2.0
@export var phase_time: float = -1.0

var shake_time: float = 0
var is_phased_in: bool = true

@onready var polygon_2d: Polygon2D = $AnimatableBody2D/Polygon2D
@onready var area_2d: Area2D = $AnimatableBody2D/Area2D
@onready var collision_shape_2d: CollisionShape2D = $AnimatableBody2D/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	if (destruction_time > 0):
		area_2d.body_entered.connect(_on_body_entered)
		area_2d.body_exited.connect(_on_body_exited)
	elif (phase_time > 0):
		timer.start(phase_time)
		timer.timeout.connect(_phase)
		
	collision_shape_2d.one_way_collision = is_one_way_collision
	
	if (!is_loop):
		animation_player.play("move_path")
	#set_process(false)

func _process(delta: float) -> void:
	if (timer.time_left > 0):
		shake_time += delta * 60
		polygon_2d.position += Vector2(0, sin(shake_time) * shake_factor)
	if (is_loop):
		path_follow_2d.progress += speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if (body is PlayerSideScroll && body.is_on_floor()):
		#set_process(true)
		timer.start(destruction_time)
		timer.timeout.connect(_destroy)

func _on_body_exited(body: Node2D) -> void:
	if (body is PlayerSideScroll):
		#set_process(false)
		timer.stop()

func _phase() -> void:
	is_phased_in = !is_phased_in;
	collision_shape_2d.disabled = !is_phased_in
	polygon_2d.visible = is_phased_in

func _destroy() -> void:
	queue_free()
