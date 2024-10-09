extends Node2D

const SPEED = 100
const WIDTH_OBSTACLE = 64
const GAP_OBSTACLE = WIDTH_OBSTACLE * 4
const MIN_Y_OBSTACLE = 0.3
const MAX_Y_OBSTACLE = 0.7

var point = 0

func _ready() -> void:
	for obstacle in get_children():
		rand_obstacle_pos(obstacle)
		obstacle.get_child(0).connect("body_entered", push_death)
		obstacle.get_child(1).connect("body_entered", push_death)
		obstacle.get_child(2).connect("body_entered", add_point)

func _process(delta: float) -> void:
	var offset_obstacle
	for obstacle in get_children():
		obstacle.position.x -= SPEED * delta
		if obstacle.position.x <= -WIDTH_OBSTACLE: offset_obstacle = obstacle
	var obstacles = get_children()
	obstacles.sort_custom(sort_obstacles)
	if offset_obstacle: 
		offset_obstacle.position.x = obstacles[-1].position.x + GAP_OBSTACLE
		rand_obstacle_pos(offset_obstacle)

func sort_obstacles(obstacle_a, obstacle_b) :
	return obstacle_a.position.x < obstacle_b.position.x

func rand_obstacle_pos(obstacle):
	obstacle.position.y = DisplayServer.screen_get_size().y * randf_range(
		MIN_Y_OBSTACLE, MAX_Y_OBSTACLE
	)

func push_death(body):
	%Labeldeath.visible = true
	body.queue_free()

func add_point(_body):
	point += 1
	%Labelpoint.text = str(point)
