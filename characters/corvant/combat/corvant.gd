extends AnimatedSprite2D

@onready var corvant: AnimatedSprite2D = $"."

@export var anim: AnimationPlayer

var rng = RandomNumberGenerator.new()
var frame_counter = 0
var attack_count = 200
var damage_state = 0
@export var invulnerable = false
@export var max_health = 5
@export var current_health = 5

signal damage(amount: int)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	frame_counter += 1
	
	if damage_state > 0:
		damage_state -= 1
	elif damage_state == 0:
		corvant.set_modulate(Color(1, 1, 1, 1))
		corvant.modulate
	
	if current_health <= 0:
		corvant.queue_free()
	
	if frame_counter >= attack_count:
		anim.play("corvant/attack")
		frame_counter = 0
	
	if !anim.is_playing():
		anim.play("corvant/idle")

func attack(damage_quantity: int):
	emit_signal("damage", damage_quantity)

func plan_next_attack():
	frame_counter = 0
	attack_count = rng.randi_range(60, 150)

func _on_damage(damage_amount: int) -> void:
	if !invulnerable:
		damage_state = 6
		current_health -= damage_amount
		corvant.set_modulate(Color(1, 0, 0, 1))
		corvant.modulate
