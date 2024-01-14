extends CharacterBody2D

@onready var _sprite = $AnimatedSprite2D
@onready var _hitbox = $HitBox

const SPEED = 100.0
const ATTACK_SPEED = 2.0

var attack_timer = 0.0

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
	velocity = direction * SPEED
	move_and_slide()
	
	_hitbox.look_at(get_global_mouse_position())
	
	attack_timer -= delta
	if attack_timer <= 0:
		_hitbox.activate()
		attack_timer = ATTACK_SPEED
