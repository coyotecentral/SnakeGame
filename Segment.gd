extends Polygon2D
class_name Segment

@export
var segment_color: Color = Color.WHITE

@export
var head_color: Color = Color.GREEN

@export
var is_head: bool = false :
	set(v):
		is_head = v
		if(is_head):
			color = head_color
		else:
			color = segment_color

var size: float = 16.0 :
	set(v):
		size = v
		_resize_polygon()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Sets the points in our polygon to reflect the
# `size` property
func _resize_polygon():
	# The first (top-left) point will always be at 0,0
	# Update the top left point
	polygon[1].x = size

	# Bottom left point
	polygon[2].x = size
	polygon[2].y = size

	# Bottom right point
	polygon[3].y = size
