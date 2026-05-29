extends Node3D

@onready var platform1: Platform_Node 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in get_tree().get_nodes_in_group("buttons"):
		button.open_door.connect(_on_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_button_pressed(id: int) -> void:
	for door in get_tree().get_nodes_in_group("doors"):
		door.open(id)
