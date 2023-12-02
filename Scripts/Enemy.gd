extends Area2D

signal hit

func _process(delta):
	position.x -= 180 * delta
	
	if position.x < -20:
		queue_free()


func _on_area_entered(area):
	if area.get_parent().name == "Bullets":
		hit.emit()
		queue_free()
