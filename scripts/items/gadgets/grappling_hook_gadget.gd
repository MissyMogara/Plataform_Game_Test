class_name GrapplingHook extends Gadget

var rope:Node
var hook:Node
var hand_gadget:Node

func _init() -> void:
	item_name = "GrapplingHook"
	item_type = ItemTypes.Gadget
	
func _ready() -> void:
	hide_rope()
	
func set_item_node(node:Node) -> void:
	item_node = node

func unhide_rope() -> void:
	rope.visible = true
	
func hide_rope() -> void:
	rope.visible = false
	
func look_at_and_scale(target: Vector3, distance: float):
	scale_rope(target)
	
func scale_rope(target: Vector3) -> void:
	
	var start = hand_gadget.global_position
	var dir = target - start
	var distance = dir.length()
	
	hook.global_position = target
	rope.look_at(target, Vector3.UP)
	rope.scale.z = -(distance * -5)
