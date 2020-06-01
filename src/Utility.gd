extends Node

# has mostly static methods that all scripts might at some point use,
# for utility

# returns the project's screen size, not the dynamic one
func get_screen_size() -> Vector2:
	return get_node("/root").size
#	var width: float = ProjectSettings.get_setting("display/window/size/width")
#	var height: float = ProjectSettings.get_setting("display/window/size/height")
#	return Vector2(width, height)
