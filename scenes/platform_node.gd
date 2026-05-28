extends Node3D

class_name Platform_Node

@onready var animatablebody: AnimatableBody3D = $AnimatableBody3D
@export var offset: Vector3
@export var duration: float
@export var pause: float
var start_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = animatablebody.position
	start_tween()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_tween():
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(animatablebody, "position", offset, duration).set_trans(Tween.TRANS_SINE).set_delay(pause)
	tween.tween_property(animatablebody, "position", start_position, duration).set_trans(Tween.TRANS_SINE).set_delay(pause)
