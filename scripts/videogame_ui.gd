extends Control

@onready var quesadilla_label : Label = $HBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.quesadillas_changed.connect(_on_quesadilla_changed)
	quesadilla_label.text = str(GameManager.quesadillas)

func _on_quesadilla_changed(total: int):
	quesadilla_label.text = str(total)
	
