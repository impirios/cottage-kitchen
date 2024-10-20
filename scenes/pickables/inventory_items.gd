extends Resource
class_name InventoryItems

@export var items: Array[InventoryItem] = []

const inventory_dict: Dictionary = {}

signal item_added
signal item_removed


func add_item(item: InventoryItem):
	var index = get_available_index(item)
	if index != null:
		if items[index] && items[index].are_items_same(item):
			items[index].append_inventory_item(item)
		else:
			items[index] = item
		item_added.emit()

func add_item_at_index(item: InventoryItem, index):
	if index != null:
		if items[index] && items[index].are_items_same(item):
			items[index].append_inventory_item(item)
		else:
			items[index] = item
		item_added.emit()

func remove_item_from_index(index):
	if index != null:
		if items[index]:
			items[index] = null
		item_added.emit()

func remove_item(item: InventoryItem):
	items[item.index] = null
	item_removed.emit()

func get_item_inventory():
	return items

func get_item_ids():
	var ids = []
	for item: InventoryItem in items:
		if item and item.get_collected_item():
			ids.append(item.get_identifier())
	return ids

func get_item_by_id(id: String):
	for item: InventoryItem in items:
		if item and item.get_collected_item() and item.get_identifier() == id:
			return item
	return null

func get_item_index_by_id(id: String):
	for index in items.size():
		if items[index] and items[index].get_collected_item() and items[index].get_identifier() == id:
			return index
	return -1

func get_available_index(item: InventoryItem):
	var available_index = null
	# if get_item_ids().has(item.get_identifier()):
	# 	available_index = get_item_index_by_id(item.get_identifier())
	# else:
	for index in items.size():
		if (items[index] and items[index].get_identifier() == item.get_identifier() and (items[index].get_item_count() + item.get_item_count()) <= item.get_default_limit()):
			available_index = index
			return available_index
		if (!items[index]):
			available_index = index
			return available_index
	return available_index


## incomplete AI generated code    

func add_item_at_available_index(item: InventoryItem):
	var available_index = get_available_index(item)
	if available_index < items.size():
		# Replace the item at the available index
		items[available_index] = item
	else:
		# If no available index, append to the end
		items.append(item)
	item_added.emit()


func update_inventory(item, index, curr_item):
	#all the cases will be covered here.
	# if (new_count == 0):
	# 	remove_item(items[index])

	# elif new_count > 0 && items[index]:
	# 	items[index].set_item_count(new_count)
	# 	item_added.emit()
	
	# item_added.emit()

	pass
