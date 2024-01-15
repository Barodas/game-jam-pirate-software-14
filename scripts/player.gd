extends CharacterBody2D

signal game_over
signal gained_exp(level: int, exp: float)

@onready var _sprite = $AnimatedSprite2D
@onready var _hitbox = $HitBox
@onready var _hurtbox = $HurtBox
@onready var _healthbar = $ProgressBar

const ENEMY_DAMAGE_RATE = 5.0 

const SPEED = 100.0
const ATTACK_SPEED = 2.0
const MAX_HEALTH = 100.0
const EXP_PER_LEVEL = 100.0

var attack_timer = 0.0

var health = MAX_HEALTH
var level = 1
var exp = 0.0

func _ready():
	Signals.send_exp.connect(_on_receive_exp)

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

func _on_receive_exp(amount):
	exp += amount
	if exp >= EXP_PER_LEVEL:
		exp -= EXP_PER_LEVEL
		level += 1
	var exp_percent: float = exp / EXP_PER_LEVEL
	gained_exp.emit(level, exp_percent)
