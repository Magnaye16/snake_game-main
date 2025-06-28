extends Node2D
class_name Snakehead

@export var snake_head : PackedScene
@export var snake_segment : PackedScene
@export var runner:Runner
var cpu:CPU 

#snake_part variables
var old_data : Array
var snake_data : Array
var snake_part : Array

var start_pos = Vector2(9, 9)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cpu = CPU.new(self)

	#if runner.can_move:
		## Update movement from CPU input
		#if cpu.has_down_request and runner.move_direction != runner.up:
			#runner.move_direction = runner.down
			#runner.can_move = false
#
		#if cpu.has_up_request and runner.move_direction != runner.down:
			#runner.move_direction = runner.up
			#runner.can_move = false
			## (snek.snake_part[0] as Snakehead).rotation_degrees = -90
			## if not runner.game_started:
			##     runner.start_game()
#
		#if cpu.has_left_request and runner.move_direction != runner.right:
			#runner.move_direction = runner.left
			#runner.can_move = false
			## (snek.snake_part[0] as Snakehead).rotation_degrees = 180
#
		#if cpu.has_right_request and runner.move_direction != runner.left:
			#runner.move_direction = runner.right
			#runner.can_move = false
			## (snek.snake_part[0] as Snakehead).rotation_degrees = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.


func generate():
	old_data.clear()
	snake_data.clear()
	snake_part.clear()
	var head = get_tree().get_first_node_in_group("Head") 
	if head: head.queue_free()

	# Add head
	add_segment(start_pos, true)
	#starting with the start_pos, create tail segments vertically down
	#for i in range(1):
		#add_segment(start_pos + Vector2(0, i))
		
func add_segment(pos: Vector2, is_head: bool = false):
	snake_data.append(pos)
	var segment
	if is_head:
		segment = snake_head.instantiate()
	else:
		segment = snake_segment.instantiate()
	segment.position = (pos * runner.cell_size) + Vector2(0, runner.cell_size)
	add_child(segment)
	snake_part.append(segment)
	

func _on_move_timer_timeout():
	cpu.loop(0)
	#allow snake_part movement
	#runner.can_move = true
	#use the snake_part's previous position to move the segments
	old_data = [] + snake_data
	snake_data[0] += runner.move_direction
	for i in range(len(snake_data)):
		#move all the segments along by one
		if i > 0:
			snake_data[i] = old_data[i - 1]
		snake_part[i].position = (snake_data[i] * runner.cell_size) + Vector2(0, runner.cell_size)
	runner.check_out_of_bounds()
	runner.check_self_eaten()
	runner.check_food_eaten()	
