extends AnimatedSprite2D

@onready var spectre: AnimatedSprite2D = $"."
@onready var anim: AnimationPlayer = $"AnimationPlayer"

var health = 5
@export var damage_state = 0
@export var invulnerable = false

signal damage(amount: int)

func _process(delta: float) -> void:
	if damage_state > 0:
		damage_state -= 1
	elif damage_state == 0:
		spectre.set_modulate(Color(1, 1, 1, 1))
		spectre.modulate

func _on_damage(damage_amount: int) -> void:
	if !invulnerable:
		damage_state = 6
		health -= damage_amount
		spectre.set_modulate(Color(1, 0, 0, 1))
		spectre.modulate

func attack(damage_quantity: int) -> void:
	emit_signal("damage", damage_quantity)
