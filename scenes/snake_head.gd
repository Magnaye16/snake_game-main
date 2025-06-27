extends Node2D
class_name Snakehead


@export var runner:Runner
var cpu:CPU 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cpu  = CPU.new(self)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
