extends CharacterBody2D

@onready var _sprite = $AnimatedSprite2D
@onready var _hurtbox = $HurtBox

const ENEMY_DAMAGE_RATE = 1.0 

const CHASE_SPEED = 80.0
const WANDER_SPEED = 0.0

@export var health = 20.0
@export var damage = 5.0

@onready var player = get_node("/root/Level/Player")
@onready var _detectionbox = player.get_node("DetectionBox")

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
	# Take damage from nearby enemies
	var overlapping_mobs = _hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= ENEMY_DAMAGE_RATE * overlapping_mobs.size() * delta
	
	var direction = global_position.direction_to(player.global_position)
	
	# Seek out nearby enemies to attack
	var mobs_in_range = _detectionbox.get_overlapping_bodies()
	var wander = false
	if mobs_in_range.size() > 0:
		var nearest_index = mobs_in_range.size()
		var nearest_dist = 1000.0
		for n in mobs_in_range.size():
			var dist_to_enemy = global_position.distance_to(mobs_in_range[n].global_position)
			if dist_to_enemy < nearest_dist:
				nearest_index = n
				nearest_dist = dist_to_enemy
		if nearest_dist < 20:
			if mobs_in_range[nearest_index].has_method("take_damage"):
				mobs_in_range[nearest_index].take_damage(damage * delta)
		else:
			direction = global_position.direction_to(mobs_in_range[nearest_index].global_position)
	else:
		if global_position.distance_to(player.global_position) < 150:
			# If nearby to player, pick a random direction and wander
			wander = true
			#direction = Vector2(randf_range(-1.0,1.0), randf_range(-1.0,1.0))
	velocity = direction * (WANDER_SPEED if wander else CHASE_SPEED)
	move_and_slide()

func take_damage(amount: float):
	health -= amount
	#print("Follower takes damage: ", amount)
