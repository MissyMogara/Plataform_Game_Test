class_name Hand extends Node

var item:Item 
var actual_node:Node

func _ready() -> void:
	actual_node = self.get_child(0)
	if actual_node.name == "Grappling_Hook_Gadget":
		item = GrapplingHook.new()
		item.item_node = self.get_child(0)
		item.set_item_node(actual_node)
		print(item.item_name)
		print(item.item_type)
		print(item.item_node)
	else:
		print("No hay objeto")
		
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		use_item()
		

#Change actual object/gadget
func change_item(object: Node) -> void:
	item = object
	
#Use actual object/gadget
func use_item() -> void:
	pass
	
#Get Item
func get_item() -> Node:
	return item
