extends Resource
class_name InventoryItem

@export var collected_item: CollectableItem = null
@export var item_count: int = 0
@export var default_limit: int = 10 # this is a work around so player does not pickup more than the slot limit but as the inventory service does not have any info on slot limit this is there to ensure we don't pickup more

signal item_update

func get_collected_item():
	return collected_item


func get_identifier():
	return collected_item.get_item_name()
	
func get_item_count():
	return item_count


func set_collected_item(item: CollectableItem):
	collected_item = item

func set_item_count(count: int):
	item_count = count


func append_inventory_item(item: InventoryItem):
	# if item.get_item_count() + get_item_count() > SLOT_SIZE:
	# 	item_count = SLOT_SIZE
	# else:
	item_count += item.get_item_count()

func are_items_same(item_to_check):
	if get_identifier() == item_to_check.get_identifier():
		return true
	return false

func get_default_limit():
	return default_limit