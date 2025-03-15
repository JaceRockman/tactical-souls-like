extends Node

@export var initial_state: State
var current_state: State

func init() -> void:
	change_state(initial_state)

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
