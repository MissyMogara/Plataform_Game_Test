extends PlayerMovementAndGravity

func start():
	coyote_timer.start()
	
func on_physics_process(delta):
	var raw_input:Vector2 = get_raw_input()
	player.velocity.y = 0
	
	if player.is_on_floor() and not Input.is_action_pressed("sprint"):
		state_machine.change_to(player.states.Walking)
	if player.is_on_floor() and Input.is_action_pressed("sprint"):
		state_machine.change_to(player.states.Running)
		
	if raw_input and not Input.is_action_pressed("sprint"):
		player.play_anim("walking")
		move_character(raw_input, move_speed, delta)
	elif raw_input and Input.is_action_pressed("sprint"):
		move_character(raw_input, sprint_speed, delta)
		player.play_anim("walking")
	elif not raw_input:
		state_machine.change_to(player.states.Falling)
		
	player.move_and_slide()
		
	
func on_input(event):
	if Input.is_action_just_pressed("space_bar"):
		state_machine.change_to(player.states.Jumping)


func _on_coyote_timer_timeout() -> void:
	print("Se acabo")
	state_machine.change_to(player.states.Falling)
