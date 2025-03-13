extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar
@export var combatant: AnimatedSprite2D

var deplete_damage = false

func _ready() -> void:
	max_value = combatant.max_health
	value = combatant.max_health
	damage_bar.max_value = max_value
	damage_bar.value = value

func _process(delta: float) -> void:
	value = combatant.current_health
	
	if value < damage_bar.value and timer.is_stopped():
		timer.start()
	
	if deplete_damage:
		damage_bar.value = maxf(damage_bar.value - 0.1, value)
	
	if value >= damage_bar.value:
		deplete_damage = false

func _on_timer_timeout() -> void:
	deplete_damage = true
