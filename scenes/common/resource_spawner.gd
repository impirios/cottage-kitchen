extends Marker2D

@export var randomise = false
@export_enum("CARROT", "PUMPKIN") var seed_type: String = 'CARROT'
@export var unlimited = false

@onready var carrot_resource = preload("res://scenes/collectables/items/carrot.tres")
@onready var pumpkin_resource = preload("res://scenes/collectables/items/pumpkin.tres")
@onready var collectable_resource_scene = preload("res://scenes/common/collectable_resource.tscn")

const SEED_TYPES = {"CARROT": "CARROT", "PUMPKIN": "PUMPKIN"}

@onready var seed_to_resource_map = {
	SEED_TYPES.CARROT: carrot_resource,
	SEED_TYPES.PUMPKIN: pumpkin_resource
}
var seed_to_spawn_time_map = {
	SEED_TYPES.CARROT: 3,
	SEED_TYPES.PUMPKIN: 6
}
var debounce_timer: Debouncetimer
var is_resource_generated = false


# Called when the node enters the scene tree for the first time.
func _ready():
	debounce_timer = Debouncetimer.new()
	var debounce_time = seed_to_spawn_time_map[seed_type]
	debounce_timer.init_debounce_timer(debounce_time, _spawn_resource, self)


func _spawn_resource():
	var collectable_item: CollectableItem = seed_to_resource_map[seed_type]
	if collectable_item:
		var collectable_resource_widget: CollectableResource = collectable_resource_scene.instantiate()
		collectable_resource_widget.resource = collectable_item
		if unlimited:
			collectable_resource_widget.resource_is_plucked.connect(on_resource_plucked)
		add_child(collectable_resource_widget)
		is_resource_generated = true

#signal callable to regenerate resources
func on_resource_plucked():
	is_resource_generated = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !is_resource_generated:
		debounce_timer.start_process()
	else:
		debounce_timer.stop_process()
