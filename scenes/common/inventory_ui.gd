extends Control
var is_showing: bool = false
@export var inventory_items: InventoryItems = null
@onready var grid: GridContainer = $GridContainer
@onready var slot_scene = preload("res://scenes/common/inventory_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = is_showing
	populate_inventory()
	inventory_items.item_added.connect(_update_inventory)
	inventory_items.item_removed.connect(_update_inventory)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("inventory_ui"):
		is_showing = !is_showing
		visible = is_showing
		populate_inventory()
	pass

func populate_inventory():
	for child in grid.get_children():
		child.queue_free()
	for item: InventoryItem in inventory_items.get_item_inventory():
		var slot_instance: InventorySlot = slot_scene.instantiate()
		slot_instance.set_inventory_item(item)
		grid.add_child(slot_instance)


func _update_inventory():
	if is_showing && inventory_items:
		populate_inventory()
