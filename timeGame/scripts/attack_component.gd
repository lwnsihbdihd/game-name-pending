extends Node2D
class_name AttackComponent

@export var hitboxComponent: HitboxComponent
@export var attackDamage: int

func attack() -> void:
	if hitboxComponent:
		hitboxComponent.takeDamage(attackDamage)
	get_parent().get_node("Sprite").play("attack")
