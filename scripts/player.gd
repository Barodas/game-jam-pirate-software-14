extends CharacterBody2D

@onready var _sprite = $AnimatedSprite2D

const SPEED = 300.0

func _process(delta):
	if velocity.length() > 0.0:
		_sprite.play("walk")
	else:
		_sprite.play("idle")
	
	if Input.is_action_pressed("move_left"):
		_sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		_sprite.flip_h = false

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * (SPEED * delta)
	move_and_slide()
