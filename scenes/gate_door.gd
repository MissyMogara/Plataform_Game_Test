extends Node3D

signal open_door(id: int)

@onready var animatable_door: AnimatableBody3D = $AnimatableBody3D
@export var offset: Vector3
@export var duration: float
@export var id: int
var start_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = animatable_door.position
	open_door.connect(open)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func open(door_id: int) -> void:
	if (door_id == id):
		var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(animatable_door, "position", offset, duration)
