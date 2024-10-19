extends Node2D

var segment_scene = preload("res://segment.tscn")

# The timer that's part of our scene
@onready
var timer: Timer = $Timer

# A list of all the snake segments
var segments = []

# This stores the last direction we were moving
# as a `Vector`. A `Vector` has 2 components: x and y.
# The X component tells us how much right or left we're moving
# The Y component tells us how much up or down we're moving
var last_direction: Vector2 = Vector2.RIGHT

# How many pixels is each tile
const TILE_SIZE = 16.0


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the timer
	timer.start()
	# When the timer runs out, run the `tick()` function
	timer.timeout.connect(tick)
	# SnakeGame starts with 2 segments, so spawn them in now
	spawn_segment(Vector2())
	spawn_segment(segments[0].position + (last_direction * TILE_SIZE))

func tick():
	spawn_segment(segments[0].position + (last_direction * TILE_SIZE))
	# Make sure the right snake segment looks like the head
	segments[0].is_head = true
	segments [1].is_head = false

	# Remove the tail segment
	segments.pop_back().queue_free()
	

# Creates a new segment, and adds it to the game world
func spawn_segment(position: Vector2):
	var next_segment =  segment_scene.instantiate()
	next_segment.position = position
	segments.push_front(next_segment)
	add_child(next_segment)

func change_direction(next_direction):
	if last_direction - next_direction != Vector2.ZERO:
		last_direction = next_direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get some input from the user based on actions we set up in
	# Project Settings -> InputMap
	var input = Input.get_vector("left", "right", "up", "down")

	# The dot product approximates the angle between two vectors.
	# If the dot product is 0, then the angle is 90 degrees.
	# If the dot product is 1, then the angle will be 0 (same direction)
	# If the dot product is negative, then it is 180.
	var dot_product = last_direction.dot(input)
	if input.length() and dot_product == 0:
		last_direction = input