extends CharacterBody2D
var center_of_attention: Node2D

const SPEED = 100.0

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(_delta):
	if center_of_attention:
		var direction = (center_of_attention.global_position - global_position).normalized()
		
		# Check if we're close enough to the target
		var distance_to_target = global_position.distance_to(center_of_attention.global_position)
		var follow_distance = 50 # Adjust this value to set how close the pet should follow
		if distance_to_target > follow_distance:
			# Move towards the target
			velocity = direction * SPEED
			
			# Play run animation
			animated_sprite.play("run")
			
			# Flipspritebasedonmovementdirection
			if direction.x != 0:
				animated_sprite.flip_h = direction.x < 0
		else:
			# Stop moving when close enough
			velocity = Vector2.ZERO
			animated_sprite.play("idle")
	else:
		animated_sprite.play("idle")


	move_and_slide()


func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("player"):
		center_of_attention = body
