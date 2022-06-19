extends CanvasLayer

func hide():
	$ScoreBox.hide()
func massage_show():
	$massage.show()
func massage_hide():
	$massage.hide()
func show():
	$ScoreBox.show()

func update_score(value):
	$ScoreBox/HBoxContainer/Score.text = str(value)

func massage(value):
	$massage/.text = str(value)





