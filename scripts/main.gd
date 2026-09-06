extends Node2D

const WORLD_SIZE := 10000.0
const ROAD_HALF_WIDTH := 420.0


func _draw() -> void:
	# Grass covering the game world.
	draw_rect(
		Rect2(
			-WORLD_SIZE / 2.0,
			-WORLD_SIZE / 2.0,
			WORLD_SIZE,
			WORLD_SIZE
		),
		Color("287a3d")
	)

	# Asphalt road.
	draw_rect(
		Rect2(
			-ROAD_HALF_WIDTH,
			-WORLD_SIZE / 2.0,
			ROAD_HALF_WIDTH * 2.0,
			WORLD_SIZE
		),
		Color("343840")
	)

	# White road edges.
	draw_line(
		Vector2(-ROAD_HALF_WIDTH, -WORLD_SIZE / 2.0),
		Vector2(-ROAD_HALF_WIDTH, WORLD_SIZE / 2.0),
		Color.WHITE,
		8.0
	)

	draw_line(
		Vector2(ROAD_HALF_WIDTH, -WORLD_SIZE / 2.0),
		Vector2(ROAD_HALF_WIDTH, WORLD_SIZE / 2.0),
		Color.WHITE,
		8.0
	)

	# Dashed center line.
	for y in range(-5000, 5000, 140):
		draw_rect(
			Rect2(-4, y, 8, 70),
			Color("d8d8d8")
		)
