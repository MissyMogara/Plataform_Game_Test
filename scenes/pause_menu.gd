extends Control

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Engine.is_editor_hint():
		visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc") and get_tree().paused == false:
		_pause()
	elif event.is_action_pressed("esc") and get_tree().paused == true:
		_resume()

func _resume():
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animationPlayer.play_backwards("blur")
	get_tree().paused = false
	
	
func _pause():
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	animationPlayer.play("blur")
	get_tree().paused = true
	
	
	
func _on_resume_pressed() -> void:
	_resume()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_restart_level_pressed() -> void:
	get_tree().paused = false
	GameManager.kill_all_tweens()
	get_tree().reload_current_scene()
	GameManager.reset_quesadillas()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	GameManager.kill_all_tweens()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_save_button_down() -> void:
	GameManager.save_game()


func _on_load_button_down() -> void:
	GameManager.load_game()
