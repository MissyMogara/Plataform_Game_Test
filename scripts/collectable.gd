extends Node3D

# Properties
@export var collectable_name: String = "default"
@export var collectable_scene: PackedScene
@export var shape: Shape3D
@export var animation: bool = false
#If there is an animation
@export var offset: Vector3 = Vector3.ZERO
@export var duration: float = 0

# Default properties
@onready var collectable_shape:= $CollectableArea/CollisionShape
@onready var model: Node3D = $Model
@onready var place_holder: MeshInstance3D = $MeshInstance3D
var model_start_position = Vector3.ZERO

var tween: Tween
var toon_styler : ToonStyle = ToonStyle.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if collectable_scene:
		place_holder.visible = false
	model_start_position = model.position
	
	if (collectable_scene):
		var collectable: Node = collectable_scene.instantiate()
		model.add_child(collectable)
		
		for mesh in collectable.get_children(): #All mesh
			if mesh is MeshInstance3D:
				for i in mesh.get_surface_override_material_count(): #All material
					var material = mesh.get_active_material(i)
					print(material.resource_name)
					material.diffuse_mode = BaseMaterial3D.DIFFUSE_TOON
					material.specular_mode = BaseMaterial3D.SPECULAR_DISABLED
					material.roughness = 0
				
				toon_styler.add_outline(mesh, 0.03)
		
	collectable_shape.shape = shape
	if animation:
		start_vertical_tween()

func _physics_process(delta: float) -> void:
	if animation:
		model.rotate_y(1.5 * delta)

func _on_collectable_area_body_entered(body: Node3D) -> void:
	if (body is CharacterBody3D):
		if (self.collectable_name == "quesadilla"):
			GameManager.add_quesadilla(1)
		if tween:
			tween.kill()
		queue_free()
		
func start_vertical_tween():
	tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(model, "position", offset, duration).set_trans(Tween.TRANS_SINE)
	tween.tween_property(model, "position", model_start_position, duration).set_trans(Tween.TRANS_SINE)
