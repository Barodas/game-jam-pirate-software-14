extends CharacterBody2D

@onready var _sprite = $AnimatedSprite2D

const SPEED = 50.0

@export var health = 10

@onready var player = get_node("/root/Level/Player")

func _process(delta):
	if health <= 0:
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
	velocity = direction * SPEED
	
	move_and_slide()

func take_damage(amount: int):
	health -= amount
	print("Mouse takes damage: ", amount)
