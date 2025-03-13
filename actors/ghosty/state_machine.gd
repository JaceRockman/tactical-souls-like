extends Node

@export var animation_player: AnimationPlayer
@export var initial_state: State
var current_state: State

# Called when the node enters the scene tree for the first time.
func init() -> void:
	change_state(initial_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	var new_state = current_state.update(delta)
	if new_state:
		change_state(new_state)
	
	if current_state:
		current_state.update(delta)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
		
	current_state = new_state
	current_state.enter()
