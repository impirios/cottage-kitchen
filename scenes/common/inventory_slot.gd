extends Control
class_name InventorySlot
@export var inventory_item: InventoryItem = null

@onready var sprite_container: CenterContainer = $SpriteContainer
@onready var count_container: CenterContainer = $CountContainer

const SLOT_SIZE = 64


func _load_item_sprite(item_sprite: Sprite2D):
	if item_sprite:
		sprite_container.set_anchors_preset(Control.PRESET_FULL_RECT)
		sprite_container.add_child(item_sprite)

func _load_item_count():
	var count_label = Label.new()
	count_label.text = str(inventory_item.get_item_count())
	count_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	count_label.add_theme_color_override("font_color", Color.WHITE)
	count_label.add_theme_font_size_override("font_size", 8)
	count_label.add_theme_constant_override("outline_size", 1)
	count_label.add_theme_color_override("font_outline_color", Color.BLACK)
	count_container.add_child(count_label)

func _ready():
	if inventory_item && sprite_container:
		_load_inventory_item()


func _load_inventory_item():
	var collected_item: CollectableItem = inventory_item.get_collected_item()
	if collected_item:
		var item_sprite: Sprite2D = collected_item.get_item_sprite()
		_load_item_sprite(item_sprite)
		_load_item_count()


func set_inventory_item(item: InventoryItem):
	inventory_item = item
