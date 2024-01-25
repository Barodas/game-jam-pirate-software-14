extends StaticBody2D

@onready var level = get_node("/root/Level")
@onready var follower_pool = get_node("/root/Level/FollowerPool")

@onready var _sprite = $AnimatedSprite2D
@onready var _healthbar = $HealthBar
@onready var _bossbar = $BossSpawnBar
@onready var _spawn = $Path2D/PathFollow2D

@export var total_health = 30.0
@export var exp = 20.0
@export var enemy_spawn_time = 3.0
@export var boss_health = 100.0
@export var boss_spawn_time = 30.0

var claimed: bool = false
var health = 30.0
var spawn_timer = 0.0
var boss_timer = 0.0
var boss_slain = false
var boss_spawned = false

func _ready():
	health = total_health
	spawn_timer = enemy_spawn_time
	_bossbar.max_value = boss_spawn_time

func _process(delta):
	if !claimed && health <= 0:
		if !boss_spawned && boss_timer < boss_spawn_time:
			spawn_boss(boss_timer / boss_spawn_time)
		if boss_slain:
			den_claimed()
	
	spawn_timer -= delta
	boss_timer += delta
	
	_bossbar.value = boss_timer
	if !claimed && !boss_spawned && boss_timer >= boss_spawn_time:
		spawn_boss(1.0)
	
	if claimed:
		_sprite.play("claimed")
	else:
		_sprite.play("default")
		if spawn_timer <= 0.0:
			spawn_mob()
			spawn_timer = enemy_spawn_time

func spawn_mob():
	var new_mob
	if claimed:
		new_mob = preload("res://scenes/follower.tscn").instantiate()
	else:
		new_mob = preload("res://scenes/enemy_mouse.tscn").instantiate()
	_spawn.progress_ratio = randf()
	new_mob.global_position = _spawn.global_position
	if claimed:
		follower_pool.add_child(new_mob)
	else:
		level.add_child(new_mob)

func take_damage(amount: float):
	health -= amount
	var health_percent = (health / total_health) * 100.0
	_healthbar.value = health_percent
	#print("Den takes damage: ", amount)

func spawn_boss(percent_health: float):
	_bossbar.visible = false
	boss_spawned = true
	var new_mob = preload("res://scenes/enemy_boss.tscn").instantiate()
	_spawn.progress_ratio = randf()
	new_mob.global_position = _spawn.global_position
	level.add_child(new_mob)
	new_mob.health = boss_health * percent_health
	new_mob.max_health = boss_health
	new_mob._healthbar.value = boss_health * percent_health
	new_mob._healthbar.max_value = boss_health
	#print("Spawning Boss with ", new_mob.health, " / ", new_mob.max_health, " HP")
	new_mob.boss_slain.connect(_on_boss_slain)

func den_claimed():
	claimed = true
	_healthbar.visible = false
	_bossbar.visible = false
	for n in 2:
		spawn_mob()
	Signals.send_exp.emit(exp, 2)
	Signals.update_tally.emit(0, 0, 1)
	
func _on_boss_slain():
	boss_slain = true
