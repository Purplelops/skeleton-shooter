extends Area2D


func _process(delta):
	position.x += 520 * delta
	if position.x >= 1000:
		queue_free()

func _on_area_entered(_area):
	queue_free()
