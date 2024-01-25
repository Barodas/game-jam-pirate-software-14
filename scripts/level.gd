extends Node2D

@onready var _player_spawn = $Player/Path2D/PlayerSpawnPath
@onready var _game_over_screen = $GameOverScreen
@onready var _game_over_button = $GameOverScreen/ColorRect/Button
@onready var _game_over_title = $GameOverScreen/ColorRect/Title
@onready var _game_over_comment = $GameOverScreen/ColorRect/Comment
@onready var _game_over_enemies = $GameOverScreen/ColorRect/Enemies
@onready var _game_over_bosses = $GameOverScreen/ColorRect/Bosses
@onready var _game_over_dens = $GameOverScreen/ColorRect/Dens
@onready var _level_label = $HUD/LevelLabel
@onready var _exp_bar = $HUD/ProgressBar
@onready var _followers = $FollowerPool

const SPAWN_INTERVAL = 10.0
const DEN_VICTORY_COUNT = 26

var spawn_timer = 0.0

var tally_enemies = 0
var tally_bosses = 0
var tally_dens = 0

func _ready():
	Signals.update_tally.connect(_update_tally)
	_game_over_button.pressed.connect(_return_button_pressed)

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		spawn_mob(30)
		spawn_timer = SPAWN_INTERVAL
	if tally_dens >= DEN_VICTORY_COUNT:
		_on_player_game_over(true)

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func spawn_mob(count: int):
	_player_spawn.progress_ratio = randf()
	for n in count:
		var new_mob = preload("res://scenes/enemy_mouse.tscn").instantiate()
		new_mob.global_position = _player_spawn.global_position + Vector2(0.01 * n, 0.01 * n)
		add_child(new_mob)

func _on_player_game_over(victory: bool):
	if victory:
		_game_over_title.text = "VICTORY!"
		_game_over_comment.text = "The ecosystem has been overrun"
		_game_over_enemies.text = "Enemies Slain: " + str(tally_enemies)
		_game_over_bosses.text = "Bosses Slain: " + str(tally_bosses)
		_game_over_dens.text = "Dens Conquered: " + str(tally_dens)
	else:
		_game_over_title.text = "DEFEAT"
		_game_over_comment.text = "The ecosystem drove you away"
		_game_over_enemies.text = "Enemies Slain: " + str(tally_enemies)
		_game_over_bosses.text = "Bosses Slain: " + str(tally_bosses)
		_game_over_dens.text = "Dens Conquered: " + str(tally_dens)
	_game_over_screen.visible = true


func _on_player_gained_exp(level, exp):
	_level_label.text = str(level)
	_exp_bar.value = exp

func _update_tally(enemies: int, bosses: int, dens: int):
	tally_enemies += enemies
	tally_bosses += bosses
	tally_dens += dens

func _return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
