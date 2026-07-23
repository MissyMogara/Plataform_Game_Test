extends Node3D

# Properties
@export var collectable_name: String = "default"
@export var model: Mesh
@export var shape: Shape3D

# Default properties
@onready var collectable_mesh:= $CollectableMesh
@onready var collectable_shape:= $CollectableArea/CollisionShape

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collectable_mesh.mesh = model
	collectable_shape.shape = shape

func _on_collectable_area_body_entered(body: Node3D) -> void:
	if (body is CharacterBody3D):
		if (self.collectable_name == "quesadilla"):
			GameManager.add_quesadilla(1)
		queue_free()
