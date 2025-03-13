extends State

@export var animation_name: String
@export var action_prep_state: State
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play(animation_name)

func update(delta: float) -> State:
	if Input.is_action_just_pressed("Attack"):
		return action_prep_state
	if Input.is_action_just_pressed("Defend"):
		return action_prep_state
	return null

func exit() -> void:
	pass
