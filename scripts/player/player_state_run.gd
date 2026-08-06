extends PlayerMovementAndGravity

func on_physics_process(delta):
	player.play_anim("walking")
	
	var raw_input:Vector2 = get_raw_input()
	
	if not player.is_on_floor():
		state_machine.change_to(player.states.Coyote)
	
	move_character(raw_input, sprint_speed, delta)
	handle_gravity(delta)
	
	player.move_and_slide()
	
func on_input(event):
	if Input.is_action_just_pressed("space_bar"):
		state_machine.change_to(player.states.Jumping)
	
	var raw_input := Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_pressed("sprint"):
		return
		
	if Input.is_action_just_released("sprint"):
		state_machine.change_to(player.states.Walking)
		
	if not raw_input:
		state_machine.change_to(player.states.Idle)
