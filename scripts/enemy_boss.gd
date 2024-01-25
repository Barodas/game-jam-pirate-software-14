extends CharacterBody2D

signal boss_slain

@onready var _sprite = $AnimatedSprite2D
@onready var _detectionbox = $DetectionBox
@onready var _healthbar = $ProgressBar

const SPEED = 70.0

@export var max_health = 50.0
@export var health = 50.0
@export var exp = 20.0

@onready var player = get_node("/root/Level/Player")

func _ready():
	_healthbar.max_value = max_health
	_healthbar.value = health

func _process(delta):
	if health <= 0:
		Signals.send_exp.emit(exp, 1)
		Signals.update_tally.emit(0, 1, 0)
		boss_slain.emit()
		queue_free()
	
	if velocity.length() > 0.0:
		_sprite.play("walk")
	else:
		_sprite.play("idle")
	
	if velocity.x > 0.1:
		_sprite.flip_h = false
	if velocity.x < -0.1:
		_sprite.flip_h = true

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	
	# Prioritise followers if they are in range
	var mobs_in_range = _detectionbox.get_overlapping_bodies()
	if mobs_in_range.size() > 0:
		direction = global_position.direction_to(mobs_in_range[0].global_position)
	
	velocity = direction * SPEED
	move_and_slide()

func take_damage(amount: float):
	health -= amount
	_healthbar.value = health
	#print("Mouse takes damage: ", amount)
