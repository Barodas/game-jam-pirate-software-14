class_name HitBox
extends Area2D

@onready var _collider = $CollisionShape2D
@onready var _animator = $AnimationPlayer

@export var damage := 10

func _init():
	collision_layer = 2
	collision_mask = 0

func _ready():
	_collider.disabled = false

func activate():
	_animator.play("attack")
