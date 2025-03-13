extends Node2D

class_name ModularAnimatedSprite2D

func _ready():
	for child in get_children():
		if child is Node2D:			
			child.set_modulate(child.color)
			child.modulate
