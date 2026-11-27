extends Node2D
class_name AttackComponent

@export var attackDamage: int
@export var hasAttackAnim: bool
@export var hasRangedAttack: bool
@export var hasMeleeAttack: bool
@export var meleeRange: Vector2
@export var rangedRange: Vector2
@export var attackCD: float

@onready var attackCDTimer: Timer = $AttackCD

var canAttack: bool = true

func attack() -> void:
	if hasAttackAnim:
		get_parent().get_node("Sprite").play("attack")
	attackCDTimer.start(attackCD)
	canAttack = false

func rangedAttack() -> void:
	if hasRangedAttack:
		attack()
	else: return

func onAttackCDTimeout() -> void:
	canAttack = true

func onAreaEnteredAttackArea(area: Area2D) -> void:
	if area.has_node("HitboxComponent"):
		area.get_node("HitboxComponent").takeDamage(attackDamage)
