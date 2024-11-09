extends Node2D
var is_showing: bool = false
@export var inventory_items: InventoryItems = null
@onready var inventory_items_container: Node2D = $InventoryItemsContainer
@onready var slot_scene = preload("res://scenes/common/inventory-slot-2.tscn")
@onready var inventory_manager: InventoryManager = $InventoryManager

const slot_length = 20
const grid_length = 60
const row_limit = 3
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
	call_deferred("populate_inventory_deffered")

func populate_inventory_deffered():
	var slots: Array[InventorySlot2] = []

	# clear slots
	for child in inventory_items_container.get_children():
		child.queue_free()

	for index in inventory_items.get_item_inventory().size():
		var item: InventoryItem = inventory_items.get_item_inventory()[index]
		var slot_instance: InventorySlot2 = slot_scene.instantiate()
		slot_instance.set_inventory_item(item)
		slot_instance.set_index(index)
		slots.push_back(slot_instance)
	
	
	##### render slots
	var row = 0
	var col = 0
	for index in slots.size():
		if (index%row_limit == 0 && index != 0):
			row += 1
			col = 0
		if index != 0:
			slots[index].position = slots[index].position + Vector2(slot_length * col, row * slot_length)
		inventory_items_container.add_child(slots[index])
		col += 1
	
	inventory_manager.destructure()
	inventory_manager.set_slots(slots)
	inventory_manager.inventory_items = inventory_items
	inventory_manager.initialise()


func _update_inventory():
	if is_showing && inventory_items:
		populate_inventory()
