extends Area2D
var can_pickup_drop = false

@export var pickup_callback: Callable
@export var drop_callback: Callable
@export var item: InventoryItem
@onready var pickup_slot_service: PickupSlot = get_node("/root/PickupSlotScene")


func _ready():
	if (!pickup_callback || !drop_callback):
		return "One of the required callback is not provided"
	assert(!pickup_callback, "Pickup callback is necessary")
	assert(!drop_callback, "Drop callback is necessary")
	pass # Replace with function body.


func _process(_delta):
	if can_pickup_drop && Input.is_action_just_pressed("mouse_left"):
		if pickup_slot_service.is_loaded():
			pickup_slot_service.unload_item(item)
			drop_callback.call()
		elif item != null:
			pickup_slot_service.load_item(item)
			pickup_callback.call()
	pass


func _on_mouse_entered():
	can_pickup_drop = true
	pass # Replace with function body.


func _on_mouse_exited():
	can_pickup_drop = false
	pass # Replace with function body.
