extends CharacterBody2D

@onready var _sprite = $AnimatedSprite2D
@onready var _detectionbox = $DetectionBox

const SPEED = 50.0

@export var health = 1.0
@export var exp = 1.0

@onready var player = get_node("/root/Level/Player")

func _process(delta):
	if health <= 0:
		Signals.send_exp.emit(exp)
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
	#print("Mouse takes damage: ", amount)
