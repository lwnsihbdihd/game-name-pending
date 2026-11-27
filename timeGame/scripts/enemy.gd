extends CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var attackComponent: AttackComponent
@export var hitboxComponent: HitboxComponent
@export var healthComponent: HealthComponent

var level: Node

var player: Player
var playerX: float
var playerY: float
var direction: int

var canAttack: bool = true

const SPEED: float = 150


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = get_node("/root/Main/Level")
	player = level.get_node_or_null("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if velocity.x > 1:
		sprite.flip_h = false
	elif velocity.x < -1:
		sprite.flip_h = true


func die() -> void:
	queue_free()
