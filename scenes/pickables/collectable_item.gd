extends Resource
class_name CollectableItem

@export var item_name: String = ""
@export var item_texture: Texture2D = null

func get_item_texture():
	return item_texture


func get_item_sprite() -> Sprite2D:
	var item_sprite = Sprite2D.new()
	item_sprite.texture = item_texture
	item_sprite.scale = Vector2(0.3, 0.3)
	item_sprite.centered = true # Ensure the sprite is centered on its position
	return item_sprite

func get_item_name():
	return item_name
