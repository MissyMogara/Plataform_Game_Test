extends Node3D

class_name Gate_Button
signal open_door(id: int)

@onready var animatable_button: AnimatableBody3D = $AnimatableBody3D
@export var door_id: int
@export var offset: Vector3
@export var duration: float
var hasBeenPressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body is CharacterBody3D):
		if not hasBeenPressed:
			_door_signal()
			hasBeenPressed = true
			var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
			tween.tween_property(animatable_button, "position", offset, duration)
	
func _door_signal() -> void:
	open_door.emit(door_id)
