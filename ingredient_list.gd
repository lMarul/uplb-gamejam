extends Control

func set_child_mouse_filter_ignore(node):
	if node is Control:
		node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for child in node.get_children():
		set_child_mouse_filter_ignore(child)
		
func _on_mixbutton_stop_drop() -> void:
	set_child_mouse_filter_ignore(self)
