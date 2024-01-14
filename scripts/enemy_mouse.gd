extends CharacterBody2D

@onready var _sprite = $AnimatedSprite2D

const SPEED = 100.0

@onready var player = get_node("/root/Level/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	
	move_and_slide()
