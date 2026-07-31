extends Node

signal quesadillas_changed()

#Player Info
var quesadillas : int = 0

func save_game():
	var data = SaveData.new()
	#Save Player position
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
	data.player_position = player.global_position
	#Save all elements in level
	var level_elements: Array[Node] = get_tree().get_nodes_in_group("level_elements")
	for element in level_elements:
		var element_scene = PackedScene.new()
		element_scene.pack(element)
		data.scene_elements.append(element)
	ResourceSaver.save(data, "user://save.tres")
	
func load_game():
	if ResourceLoader.exists("user://save.tres"):
		var data = load("user://save.tres")
		var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
		player.global_position = data.player_position
		#Delete all elements in level
		var level_elements: Array[Node] = get_tree().get_nodes_in_group("level_elements")
		for element in level_elements:
			element.queue_free()
		#Add all data elements into current scene
		for packed_element in data.scene_elements:
			var element_instance = packed_element.instantiate()
			get_tree().current_scene.add_child(element_instance)

func add_quesadilla(amount: int):
	quesadillas += amount
	quesadillas_changed.emit(quesadillas)
	
func reset_quesadillas():
	quesadillas = 0
	quesadillas_changed.emit(quesadillas)
	
func kill_all_tweens():
	for tween in get_tree().get_processed_tweens():
		tween.kill()
