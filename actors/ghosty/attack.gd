extends State

@export var animation_player: AnimationPlayer
@export var animation_name: String
@export var buffer_size: float
@export var attack_state: State
@export var evade_state: State
@export var idle_state: State

var buffered_state: State

func enter() -> void:
	animation_player.play(animation_name)

func in_buffer() -> bool:
	var remaining_animation = animation_player.current_animation_length - animation_player.current_animation_position
	return remaining_animation < buffer_size

func update(delta: float) -> State:
	if Input.is_action_just_released("Attack") and in_buffer():
		buffered_state = attack_state
	if Input.is_action_just_released("Defend") and in_buffer():
		buffered_state = evade_state
	if !animation_player.current_animation and !buffered_state:
		return idle_state
	elif !animation_player.current_animation and buffered_state:
		return buffered_state
		exit()
	return null

func exit() -> void:
	buffered_state = null
