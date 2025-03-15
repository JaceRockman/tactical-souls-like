extends AnimatedSprite2D

@onready var animated_sprite: AnimatedSprite2D = $"."

var health = 5
var damage_state = 13

signal damage(amount: int)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	damage_state += 1
	
	if damage_state > 12:
			animated_sprite.set_modulate(Color(1, 1, 1, 1))
			animated_sprite.modulate
	
	if animated_sprite.animation == "attack":
		if Input.is_action_just_pressed("Attack") and animated_sprite.frame < 7:
			var current_frame = animated_sprite.frame
			var current_progress = animated_sprite.frame_progress
			animated_sprite.play("followup attack")
			animated_sprite.set_frame_and_progress(current_frame, current_progress)
		
		if animated_sprite.frame == 4:
			emit_signal("damage", 1)
	
	if animated_sprite.animation == "jump":
		if Input.is_action_just_pressed("Attack") and animated_sprite.frame < 5:
			var current_frame = animated_sprite.frame
			var current_progress = animated_sprite.frame_progress
			animated_sprite.play("jump attack")
			animated_sprite.set_frame_and_progress(current_frame, current_progress)
	
	if animated_sprite.animation == "followup attack" and animated_sprite.frame == 4:
		emit_signal("damage", 1)
		
	if animated_sprite.animation == "followup attack" and animated_sprite.frame == 6:
		emit_signal("damage", 1)
		
	if animated_sprite.animation == "jump attack" and animated_sprite.frame == 7:
		emit_signal("damage", 2)
	
	if animated_sprite.animation == "idle":
		if Input.is_action_just_pressed("Jump"):
			animated_sprite.play("jump")
		elif Input.is_action_just_pressed("Attack"):
			animated_sprite.play("attack")
	
	if !animated_sprite.is_playing(): 
		animated_sprite.play("idle")

func _on_damage(amount: int, duration: int) -> void:
	if damage_state > 12:
		if animated_sprite.animation == "idle" or animated_sprite.animation == "attack" or animated_sprite.animation == "attack followup":
			damage_state = 0
			health -= amount
			print(health)
			animated_sprite.set_modulate(Color(1, 0, 0, 1))
			animated_sprite.modulate
