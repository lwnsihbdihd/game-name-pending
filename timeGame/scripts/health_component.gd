extends Node2D
class_name HealthComponent

@export var maxHealth: int
var health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = maxHealth

func takeDamage(damageTaken: int) -> void:
	health -= damageTaken
	if health <= 0:
		get_parent().die()
