extends CharacterBody2D

signal game_over

@onready var _sprite = $AnimatedSprite2D
@onready var _hitbox = $HitBox
@onready var _hurtbox = $HurtBox
@onready var _healthbar = $ProgressBar

const ENEMY_DAMAGE_RATE = 5.0 

const SPEED = 100.0
const ATTACK_SPEED = 2.0
const MAX_HEALTH = 100.0

var attack_timer = 0.0

var health = MAX_HEALTH

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
	if health >= 0.0:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * SPEED
		move_and_slide()
		
		_hitbox.look_at(get_global_mouse_position())
		
		attack_timer -= delta
		if attack_timer <= 0:
			_hitbox.activate()
			attack_timer = ATTACK_SPEED
	
	var overlapping_mobs = _hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= ENEMY_DAMAGE_RATE * overlapping_mobs.size() * delta
		_healthbar.value = health
		if health <= 0.0:
			game_over.emit()
