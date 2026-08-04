class_name StateBase extends Node

@onready var controlled_node : Node = self.owner

var stateMachine : StateMachine

#region shared methods

func start():
	pass
	
func end():
	pass

#endregion
