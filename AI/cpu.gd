extends Node2D
class_name CPU


var has_up_request:bool = false
var has_down_request:bool = false
var has_left_request:bool = false
var has_right_request:bool = false

var has_duck_request:bool = false

@export var snek:Snakehead

func _init(_snake:) -> void:
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
	has_up_request = true
func go_down():
	has_down_request = true
func go_left():
	has_left_request = true
func go_right():
	has_right_request = true

func get_visible_objs():
	return snek.get_tree().get_nodes_in_group("obstacle") as Array[Foods]

func get_nearest_obs():
	var nearest:Foods
	var nearest_dist:float = 0
	
	for obs in get_visible_objs():
		if not nearest:
			nearest = obs
			nearest_dist = snek.global_position.distance_to(obs.global_position)
			continue
		
		if snek.global_position.distance_to(obs.global_position) < nearest_dist:
			nearest = obs
			nearest_dist = snek.global_position.distance_to(obs.global_position)
			
	return nearest

func init():
	#jump()
	pass
	

func loop(delta:float):
	#clear_requests()
	#
	#var nearest:Obstacle = get_nearest_obs()
	#if nearest:print(snake.global_position.distance_to(nearest.global_position))
	#print(nearest)
	#
	#if nearest and snake.global_position.distance_to(nearest.global_position)< 150 :jump()
	pass
