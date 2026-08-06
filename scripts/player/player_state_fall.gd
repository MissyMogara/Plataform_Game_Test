extends PlayerMovementAndGravity

func on_physics_process(delta):
	var raw_input:Vector2 = get_raw_input()
	
	if player.is_on_floor() and raw_input:
		state_machine.change_to(player.states.Walking)
	elif player.is_on_floor():
		state_machine.change_to(player.states.Idle)
		
	#Need to know foward realtive to camera
	var foward := _camera.global_basis.z
	var right := _camera.global_basis.x
	
	
	var move_direction := foward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	var foward_player:Vector3 = player.global_basis.z.normalized()
	
	var dot:float = foward_player.dot(move_direction)

	if dot > 0.7:
		player.velocity.x = lerpf(player.velocity.x, move_direction.x * front_aerial_speed, aerial_acceleration * delta)
		player.velocity.z = lerpf(player.velocity.z, move_direction.z * front_aerial_speed, aerial_acceleration * delta)
	elif dot < -3:
		player.velocity.x = lerpf(player.velocity.x, (move_direction.x * aerial_speed) * 0.5, aerial_acceleration * delta)
		player.velocity.z = lerpf(player.velocity.z, (move_direction.z * aerial_speed) * 0.5, aerial_acceleration * delta)
	else:
		player.velocity.x = lerpf(player.velocity.x, move_direction.x * aerial_speed, aerial_acceleration * delta)
		player.velocity.z = lerpf(player.velocity.z, move_direction.z * aerial_speed, aerial_acceleration * delta)
		
	handle_gravity(delta)
	player.move_and_slide()
