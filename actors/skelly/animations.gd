extends Node2D

@export var body_color: Color
@export var eye_color: Color
@export var feet_color: Color
@export var hand_color: Color
@export var sword_color: Color
@export var axe_color: Color
@export var head_color: Color

func _ready() -> void:
	$Body.set_modulate(body_color)
	$Eyes.set_modulate(eye_color)
	$Head.set_modulate(head_color)
	$Hands.set_modulate(hand_color)
	$Sword.set_modulate(sword_color)
	$Axe.set_modulate(axe_color)
	$Feet.set_modulate(feet_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
