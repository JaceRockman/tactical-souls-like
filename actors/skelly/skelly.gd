extends AnimatedSprite2D

@onready var skelly: AnimatedSprite2D = $"."
@onready var player: AnimatedSprite2D = $"Knight"

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
		skelly.set_modulate(Color(1, 1, 1, 1))
		skelly.modulate
	
	if current_health <= 0:
		skelly.queue_free()
	
	if frame_counter >= attack_count:
		anim.play("skelly/attack")
		frame_counter = 0
	
	if !anim.is_playing():
		anim.play("skelly/idle")

func attack(damage_quantity: int):
	emit_signal("damage", damage_quantity)

func plan_next_attack():
	frame_counter = 0
	attack_count = rng.randi_range(20, 150)

func _on_damage(damage_amount: int) -> void:
	if !invulnerable:
		damage_state = 6
		current_health -= damage_amount
		skelly.set_modulate(Color(1, 0, 0, 1))
		skelly.modulate
