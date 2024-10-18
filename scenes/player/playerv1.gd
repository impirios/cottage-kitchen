extends CharacterBody2D


const SPEED = 300.0

@onready var animated_sprite = $AnimatedSprite2D
@export var inventory: InventoryItems = null

func _physics_process(_delta):
	# Get the input direction for both horizontal and vertical movement
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# Normalize the direction to prevent faster diagonal movement
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * SPEED
		
		# Play run animation
		animated_sprite.play("run")
		
		# Flip sprite based on movement direction
		if direction.x != 0:
			animated_sprite.flip_h = direction.x < 0
	else:
		velocity = Vector2.ZERO
		
		# Play idle animation
		animated_sprite.play("idle")


	move_and_slide()


func pickup_resource(resource: CollectableItem):
	if inventory:
		var new_item = InventoryItem.new()
		new_item.set_collected_item(resource) # Set to null or a default CollectableItem if needed
		new_item.set_item_count(1)
		inventory.add_item(new_item)
		print("New carrot added to inventory", inventory)
