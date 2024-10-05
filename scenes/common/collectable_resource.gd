extends Node2D
class_name CollectableResource

@export var resource: CollectableItem = null

signal resource_is_plucked

@onready var sprite_container: CenterContainer = $SpriteContainer
@onready var pickup_area: Area2D = $PickupArea

var resource_plucked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if (resource):
		var item_sprite: Sprite2D = resource.get_item_sprite()
		_load_item_sprite(item_sprite)
	pass # Replace with function body.


func _load_item_sprite(item_sprite: Sprite2D):
	if item_sprite:
		sprite_container.set_anchors_preset(Control.PRESET_FULL_RECT)
		sprite_container.add_child(item_sprite)

func _clear_item_sprite():
		if sprite_container and sprite_container.get_child_count() > 0:
			var sprite = sprite_container.get_child(0)
			sprite_container.remove_child(sprite)
			sprite.queue_free()

func _on_pickup_area_body_entered(body: Node2D):
	if body && body.is_in_group('can_pickup_resource'):
		body.pickup_resource(resource)
		_clear_item_sprite()
		resource_is_plucked.emit()
		queue_free()
