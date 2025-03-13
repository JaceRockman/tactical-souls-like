extends AnimatedSprite2D

@export var max_health = 5
@export var current_health = 5
@export var damage_state = 0
@export var invulnerable = false

@onready var state_machine = $StateMachine
@onready var astar_grid: AStarGrid2D = AStarGrid2D.new()

signal damage(amount: int)

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

func _on_damage(damage_amount: int) -> void:
	if !invulnerable:
		damage_state = 6
		current_health -= damage_amount
		$".".set_modulate(Color(1, 0, 0, 1))
		$".".modulate

func attack(damage_quantity: int) -> void:
	emit_signal("damage", damage_quantity)

enum Directions {
	LEFT,
	RIGHT
}

func move(direction: String):
	match direction:
		"LEFT": position.x -= 12
		"RIGHT": position.x += 12
