extends Area2D

signal coin_collected

func _on_coin_body_entered(body):
	#body.add_coin()
	emit_signal("coin_collected")
	$SoundCollected.play()
	queue_free()
