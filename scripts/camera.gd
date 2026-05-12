extends Node3D
#
#var max_up := deg_to_rad(40)
#var min_down := deg_to_rad(-60)
#
#var sens: float = 0.002
##Vertical movement
#var pitch: float = 0.0
#
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion: 
		#pitch -= event.relative.y * sens
		##It will return only a value between min and max
		#pitch = clamp(pitch, min_down, max_up)
		#
		#rotation.x = pitch
