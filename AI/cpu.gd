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
	
func loc():
	var location =  (snek.get_tree().get_nodes_in_group("Foods") as Array[Foods])[0].position/50
	location -= Vector2(0,1)
	#print(location)
	return location
	
func loc1():
	var location = snek.snake_data[0]
	#location -= Vector2(0,1)
	#print(location)
	return location

func get_nearest_obs():
	var nearest:Foods
	var nearest_dist:float = 0
	
	for obs in loc():
		if not nearest:
			nearest = obs
			nearest_dist = snek.global_position.distance_to(obs.global_position)
			continue
		
		if snek.global_position.distance_to(obs.global_position) < nearest_dist:
			nearest = obs
			nearest_dist = snek.global_position.distance_to(obs.global_position)
			
	return nearest

func start():
	#jump()
	pass
	

func loop(delta:float):
	#var apple = loc()
	#var player = loc1()
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
	pass
