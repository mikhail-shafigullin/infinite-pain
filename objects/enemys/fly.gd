extends Enemy

@onready var mesh: MeshInstance3D = $FlyIcosphere
@export var die_time: float = 1.0

var _start_dying_at: int = 0.0
var _die_vector: Vector3

func die():
	_die_vector = Vector3(randf(), randf(), randf()).normalized()
	_start_dying_at = Time.get_ticks_msec()
	player.pause()

func on_die():
	print("fly is dead!")
	queue_free()

func _ready() -> void:
	die()

func _process(_delta: float) -> void:
	if _start_dying_at > 0:
		var t: float = (Time.get_ticks_msec() - _start_dying_at) / (1000.0 * die_time)
		mesh["blend_shapes/dead0"] = lerpf(0, 1, t)
		mesh["blend_shapes/dead1"] = lerpf(0, _die_vector.z, t)
		mesh["blend_shapes/dead2"] = lerpf(0, _die_vector.y, t)
		mesh["blend_shapes/dead3"] = lerpf(0, _die_vector.x, t)
		if t >= 1.0:
			on_die()
