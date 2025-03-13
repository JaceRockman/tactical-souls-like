@tool
extends EditorInspectorPlugin

const MASInspectorDock = preload("./modular_animated_sprite_inspector_dock.tscn")

func _can_handle(object):
	return object is ModularAnimatedSprite2D


func _parse_end(object):
	var dock = MASInspectorDock.instantiate()
	dock.target_node = object
	add_custom_control(dock)
