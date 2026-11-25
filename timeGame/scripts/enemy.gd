extends Area2D

var level: Node

var player: Node
var playerX: float
var playerY: float

var diffInX: float
var diffInY: float

const SPEED: float = 150


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = get_node("/root/Main/Level")
	player = level.get_node_or_null("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = move_toward(position.x, player.position.x, delta * SPEED)
	position.y = move_toward(position.y, player.position.y, delta * SPEED)
	


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die()
