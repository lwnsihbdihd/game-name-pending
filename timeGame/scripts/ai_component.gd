extends Node2D
class_name AIComponent

#@onready var level: Node2D = $Main/Level

@export var attackComponent: AttackComponent
@export var speed: float

var player: Player
var level: Node

var chaseDirection: Vector2

var isInRangedRange: bool
var isInMeleeRange: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = get_parent().get_parent().get_parent().get_node("Level")
	print(level)
	player = level.get_node("Player")
	print(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	isInRangedRange = not player.position - attackComponent.rangedRange > Vector2(0, 0)
	isInMeleeRange = not player.position - attackComponent.meleeRange > Vector2(0, 0)
	
	if not isInRangedRange and attackComponent.hasRangedAttack:
		chasePlayer(delta)
	elif isInRangedRange and attackComponent.hasRangedAttack:
		attackComponent.rangedAttack()
	if not attackComponent.hasRangedAttack and attackComponent.hasMeleeAttack and not isInMeleeRange:
		chasePlayer(delta)
	if isInMeleeRange and attackComponent.hasMeleeAttack:
		attackComponent.attack()


func chasePlayer(delta: float) -> void:
	chaseDirection = (player.position - position).normalized()
	get_parent().velocity = chaseDirection * speed * delta
