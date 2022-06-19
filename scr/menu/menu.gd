extends Node

onready var admob = $AdMob

func _ready() -> void:
	loadAds()
	get_tree().connect("screen_resized", self, "_on_resize")
	admob.show_banner()
	if admob.banner_size:
		admob.banner_resize()
		
func loadAds() -> void:
	admob.load_banner()

func _on_Noob_pressed() -> void:
	admob.hide_banner()


func _on_Normal_pressed() -> void:
	admob.hide_banner()


func _on_Pro_pressed() -> void:
	admob.hide_banner()
