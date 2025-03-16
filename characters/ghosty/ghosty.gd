extends AnimatedSprite2D

@export var max_health = 5
@export var current_health = 5
@export var damage_state = 0
@export var invulnerable = false
var combat_position: Vector2 = Vector2(1, 0)

@onready var state_machine = $StateMachine
@onready var astar_grid: AStarGrid2D = AStarGrid2D.new()

enum Direction {
	FOREWARD,
	BACKWARD,
}

signal start_movement(direction: String)
signal finish_movement(direction: String)
signal new_combat_position(movement_vector: Vector2)
signal damage(amount: int, target_positions)

func _ready() -> void:
	state_machine.init()
	if $Map:
		astar_grid.region = $"../Map/TileMapLayer".get_used_rect()
		astar_grid.cell_size = Vector2(16, 16)
		astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
		astar_grid.update()

func _process(delta: float) -> void:
	state_machine.update(delta)
	if damage_state > 0:
		damage_state -= 1
	elif damage_state == 0:
		$".".set_modulate(Color(1, 1, 1, 1))
		$".".modulate

func _on_damage(damage_amount: int, target_positions) -> void:
	print(target_positions)
	print(combat_position)
	if target_positions.has(combat_position):
		damage_state = 6
		current_health -= damage_amount
		$".".set_modulate(Color(1, 0, 0, 1))
		$".".modulate

func attack(damage_quantity: int, target_positions) -> void:
	emit_signal("damage", damage_quantity, target_positions)


func movement(direction: String, movement_start: bool):
	match direction:
		"BACKWARD":
			if movement_start:
				update_combat_position(Vector2(1, 0))
				emit_signal("start_movement", direction)
			else:
				position.x -= 24
				emit_signal("finish_movement", direction)
		"FOREWARD":
			if movement_start:
				update_combat_position(Vector2(-1, 0))
				emit_signal("start_movement", direction)
			else:
				position.x += 24
				emit_signal("finish_movement", direction)

func update_combat_position(movement_vector: Vector2):
	combat_position += movement_vector
	emit_signal("new_combat_position", movement_vector)

func flip():
	scale = scale * Vector2(-1, 1)

func jump():
	update_combat_position(Vector2(0, 1))

func land():
	update_combat_position(Vector2(0, -1))
