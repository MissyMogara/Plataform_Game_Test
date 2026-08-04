extends StateBase

var gravity := -30.0

func on_physics_process(delta):
	pass
	#controlled_node.play_anim("standing")
	#controlled_node.velocity.y = 0
	
	#handle_gravity(delta)
	#controlled_node.move_and_slide()
	
func handle_gravity(delta):
	controlled_node.velocity.y += gravity * delta
