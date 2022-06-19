extends Node

var game = preload("res://scr/game/Game.tscn")
onready var admob = $AdMob

var score = 0
var highscore = 0
var max_score = 10

var is_level_up = false
var power = true

var massage_text = null

func _ready() -> void:
	loadAds()
	admob.show_banner()
	load_score()
	$HUD.hide()
	$HUD.massage_hide()
	power = false
	get_tree().connect("screen_resized", self, "_on_resize")

func loadAds():
	admob.load_banner()
	admob.load_interstitial()
	

func _process(delta: float) -> void:
	if score == max_score:
		is_level_up = true
		level_up()
	if score == 100:
		massage_text = "You Are The Best"
		massage_pop_up()
	$HUD.massage(massage_text)

func new_game() -> void:
	power = true
	admob.hide_banner()
	var new_game = game.instance()
	add_child(new_game)
	score = 0
	level_reset()
	$HUD.update_score(score)
	new_game.connect("player_died", self, "_on_player_died")
	new_game.connect("score_count", self, "_on_score_update")
	new_game.connect("power_up", self, "_on_power")
	$HUD.show()
	if power == true:
		$spawn.timer_on()
	$HUD.massage_hide()

func _on_player_died():
	loadAds()
	admob.show_banner()
	admob.show_interstitial()
	power = false
	is_level_up = false
	if not $died.playing:
		$died.play()
	if score > highscore:
		highscore = score
		save_score()
	$spawn.timer_off()
	$spawn.level_normal()
	massage_text = "died"
	$HUD.hide()
	$HUD.massage_show()
	
	yield(get_tree().create_timer(3.55), "timeout")
	get_tree().call_group("enemy", "implode")
	$Screen.game_over(score, highscore)
	$HUD.massage_hide()

func _on_score_update():
	if not $point.playing:
		$point.play()
	score += 1
	$HUD.update_score(score)

func load_score():
	var f = File.new()
	if f.file_exists(Global.score_file):
		var err = f.open_encrypted_with_pass(Global.score_file, File.READ, "semme")
		highscore = f.get_var()
		f.close()

func save_score():
	var f = File.new()
	var err = f.open_encrypted_with_pass(Global.score_file, File.WRITE, "semme")
	f.store_var(highscore)
	f.close()

func level_up():
	if is_level_up == true:
		$spawn.on_level_up()
	max_score += 10
	$spawn.get_node("enemy_spawn").wait_time -= 0.05

func level_reset():
	is_level_up = false
	max_score = 10
	$spawn.get_node("enemy_spawn").wait_time = 0.875

func _on_power():
	power = true
	if not $power.playing:
		$power.play()
	$spawn.on_power()
	yield(get_tree().create_timer(6.0), "timeout")
	if power == true:
		$spawn.timer_on()
	elif power == false:
		$spawn.timer_off()

func massage_pop_up():
	$HUD.massage_show()
	yield(get_tree().create_timer(1.10), "timeout")
	$HUD.massage_hide()

