extends Area2D
class_name PickupArea
var can_pickup_or_drop = false


@export var item: InventoryItem
@onready var pickup_slot_service: PickupSlot = get_node("/root/PickupSlotScene")
@export var slot_index: int = 0

signal item_dropped
signal item_picked_up


func _process(_delta):
	if can_pickup_or_drop && Input.is_action_just_pressed("mouse_left"):
		if pickup_slot_service.is_loaded():
			var dropped_item: InventoryItem = pickup_slot_service.get_pickup_item()
			if (item != null && item.are_items_same(dropped_item)):
				print("CASE 1")
				var extra_count = get_parent().get_extra_count(dropped_item)
				if (extra_count > 0):
					var item_to_return = get_new_item(item.get_collected_item(), extra_count)
					pickup_slot_service.unload_item(item, slot_index)
					pickup_slot_service.load_item(item_to_return, slot_index)
					item_dropped.emit(get_new_item(item.get_collected_item(), (get_parent().SLOT_SIZE - item.get_item_count())), slot_index)
				else:
					pickup_slot_service.unload_item(item, slot_index)
					item_dropped.emit(get_new_item(dropped_item.get_collected_item(), dropped_item.get_item_count()), slot_index)
			elif (item != null):
				print("CASE 2")
				var item_to_return = item
				pickup_slot_service.unload_item(item, slot_index)
				pickup_slot_service.load_item(item_to_return, slot_index)
				item_dropped.emit(get_new_item(dropped_item.get_collected_item(), dropped_item.get_item_count()), slot_index)
				pass
			else:
				print("CASE 3")
				pickup_slot_service.unload_item(null, slot_index)
				item_dropped.emit(get_new_item(dropped_item.get_collected_item(), dropped_item.get_item_count()), slot_index)
		elif !pickup_slot_service.is_loaded() and item != null:
			print("CASE 4")
			pickup_slot_service.load_item(item, slot_index)
			item_picked_up.emit(slot_index)
	pass


func _on_mouse_entered():
	can_pickup_or_drop = true
	pass # Replace with function body.


func _on_mouse_exited():
	can_pickup_or_drop = false
	pass # Replace with function body.


func get_new_item(collectable_item, count):
	var new_item = InventoryItem.new()
	new_item.set_collected_item(collectable_item) # Set to null or a default CollectableItem if needed
	new_item.set_item_count(count)
	return new_item