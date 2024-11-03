class_name MainCamera extends Camera2D

@export_range(0.1, 5.0) var camera_zoom: float = 2.0
@export_range(0.1, 10.0) var camera_smoothing: float = 5.0
@export var look_ahead: float = 0.0
@export var look_above: float = 0.0
@export var target: Node2D = null

func _ready() -> void:
	_zoom()

func _physics_process(delta: float) -> void:
	_follow_target(delta)

func _zoom() -> void:
	zoom = Vector2(camera_zoom, camera_zoom)
	
func _follow_target(delta: float) -> void:
	if (target == null):
		return
		
	var x_offset: float = 0.0
	if ("direction" in target && target.direction == 0):
		x_offset = look_ahead
	elif ("direction" in target && target.direction == 1):
		x_offset = -look_ahead
		
	global_position = lerp(global_position, target.global_position + Vector2(x_offset, 0), camera_smoothing * delta)
	
func set_target(node: Node2D) -> void:
	target = node
