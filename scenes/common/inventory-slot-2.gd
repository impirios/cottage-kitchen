extends Node2D
class_name InventorySlot2
@export var inventory_item: InventoryItem = null
@export var index = 0

# var inventory_service: InventoryItems = null
@onready var sprite_marker: Marker2D = $Inventoryslot/SpriteMarker
@onready var count_marker: Marker2D = $Inventoryslot/CountMarker
@onready var pickup_drag_area: PickupArea = $PickupArea

@export var SLOT_SIZE: int = 10

signal item_updated


func _load_item_sprite(item_sprite: Sprite2D):
	if item_sprite:
		item_sprite.scale = Vector2(1, 1)
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
	if pickup_drag_area:
		pickup_drag_area.slot_index = index
	
	if inventory_item && sprite_marker:
		_load_inventory_item()


func _process(_delta):
	pass


func _load_inventory_item():
	var collected_item: CollectableItem = inventory_item.get_collected_item()
	if collected_item:
		var item_sprite: Sprite2D = collected_item.get_item_sprite()
		_load_item_sprite(item_sprite)
		_load_item_count()
		pickup_drag_area.item = inventory_item


func get_pickup_area():
	return pickup_drag_area

func set_inventory_item(item: InventoryItem):
	inventory_item = item

func set_index(i):
	index = i

#####################

func get_extra_count(item_to_check):
	var total_count = inventory_item.get_item_count() + item_to_check.get_item_count()
	if (total_count > SLOT_SIZE):
		return total_count - SLOT_SIZE
	return 0