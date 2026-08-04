extends Area3D




func _on_area_entered(area: Area3D) -> void:
	if (area.name == "CameraRig"):
		GameManager.switch_underwater_effect()


func _on_area_exited(area: Area3D) -> void:
	if (area.name == "CameraRig"):
		GameManager.switch_underwater_effect()
