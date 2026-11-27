extends Node2D
class_name HitboxComponent

@export var healthComponent: HealthComponent

func takeDamage(attack: int) -> void:
	if healthComponent:
		healthComponent.takeDamage(attack)
	else: return

func onAreaEntered(area: Area2D) -> void:
	if area.has_node("AttackComponent"):
		area.get_node("HealthComponent").takeDamage
