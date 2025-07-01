extends Node
class_name Runner

const obstacle_scene = preload("res://scenes/obstacle_node.tscn")
const goal_scene = preload("res://scenes/goal_node.tscn")
const food_scene = preload("res://scenes/foods.tscn")
@onready var code_ui: Control = $CodeHUD/Control
@export var snek: Snakehead
var cpu: CPU

# Game variables
var score: int
var game_started: bool = false

# Grid variables
var cells: int = 20
var cell_size: int = 50

# Food variables
var food_pos: Vector2
var regen_food: bool = true

#Obstacle variables
var obs_pos: Vector2
var gen_obs: bool = true
var num_obs: int = 15

#Goal variables
var goal_pos: Vector2
var regen_goal: bool = true

# Movement variables
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var move_direction: Vector2
var can_move: bool



func _ready():
	cpu = snek.cpu
	get_tree().paused = true
	code_ui.run.connect(start_game)
	#new_game()

func new_game():
	get_tree().paused = false
	get_tree().call_group("segments", "queue_free")
	get_tree().call_group("Obstacle", "queue_free")
	$GameOverMenu.hide()
	score = 0
	$Hud.get_node("ScoreLabel").text = "SCORE: " + str(score)
	#move_direction = up
	can_move = true
	snek.generate()
	init_and_move_food()
	init_move_obstacle()
	init_move_Goal()
	snek.cpu.start()

func move_snake():
	if can_move:
		if Input.is_action_just_pressed("move_down") and move_direction != up:
			move_direction = down
			can_move = false
			(snek.snake_part[0] as Snakehead).get_node("Sprite2D/AnimatedSprite2D").play("Down")
			if not game_started:
				start_game()

		if Input.is_action_just_pressed("move_up") and move_direction != down:
			move_direction = up
			can_move = false
			(snek.snake_part[0] as Snakehead).get_node("Sprite2D/AnimatedSprite2D").play("Up")
			if not game_started:
				start_game()

		if Input.is_action_just_pressed("move_left") and move_direction != right:
			move_direction = left
			can_move = false
			(snek.snake_part[0] as Snakehead).get_node("Sprite2D/AnimatedSprite2D").play("Left")
			if not game_started:
				start_game()

		if Input.is_action_just_pressed("move_right") and move_direction != left:
			move_direction = right
			can_move = false
			(snek.snake_part[0] as Snakehead).get_node("Sprite2D/AnimatedSprite2D").play("Right")
			if not game_started:
				start_game()

func start_game():
	game_started = true
	$MoveTimer.start()
	new_game()

func check_out_of_bounds():
	if snek.snake_data[0].x < 0 or snek.snake_data[0].x > cells - 1 \
	or snek.snake_data[0].y < 0 or snek.snake_data[0].y > cells - 1:
		end_game()

func check_self_eaten():
	for i in range(1, len(snek.snake_data)):
		if snek.snake_data[0] == snek.snake_data[i]:
			end_game()
			return

func check_food_eaten():
	if snek.snake_data[0] == food_pos:
		score += 1
		$Hud.get_node("ScoreLabel").text = "SCORE: " + str(score)
		snek.add_segment(snek.old_data[-1])
		init_and_move_food()

func init_and_move_food():
	while regen_food:
		regen_food = false
		food_pos = Vector2(randi_range(0, cells - 1), randi_range(0, cells - 1))
		
		#avoid placing food on top of the snake
		for i in snek.snake_data:
			if food_pos == i:
				regen_food = true
				
	$Food.position = (food_pos * cell_size) + Vector2(0, cell_size)
	regen_food = true

func init_move_obstacle():
	var generated = 0
	
	while generated < num_obs:
		gen_obs = false
		obs_pos = Vector2(randi_range(0, cells - 1), randi_range(0, cells - 1))
		
		# avoid placing obstacle on top of the snake
		for i in snek.snake_data:
			if obs_pos == i:
				gen_obs = true
				break
		
		if not gen_obs:
			var obs_instance = obstacle_scene.instantiate()
			obs_instance.position = (obs_pos * cell_size) + Vector2(0, cell_size)
			add_child(obs_instance)
			obs_instance.add_to_group("Obstacle")  # Optional: helps with group logic
			generated += 1
	gen_obs = true

func check_obs_eaten():
	for obs in get_tree().get_nodes_in_group("Obstacle"):
		if obs is Node2D and snek.snake_data[0] == (obs.position - Vector2(0, cell_size)) / cell_size:
			end_game()
			return

func init_move_Goal():
	while regen_goal:
		regen_goal = false
		goal_pos = Vector2(randi_range(0, cells - 1), randi_range(0, cells - 1))
		
		# avoid placing obstacle on top of the snake
		for i in snek.snake_data:
			if goal_pos == i:
				regen_goal = true
				break
		
		if not regen_goal:
			var goal_instance = goal_scene.instantiate()
			goal_instance.position = (goal_pos * cell_size) + Vector2(0, cell_size)
			add_child(goal_instance)
			goal_instance.add_to_group("Goal")  # Optional: helps with group logic
	regen_goal = true

func check_goal_points():
	if snek.snake_data[0] == goal_pos:
		score += 1
		$Hud.get_node("ScoreLabel").text = "SCORE: " + str(score)
		snek.add_segment(snek.old_data[-1])
		#init_and_move_food()

func end_game():
	$GameOverMenu.show()
	$MoveTimer.stop()
	game_started = false
	get_tree().paused = true

func _on_game_over_menu_restart():
	code_ui.show()
	#new_game()
