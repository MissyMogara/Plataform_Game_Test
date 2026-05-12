extends Node

@onready var grappling_hook: HookGun = $"../Miqotilla/Armature/Skeleton3D/BoneAttachment3D/Grappling_Hook_Gadget"

@export var rest_length = 2.0
@export var stiffness = 10.0
@export var damping = 1.0

var launched := false
var available := false
var hook_done := false
var target: Vector3
var target_collision: Dictionary
# We need character's space to shoot a raycast
@onready var player: CharacterBody3D = get_parent()
@onready var direct_state = player.get_world_3d().direct_space_state
@onready var char_origin = player.transform.origin

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("hookable"):
		available = true
		hook_done = false
		target = body.global_position
		var query = PhysicsRayQueryParameters3D.create(char_origin, target)
		target_collision = direct_state.intersect_ray(query)
		print(target_collision)
		
		

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("hookable"):
		print("He salido")
		available = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		launch()
	if Input.is_action_just_released("action"):
		retract()
	if launched:
		handle_grapple(delta)
	
	if player.is_on_floor():
		hook_done = false
	
	update_rope()
		
func launch():
	if available and not hook_done:
		launched = true
		
func retract():
	launched = false
	
func handle_grapple(delta: float):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)
	
	var displacement = target_dist - rest_length
	var force = Vector3.ZERO
	
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude
		
		var vel_dot = player.velocity.dot(target_dir)
		var grapple_damping = -damping * vel_dot * target_dir
		
		force = spring_force + grapple_damping
		
	player.velocity += force * delta
	
func update_rope():
	var jumping_while_hook: bool = Input.is_action_just_pressed("space_bar") and not player.is_on_floor()
	
	if jumping_while_hook and launched:
		hook_done = true
		retract()
	
	if !launched:
		grappling_hook.hide_rope()
		return
		
	grappling_hook.unhide_rope()
	
	
	var dist = player.global_position.distance_to(target)
	print(dist)
	print(target)
	grappling_hook.look_at_and_scale(target, dist)
	
	
	
