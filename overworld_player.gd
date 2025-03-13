extends Node2D

@onready var astar_grid: AStarGrid2D = AStarGrid2D.new()
@onready var tile_map: TileMapLayer = $"../Map".tile_map
var current_id_path: Array[Vector2i]
var current_point_path: Array[Vector2]
var target_position: Vector2
var is_moving: bool
@export var move_speed: float = 4

func _ready() -> void:
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(16, 16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	for x in tile_map.get_used_rect().size.x:
		for y in tile_map.get_used_rect().size.y:
			var tile_position = Vector2i(
				x,
				y
			)
			
			var tile_data = tile_map.get_cell_tile_data(tile_position)
			
			if tile_data == null or tile_data.get_custom_data("Walkable") == false:
				astar_grid.set_point_solid(tile_position)

func _input(event):
	if event.is_action_pressed("Overworld Move") == false:
		return
	
	var id_path: Array[Vector2i] = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map(get_global_mouse_position())
	).slice(1, move_speed)
	
	if id_path.is_empty() == false:
		current_id_path = id_path
		
		current_point_path.assign(
			astar_grid.get_point_path(
				tile_map.local_to_map(global_position),
				tile_map.local_to_map(get_global_mouse_position())
			).slice(0, move_speed)
		)
		
		for i in current_point_path.size():
			current_point_path[i] += Vector2(8, 8)

func _process(delta):
	if current_id_path.is_empty():
		return
	
	if global_position == $"../Corvant".global_position:
		get_tree().change_scene_to_file("res://tutorial_combat.tscn")
	
	if is_moving == false:
		target_position = tile_map.map_to_local(current_id_path.front())
		is_moving = true
	
	global_position = global_position.move_toward(target_position, 1)
	
	if global_position == target_position:
		current_id_path.pop_front()
		current_point_path.pop_front()
		
		if current_id_path.is_empty() == false:
			target_position = tile_map.map_to_local(current_id_path.front())
		else:
			is_moving = false
