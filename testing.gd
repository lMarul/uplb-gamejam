extends TextureRect

func _get_drag_data(at_position):
	return texture

func _can_drop_data(_pos, data):
	print("👀 Dragged data received")
	print("📦 Class type:", typeof(data), ", Class name:", data.get_class())
	return data is Texture

func _drop_data(_pos, data):
	texture = data
