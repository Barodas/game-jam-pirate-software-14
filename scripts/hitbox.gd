class_name HitBox
extends Area2D

@onready var _collider = $CollisionShape2D

@export var damage := 10

var timer = 0.0

func _init():
	collision_layer = 2
	collision_mask = 0

func _physics_process(delta):
	if(!_collider.disabled):
		timer -= delta
		if timer <= 0:
			_collider.disabled = true

func activate(duration: float):
	timer = duration
	_collider.disabled = false
