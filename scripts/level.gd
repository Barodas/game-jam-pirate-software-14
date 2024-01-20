extends Node2D

@onready var _player_spawn = $Player/Path2D/PlayerSpawnPath
@onready var _game_over_screen = $GameOverScreen
@onready var _level_label = $HUD/LevelLabel
@onready var _exp_bar = $HUD/ProgressBar
@onready var _followers = $FollowerPool

const SPAWN_INTERVAL = 10.0

var spawn_timer = 0.0

func _ready():
	pass

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		spawn_mob(30)
		spawn_timer = SPAWN_INTERVAL

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func spawn_mob(count: int):
	_player_spawn.progress_ratio = randf()
	for n in count:
		var new_mob = preload("res://scenes/enemy_mouse.tscn").instantiate()
		new_mob.global_position = _player_spawn.global_position + Vector2(0.01 * n, 0.01 * n)
		add_child(new_mob)

func _on_player_game_over():
	_game_over_screen.visible = true
	# TODO: button to return to menu
	# TODO: display score/run stats


func _on_player_gained_exp(level, exp):
	_level_label.text = str(level)
	_exp_bar.value = exp
