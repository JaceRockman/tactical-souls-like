extends Node2D

var combatant_distance: int = 1

enum Direction {
	FOREWARD,
	BACKWARD,
}

var virtual_position: float

func _process(_delta):
	if virtual_position != position.x:
		virtual_position = fmod(position.x, 256)
		$ForestBackground1.global_position.x = virtual_position - 128
		$ForestBackground2.global_position.x = virtual_position + 128
		$ForestBackground3.global_position.x = virtual_position + 384

func _on_player_start_movement(direction: String) -> void:
	match direction:
		"FOREWARD": combatant_distance -= 1
		"BACKWARD": combatant_distance += 1

func _on_player_finish_movement(direction: String) -> void:
	var tween = get_tree().create_tween()
	match direction:
		"FOREWARD": tween.tween_property(self, "position", position - Vector2(12, 0), 0.5)
		"BACKWARD": tween.tween_property(self, "position", position + Vector2(12, 0), 0.5)
