extends Node2D

@export var body_color: Color
@export var eye_color: Color
@export var head_color: Color
@export var right_arm_color: Color
@export var left_arm_color: Color
@export var right_leg_color: Color
@export var left_leg_color: Color
@export var wing_color: Color


func _ready() -> void:
	$Head.set_modulate(body_color)
	$Eyes.set_modulate(eye_color)
	$Torso.set_modulate(body_color)
	$"Right Arm".set_modulate(right_arm_color)
	$"Left Arm".set_modulate(left_arm_color)
	$"Right Leg".set_modulate(right_leg_color)
	$"Left Leg".set_modulate(left_leg_color)
	$Wings.set_modulate(wing_color)

func _process(delta: float) -> void:
	pass
