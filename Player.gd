extends Area2D

var velocity = Vector2.ZERO
var speed = 130
var is_dead: bool = false

signal hit

var bullet_scene: PackedScene = load("res://bullet.tscn")

func _process(delta) -> void:
	velocity = Vector2.ZERO
	
	if not is_dead:
		if Input.is_action_pressed("ui_up") and position.y > 30:
			velocity.y -= speed
		if Input.is_action_pressed("ui_down") and position.y < 152:
			velocity.y += speed
		
		# Shooting
		if Input.is_action_just_pressed("space"):
			var bullet = bullet_scene.instantiate()
			bullet.position = position + Vector2(10, 0)
			$"../Bullets".add_child(bullet)
			$Shooting.play()
		
		position += velocity * delta


func _on_area_entered(_area):
	hide()
	hit.emit()
	$Hit.play()
	is_dead = true
