class_name ToonStyle

extends Resource

func add_outline(mesh_instance: MeshInstance3D, width := 0.05):
	var outline: MeshInstance3D = MeshInstance3D.new()
	outline.mesh = mesh_instance.mesh
	outline.transform = mesh_instance.transform
	
	var mat: ShaderMaterial = ShaderMaterial.new()
	mat.shader = preload("res://shaders/outline.gdshader")
	mat.set_shader_parameter("outline_width", width)
	
	for i in outline.mesh.get_surface_count():
		outline.set_surface_override_material(i, mat)
		
	mesh_instance.add_child(outline)
