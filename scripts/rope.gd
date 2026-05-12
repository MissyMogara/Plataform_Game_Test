extends Node3D

class_name RopeNode

@onready var rope := $Rope
@onready var hook := $Hook2

func scale_rope(target: Vector3) -> void:
	
	var start = global_position
	var dir = target - start
	var distance = dir.length()
	
	hook.global_position = target
	rope.look_at(target, Vector3.UP)
	rope.scale.z = -(distance * 5)
	
