extends Node2D
class_name CPU


var has_up_request:bool = false
var has_down_request:bool = false
var has_left_request:bool = false
var has_right_request:bool = false

@export var snek:Snakehead

func _init(_snake:Snakehead) -> void:
	snek = _snake

func get_speed()->float:
	return snek.runner.speed

func init_state():
	clear_requests()
	
	
func clear_requests():
	has_up_request = false
	has_down_request = false
	has_left_request = false
	has_right_request = false
	



func go_up():
	snek.runner.move_direction = snek.runner.up
	(snek.snake_part[0] as Snakehead).get_node("Sprite2D/AnimatedSprite2D").play("Up")

func go_down():
	snek.runner.move_direction = snek.runner.down
	(snek.snake_part[0] as Snakehead).get_node("Sprite2D/AnimatedSprite2D").play("Down")
	
func go_left():
	snek.runner.move_direction = snek.runner.left
	(snek.snake_part[0] as Snakehead).get_node("Sprite2D/AnimatedSprite2D").play("Left")
	
func go_right():
	snek.runner.move_direction = snek.runner.right
	(snek.snake_part[0] as Snakehead).get_node("Sprite2D/AnimatedSprite2D").play("Right")
	
func get_food_location():
	var location =  (snek.get_tree().get_nodes_in_group("Foods") as Array[Foods])[0].position/50
	location -= Vector2(0,1)
	#print(location)
	return location
	
func obs_loc():#test
	var location =  (snek.get_tree().get_nodes_in_group("Obstacle") as Array[Obstacle])[0].position/50
	location -= Vector2(0,0)
	#print(location)
	return location
	
func get_snake_location():
	var location = snek.snake_data[0]
	#location -= Vector2(0,1)
	#print(location)
	return location

func get_obs_loc() -> Vector2:
	var obstacles = snek.get_tree().get_nodes_in_group("Obstacle")
	if obstacles.size() > 0 and obstacles[0] is Node2D:
		var obstacle_pos = (obstacles[0] as Node2D).position
		var grid_pos = (obstacle_pos / 50) - Vector2(0, 1)
		return grid_pos
	return Vector2.ZERO

func get_nearest_food():
	var foods = snek.get_tree().get_nodes_in_group("Foods")
	var nearest: Node2D
	var nearest_dist: float = INF

	for food in foods:
		if food is Node2D:
			var dist = snek.global_position.distance_to(food.global_position)
			if dist < nearest_dist:
				nearest = food
				nearest_dist = dist
				
	return nearest

func get_safe_directions(snake_pos: Vector2) -> Array:
	var safe := []
	var obstacle_positions = []

	for obs in snek.get_tree().get_nodes_in_group("Obstacle"):
		if obs is Node2D:
			obstacle_positions.append((obs as Node2D).position / 50)

	if not (snake_pos + Vector2(0, -1)) in obstacle_positions:
		safe.append("up")
	if not (snake_pos + Vector2(0, 1)) in obstacle_positions:
		safe.append("down")
	if not (snake_pos + Vector2(-1, 0)) in obstacle_positions:
		safe.append("left")
	if not (snake_pos + Vector2(1, 0)) in obstacle_positions:
		safe.append("right")
	return safe

func start():
	#jump()
	pass

func loop(delta:float):
	#var apple = get_food_location()
	#var player = get_snake_location()
	#var xdir = apple.x - player.x
	#var ydir = apple.y - player.y
	#if abs(xdir) > abs(ydir) :
		#if sign(xdir)  == 1:  go_right()
		#else: go_left()
	#else:
		#if sign(ydir)  == 1:  go_down()
		#else: go_up()
		#
	#print(xdir)
	#print(ydir)
	
	#var obs = get_obs_loc()
	#var player = get_snake_location()
	#var xdir = obs.x - player.x
	#var ydir = obs.y - player.y
	#if abs(xdir) > abs(ydir) :
		#if sign(xdir)  == 1:  go_right()
		#else: go_left()
	#else:
		#if sign(ydir)  == 1:  go_down()
		#else: go_up()
		#
	#print(xdir)
	#print(ydir)
	
	#var obs = loc()
	#var player = get_snake_location()
	#var xdir = obs.x - player.x
	#var ydir = obs.y - player.y
	#if abs(xdir) > abs(ydir) :
		#if sign(xdir)  == 1:  go_right()
		#else: go_left()
	#else:
		#if sign(ydir)  == 1:  go_down()
		#else: go_up()
		#
	#print(xdir)
	#print(ydir)
	
	
	pass
