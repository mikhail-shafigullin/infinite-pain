@tool
extends AnimatableBody3D

var mat: ShaderMaterial = null

@export var seed: int = 0 :
	set (val):
		if mat:
			seed = val
			mat["shader_parameter/seed"] = seed

@export var bpm: int = 120:
	set (val):
		if mat:
			bpm = val
			mat["shader_parameter/bpm"] = bpm

@export var time_offset: float = 0.0:
	set (val):
		if mat:
			time_offset = val
			mat["shader_parameter/time_offset"] = val

@export var color: Color = Color.CRIMSON:
	set (val):
		if mat:
			color = val
			mat["shader_parameter/primary"] = val

func _ready() -> void:
	if(BpmController):
		BpmController.bpm_changed.connect(_on_bpm_changed);
		BpmController.delay_changed.connect(_on_bpm_changed);
		
	for c: Node in get_children():
		if c is MeshInstance3D and c.mesh != null:
			mat = c.get_active_material(0).duplicate()
			c.material_override = mat
			seed = randi()
			
func _on_bpm_changed(new_bpm: float):
	bpm = new_bpm;
	
func _on_delay_changed(new_delay: float):
	time_offset = new_delay;
