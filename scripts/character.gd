extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $Miqotilla/AnimationPlayer
@onready var miqotilla: Node3D = $Miqotilla
@onready var grapple_controller := $GrappleController

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25

@export_group("Movement")
@export var move_speed := 8.0
@export var acceleration := 10.0
@export var deceleration := 8.0
@export var rotation_speed := 12.0
@export var jump_impulse := 12.0
@export var sprint_speed := 15.0
@export var walk_speed:= 8.0

@onready var _camera_pivot: Node3D = %Pivot
@onready var _camera: Camera3D = %Camera3D
@onready var _skin: Node3D = %Miqotilla
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_timer: Timer = $JumpTimer

var _camera_imput_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK
var _gravity := -30.0
var was_on_floor: bool = false

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
	
func _input(event):
	pass
		
func play_anim(anim: String) -> void:
	if animation_player.current_animation != anim:
		animation_player.play(anim)

func _physics_process(delta: float) -> void:
	
	_camera_pivot.rotation.x += _camera_imput_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, deg_to_rad(-30), deg_to_rad(60))
	_camera_pivot.rotation.y -= _camera_imput_direction.x * delta
	
	_camera_imput_direction = Vector2.ZERO
	
	var raw_input := Input.get_vector("left", "right", "up", "down")
	
	#Need to know foward realtive to camera
	var foward := _camera.global_basis.z
	var right := _camera.global_basis.x
	
	
	var move_direction := foward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	
	move_direction = move_direction.normalized()
	
	if raw_input.length() != 0:
		velocity.x = lerpf(velocity.x, move_direction.x * move_speed, acceleration * delta)
		velocity.z = lerpf(velocity.z, move_direction.z * move_speed, acceleration * delta)
	else:
		velocity.x = lerpf(velocity.x, 0.0, deceleration * delta)
		velocity.z = lerpf(velocity.z, 0.0, deceleration * delta)
	
	if is_on_floor():
		was_on_floor = true
	else:
		if was_on_floor:
			coyote_timer.start()
			was_on_floor = false
	
	if (!is_on_floor() and coyote_timer.is_stopped()):
		var y_velocity := velocity.y
		velocity.y = 0
		velocity.y = y_velocity + _gravity * delta
	
	
	
	var is_starting_jump: bool = Input.is_action_just_pressed("space_bar") and ((is_on_floor() or !coyote_timer.is_stopped()) or grapple_controller.launched)
	if is_starting_jump and jump_timer.is_stopped():
		jump_timer.start()
		velocity.y +=  jump_impulse
		
	var is_sprinting: bool = Input.is_action_pressed("sprint")
	if is_sprinting and is_on_floor():
		move_speed = sprint_speed
	else:
		move_speed = walk_speed
		
	if not is_on_floor():
		CheckHeigh()
	
	move_and_slide()

	if move_direction.length() > 0.2:
		_last_movement_direction = move_direction
	var target_angle := Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed * delta)
	
	if not is_on_floor():
		if velocity.y > 0:
			play_anim("jump")
		else:
			play_anim("jump")
	elif velocity.length() > 0.1:
		play_anim("walking")
	else:
		play_anim("standing")
	
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
