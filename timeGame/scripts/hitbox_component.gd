extends Node2D
class_name HitboxComponent

@export var healthComponent: HealthComponent

func takeDamage(attack: int) -> void:
	if healthComponent:
		healthComponent.takeDamage(attack)
