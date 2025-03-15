extends AnimationPlayer

@onready var anim: AnimationPlayer = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if anim.current_animation == "idle":
		#if Input.is_action_just_pressed("Defend"):
			#anim.play("evade")
		#elif Input.is_action_just_pressed("Attack"):
			#anim.play("attack")
	
	#if !anim.is_playing(): 
		#anim.play("idle")
	pass
