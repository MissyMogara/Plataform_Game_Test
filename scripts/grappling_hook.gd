extends Node3D

class_name HookGun

@onready var rope: RopeNode = $Grappling_Hook/Rope

func _ready() -> void:
	hide_rope()

func unhide_rope() -> void:
	rope.visible = true
	
func hide_rope() -> void:
	rope.visible = false
	
func look_at_and_scale(target: Vector3, distance: float ):
	#rope.look_at(target)
	rope.scale_rope(target)
