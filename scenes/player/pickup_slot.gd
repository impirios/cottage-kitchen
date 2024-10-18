extends Node2D
class_name PickupSlot

var inventory_item: InventoryItem = null

# var inventory_service: InventoryItems = null
@onready var sprite_marker: Marker2D = $Inventoryslot/SpriteMarker
@onready var count_marker: Marker2D = $Inventoryslot/CountMarker

const SLOT_SIZE = 64

var loaded = false

func _load_item_sprite(item_sprite: Sprite2D):
	if item_sprite:
		item_sprite.scale = Vector2(0.4, 0.4)
		sprite_marker.add_child(item_sprite)

func _load_item_count():
	var count_label = Label.new()
	count_label.text = str(inventory_item.get_item_count())
	count_label.add_theme_color_override("font_color", Color.WHITE)
	count_label.add_theme_font_size_override("font_size", 22)
	count_label.add_theme_constant_override("outline_size", 1)
	count_label.add_theme_color_override("font_outline_color", Color.BLACK)
	count_label.scale = Vector2(1, 1)

	count_marker.add_child(count_label)
	pass

func _ready():
	pass

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	global_position = mouse_pos


func _load_inventory_item():
	var collected_item: CollectableItem = inventory_item.get_collected_item()
	if collected_item:
		var item_sprite: Sprite2D = collected_item.get_item_sprite()
		_load_item_sprite(item_sprite)
		_load_item_count()
		print('loaded pickup slot')

func _clear_inventory_item():
	for child in sprite_marker.get_children():
		child.queue_free()

	for child in count_marker.get_children():
		child.queue_free()


func set_inventory_item(item: InventoryItem):
	inventory_item = item
######

func load_item(item):
	set_inventory_item(item)
	print("Loaded")
	if inventory_item && sprite_marker:
		_load_inventory_item()
	pass

func unload_item(item):
	set_inventory_item(null)
	print("Unload")
	_clear_inventory_item()
	if item:
		load_item(item)
	
	pass

func is_loaded():
	return inventory_item != null

#######
func _on_area_2d_body_entered(body):
	print(body)
