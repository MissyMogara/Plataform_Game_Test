extends PlayerMovementAndGravity
	
func on_physics_process(delta):
	player.play_anim("standing")
	
	player.velocity.x = lerpf(player.velocity.x, 0.0, deceleration * delta)
	player.velocity.z = lerpf(player.velocity.z, 0.0, deceleration * delta)
	
	handle_gravity(delta)
	player.move_and_slide()
	
func on_input(event):
	var raw_input:Vector2 = get_raw_input()
	
	if Input.is_action_just_pressed("space_bar"):
		state_machine.change_to(player.states.Jumping)
		
	if Input.is_action_just_pressed("sprint") and raw_input:
		state_machine.change_to(player.states.Running)
	
	if raw_input:
		state_machine.change_to(player.states.Walking)
