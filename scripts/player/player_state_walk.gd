extends PlayerMovementAndGravity

func on_physics_process(delta):
	player.play_anim("walking")
	
	var raw_input:Vector2 = get_raw_input()
	move_character(raw_input, move_speed, delta)
	
	if not player.is_on_floor():
		state_machine.change_to(player.states.Coyote)
	
	handle_gravity(delta)
	player.move_and_slide()
		
func on_input(event):
	var raw_input:Vector2 = get_raw_input()
	
	if Input.is_action_just_pressed("sprint"):
		state_machine.change_to(player.states.Running)
		
	if Input.is_action_just_pressed("space_bar"):
		state_machine.change_to(player.states.Jumping)
	
	if not raw_input:
		state_machine.change_to(player.states.Idle)
