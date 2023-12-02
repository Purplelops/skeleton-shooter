extends Node2D

var enemy_scene: PackedScene = load("res://Scenes/Enemy.tscn")
var score: int = 0
var highscore: int = 0
var timer: Timer
var is_game_over = false
var spawns_per_second: int = 20

var save_path = "user://highscore.save"

func _ready():
	randomize()
	
	# Enemy spawn timer
	timer = Timer.new()
	timer.wait_time = 0.2
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout.bind())
	add_child(timer)
	
	# Other
	load_score()
	$Player.hit.connect(_on_player_hit.bind())
	$HighscoreLabel.text = "Highscore: " + str(highscore)


func _process(delta):
	if Input.is_action_just_pressed("Restart") and is_game_over: 
		get_tree().reload_current_scene()
	
	# Reduce spawn time
	if timer.wait_time < (1.0 / spawns_per_second):
		pass
	else:
		timer.wait_time -= 0.005 * delta


func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(350, randi_range(30, 152))
	add_child(enemy)
	enemy.hit.connect(_on_enemy_hit.bind())


func _on_enemy_hit():
	score += 1
	$ScoreLabel.text = "Score: " + str(score)
	$EnemyHit.play()


func _on_timer_timeout():
	spawn_enemy()


func _on_player_hit():
	if score <= highscore:
		pass
	else:
		highscore = score
		save_score()

	$HighscoreLabel.text = "Highscore: " + str(highscore)
	$RestartLabel.visible = true
	is_game_over = true


func save_score():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(highscore)


func load_score():
	if FileAccess.file_exists(save_path):
		print("file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		highscore = file.get_var()
	else:
		print("file not found")
		highscore = 0
