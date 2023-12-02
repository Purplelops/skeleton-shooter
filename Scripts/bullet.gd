extends Area2D

var hp: int = 2

func _process(delta):
	position.x += 520 * delta
	if position.x >= 1000 or hp == 0:
		queue_free()

func _on_area_entered(_area):
		hp -= 1
	
