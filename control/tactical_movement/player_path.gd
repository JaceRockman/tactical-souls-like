extends Node2D

@onready var player = $"../Player"

func _process(delta):
	queue_redraw()

func _draw():
	if player.current_point_path:
		draw_polyline(player.current_point_path, Color.RED, 2.0)
	
	if player.global_position == player.target_position:
		return
