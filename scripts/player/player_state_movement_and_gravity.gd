class_name PlayerMovementAndGravity extends PlayerStateBase

@onready var _camera_pivot: Node3D = %Pivot
@onready var _camera: Camera3D = %Camera3D
@onready var _skin: Node3D = %Miqotilla
@onready var coyote_timer: Timer = %CoyoteTimer
@onready var jump_timer: Timer = %JumpTimer

@export_group("Movement")
@export var move_speed := 8.0
@export var acceleration := 10.0
@export var deceleration := 8.0
@export var rotation_speed := 12.0
@export var jump_impulse := 8.0
@export var sprint_speed := 15.0
@export var walk_speed:= 8.0
@export var aerial_speed:float = 4.0
@export var aerial_acceleration:float = 6.0
@export var front_aerial_speed:float = 10.0
@export var front_aerial_acceleration:float = 12.0

@export var gravity:float = -30.0

func handle_gravity(delta):
	player.velocity.y += gravity * delta
	
func get_raw_input() -> Vector2:
	var raw_input:Vector2 = Input.get_vector("left", "right", "up", "down")
	return raw_input
	
func move_character(raw_input:Vector2, speed:float, delta):
	#Need to know foward realtive to camera
	var foward := _camera.global_basis.z
	var right := _camera.global_basis.x
	
	
	var move_direction := foward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	
	move_direction = move_direction.normalized()
	
	player.velocity.x = lerpf(player.velocity.x, move_direction.x * speed, acceleration * delta)
	player.velocity.z = lerpf(player.velocity.z, move_direction.z * speed, acceleration * delta)
	#Handle character model rotation
	if move_direction.length() > 0.2:
		player._last_movement_direction = move_direction
	var target_angle := Vector3.BACK.signed_angle_to(player._last_movement_direction, Vector3.UP)
	player._skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed * delta)
	
