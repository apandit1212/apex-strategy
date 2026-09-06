extends CharacterBody2D

@export var acceleration := 550.0
@export var braking := 800.0
@export var friction := 350.0
@export var max_forward_speed := 420.0
@export var max_reverse_speed := 120.0
@export var steering_speed := 2.4

var speed := 0.0


func _ready() -> void:
	queue_redraw()


func _physics_process(delta: float) -> void:
	var throttle := Input.get_axis("brake", "accelerate")
	var steering := Input.get_axis("steer_left", "steer_right")

	if throttle > 0.0:
		speed = move_toward(
			speed,
			max_forward_speed,
			acceleration * throttle * delta
		)
	elif throttle < 0.0:
		speed = move_toward(
			speed,
			-max_reverse_speed,
			braking * -throttle * delta
		)
	else:
		speed = move_toward(speed, 0.0, friction * delta)

	if abs(speed) > 5.0:
		var speed_ratio: float = clampf(
			abs(speed) / max_forward_speed,
			0.25,
			1.0
		)

		rotation += (
			steering
			* steering_speed
			* speed_ratio
			* sign(speed)
			* delta
		)

	velocity = Vector2.UP.rotated(rotation) * speed
	move_and_slide()


func _draw() -> void:
	# Tires
	draw_rect(Rect2(-15, -17, 5, 13), Color("20242b"))
	draw_rect(Rect2(10, -17, 5, 13), Color("20242b"))
	draw_rect(Rect2(-15, 8, 5, 13), Color("20242b"))
	draw_rect(Rect2(10, 8, 5, 13), Color("20242b"))

	# Car body
	draw_rect(Rect2(-10, -20, 20, 40), Color("d9272e"))

	# Nose
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(-6, -20),
			Vector2(6, -20),
			Vector2(3, -32),
			Vector2(-3, -32)
		]),
		Color("ef3940")
	)

	# Cockpit
	draw_rect(Rect2(-6, -6, 12, 16), Color("252b35"))

	# Wings
	draw_rect(Rect2(-15, -29, 30, 4), Color("ef3940"))
	draw_rect(Rect2(-16, 18, 32, 5), Color("ef3940"))
