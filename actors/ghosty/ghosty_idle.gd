class_name ModularAnimation
extends Node2D

@export var body_color: Color
@export var eye_color: Color
@export var pupil_color: Color
@onready var player: AnimationPlayer = $Animation

func _ready() -> void:
	$Body.set_modulate(body_color)
	$Eye.set_modulate(eye_color)
	$Pupil.set_modulate(pupil_color)

func play():
	$Animation.play("ghosty/idle")

func _process(delta: float) -> void:
	pass
