extends CanvasLayer

signal start_game

func Show_Message(text: String) -> void:
	Set_Message(text)
	$MessageTimer.start()

func Show_Game_Over() -> void:
	Show_Message("Game Over")
	await $MessageTimer.timeout
	
	Set_Message("Dodge the\nCreeps!")
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func Set_Message(text: String) -> void:
	$Message.text = text
	$Message.show()

func Update_Score(score: int) -> void:
	$ScoreLabel.text = str(score)

func _on_message_timer_timeout():
	$Message.hide()

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
