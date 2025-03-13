@tool
extends Node2D

class_name ModularAnimatedSprite2D

func _process(_delta):
	for child in get_children():
		if child is Node2D:
			child.set_modulate(child.color)
			child.modulate
