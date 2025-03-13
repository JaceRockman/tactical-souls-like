extends State

@export var animation_player: AnimationPlayer
@export var animation_name: String
@export var attack_state: State
@export var evade_state: State

func enter() -> void:
	animation_player.play(animation_name)

func update(delta: float) -> void:
	if Input.is_action_just_released("Attack"):
		attack_state
	if Input.is_action_just_released("Evade"):
		evade_state

func exit() -> void:
	pass
