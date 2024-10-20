extends Node2D
class_name InventoryManager
@onready var pickup_slot_scene: PickupSlot = get_node("/root/PickupSlotScene")
@export var inventory_slots: Array[InventorySlot2]
@export var inventory_items: InventoryItems = null


func set_slots(slots):
	inventory_slots = slots

func initialise():
	if inventory_slots:
		for slot in inventory_slots:
			if (slot.get_pickup_area()):
				slot.get_pickup_area().item_dropped.connect(load_item_to_inventory)
				slot.get_pickup_area().item_picked_up.connect(clear_item_from_inventory)

func destructure():
	if inventory_slots:
		for slot in inventory_slots:
			if (slot.get_pickup_area() && slot.get_pickup_area().is_connected("item_dropped", load_item_to_inventory) && slot.get_pickup_area().is_connected("item_picked_up", clear_item_from_inventory)):
				slot.get_pickup_area().disconnect("item_dropped", handle_disconnect)
				slot.get_pickup_area().disconnect("item_picked_up", handle_disconnect)


func load_item_to_inventory(item, index):
	print("loading", item, index)
	inventory_items.add_item_at_index(item, index)
	pass

func clear_item_from_inventory(index):
	inventory_items.remove_item_from_index(index)
	pass

func handle_disconnect():
	pass
