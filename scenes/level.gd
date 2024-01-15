extends Node2D

@onready var _player_spawn = $Player/Path2D/PlayerSpawnPath
@onready var _game_over_screen = $GameOverScreen

const SPAWN_INTERVAL = 0.3

var spawn_timer = 0.0

func _ready():
	for n in 10:
		spawn_mob()

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		spawn_mob()
		spawn_timer = SPAWN_INTERVAL

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func spawn_mob():
	var new_mob = preload("res://scenes/enemy_mouse.tscn").instantiate()
	_player_spawn.progress_ratio = randf()
	new_mob.global_position = _player_spawn.global_position
	add_child(new_mob)


func _on_player_game_over():
	_game_over_screen.visible = true
	# TODO: button to return to menu
	# TODO: display score/run stats
