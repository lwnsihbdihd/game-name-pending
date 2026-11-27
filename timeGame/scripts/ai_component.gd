extends Node2D
class_name AIComponent

@export var attackComponent: AttackComponent
@export var SPEED: int
@export var player: Player

var chaseDirection: Vector2

var isInRangedRange: bool = not player.position - attackComponent.rangedRange > Vector2(0, 0)
var isInMeleeRange: bool = not player.position - attackComponent.meleeRange > Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not isInRangedRange and attackComponent.hasRangedAttack:
		chasePlayer()
	elif isInRangedRange and attackComponent.hasRangedAttack:
		attackComponent.rangedAttack()
	if not attackComponent.hasRangedAttack and attackComponent.hasMeleeAttack and not isInMeleeRange:
		chasePlayer()
	if isInMeleeRange and attackComponent.hasMeleeAttack:
		attackComponent.attack()


func chasePlayer() -> void:
	chaseDirection = (player.position - position).normalized()
	get_parent().velocity = chaseDirection * SPEED
