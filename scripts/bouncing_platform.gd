extends Node3D

@export var bounce_force: float

func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body is CharacterBody3D):
		body.bounce(bounce_force)
