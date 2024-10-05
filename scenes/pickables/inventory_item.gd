extends Resource
class_name InventoryItem

@export var collected_item: CollectableItem = null
@export var item_count: int = 0


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
	item_count += item.get_item_count()
