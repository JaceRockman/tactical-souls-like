extends Button

func _ready():
	get_tree().change_scene_to_file("res://levels/tutorial/tutorial_combat.tscn")
	self.pressed.connect(_button_pressed)

func _button_pressed():
	get_tree().change_scene_to_file("res://levels/tutorial/tutorial_overworld.tscn")
