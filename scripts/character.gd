class_name Player extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $Miqotilla/AnimationPlayer
@onready var miqotilla: Node3D = %Miqotilla

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.1

@onready var _camera_pivot: Node3D = %Pivot
@onready var _camera: Camera3D = %Camera3D
@onready var _skin: Node3D = %Miqotilla
@onready var hand:Hand = %Hand

var _camera_imput_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK
var states:PlayerStatesNames = PlayerStatesNames.new()

func get_player_hand() -> Hand:
	return hand
	
func set_item_into_hand(item:Node) -> void:
	hand.change_item(item)
# This prevent player for moving camera outside the game
func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		_camera_imput_direction = event.screen_relative * mouse_sensitivity

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
func play_anim(anim: String) -> void:
	if animation_player.current_animation != anim:
		animation_player.play(anim)

func _physics_process(delta: float) -> void:
	
	_camera_pivot.rotation.x += _camera_imput_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, deg_to_rad(-30), deg_to_rad(60))
	_camera_pivot.rotation.y -= _camera_imput_direction.x * delta
	
	_camera_imput_direction = Vector2.ZERO
		
	if not is_on_floor():
		CheckHeigh()
	
	
func CheckHeigh() -> void:
	if global_position.y < -16.0:
		Death()

func Death() -> void:
	GameManager.kill_all_tweens()
	call_deferred("reload_scene")
	
func bounce(force: float) -> void:
	velocity.y += force
	
func reload_scene():
	get_tree().reload_current_scene()
