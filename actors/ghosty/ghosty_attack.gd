extends Node2D

@export var body_color: Color
@export var eye_color: Color
@export var pupil_color: Color
@export var slash_color: Color

func _ready() -> void:
	$Body.set_modulate(body_color)
	$Eye.set_modulate(eye_color)
	$Pupil.set_modulate(pupil_color)
	$Slash.set_modulate(slash_color)

func play():
	$Animation.play("ghosty/attack")

func _process(delta: float) -> void:
	pass
