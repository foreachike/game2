extends Polygon2D

@export var radius_pixels := 14   # sphere radius in "big pixels"
@export var pixel_size := 4       # real pixels per big pixel
@export var light_dir := Vector2(-1, -1)   # direction the light comes FROM
@export var shades: Array[Color] = [
	Color("8d92ab"),   # shadow (base)
	Color("b8bcd0"),
	Color("e4e6f0"),
	Color("ffffff"),   # highlight
]

func _ready() -> void:
	var dir := light_dir.normalized()
	var n := shades.size()
	for i in n:
		var r := roundi(radius_pixels * (1.0 - 0.55 * i / n))
		var offset := Vector2i((dir * (radius_pixels - r) * 0.7).round())
		var layer: Polygon2D = self if i == 0 else Polygon2D.new()
		layer.color = shades[i]
		layer.polygon = _make_pixel_circle(r, pixel_size, offset)
		if i > 0:
			add_child(layer)

func _make_pixel_circle(r: int, px: int, center: Vector2i) -> PackedVector2Array:
	var right := PackedVector2Array()
	var left := PackedVector2Array()
	for y in range(-r, r):
		var w := roundi(sqrt(r * r - (y + 0.5) * (y + 0.5)))
		right.append(Vector2(w + center.x, y + center.y) * px)
		right.append(Vector2(w + center.x, y + 1 + center.y) * px)
		left.append(Vector2(-w + center.x, y + center.y) * px)
		left.append(Vector2(-w + center.x, y + 1 + center.y) * px)
	left.reverse()
	right.append_array(left)
	return right
