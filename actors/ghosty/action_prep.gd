extends State

@export var animation_player: AnimationPlayer
@export var animation_name: String
@export var attack_state: State
@export var evade_state: State

func enter() -> void:
	animation_player.play(animation_name)

func update(delta: float) -> State:
	if Input.is_action_just_released("Attack"):
		return attack_state
	if Input.is_action_just_released("Defend"):
		return evade_state
	return null

func exit() -> void:
	pass
