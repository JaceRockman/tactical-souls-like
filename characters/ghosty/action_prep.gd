extends State

@export var animation_player: AnimationPlayer
@export var animation_name: String
@export var attack_state: State
@export var evade_state: State
@export var jump_state: State
@export var move_forward_state: State
@export var move_back_state: State

func enter() -> void:
	animation_player.play(animation_name)

func update(delta: float) -> State:
	if Input.is_action_just_released("Attack"):
		return attack_state
	if Input.is_action_just_released("Defend"):
		return evade_state
	if Input.is_action_just_released("Jump"):
		return jump_state
	if Input.is_action_just_released("Move Forward"):
		return move_forward_state
	if Input.is_action_just_released("Move Back"):
		return move_back_state
	return null

func exit() -> void:
	pass
