extends Area2D
class_name ProjectileComponent

@export var attackDamage: float
@export var initialSpeed: float
@export var acceleration: float
@export var shootFrom: Vector2
@export var projectileGravity: float
@export var CD: float

var direction: Vector2

var projectile: Node
var projectilePath
var canShoot: bool
var isShot:bool

var shootWhere: Vector2
var xDisplacement: float
var yDisplacement: float
var time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectilePath = load(self.get_path())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isShot:
		move(shootWhere, delta)

func shoot(where: Vector2) -> void:
	projectile = projectilePath.instantiate()
	get_parent().call_deferred("add_child", projectile)
	projectile.position = shootFrom
	isShot = true
	shootWhere = where

func move(finalPos: Vector2, delta: float) -> void:
	direction = (finalPos - shootFrom).normalized()
	xDisplacement = finalPos.x - shootFrom.x
	yDisplacement = finalPos.y - shootFrom.y
	time += delta
	position.x = time * initialSpeed + shootFrom.x
	position.y = (initialSpeed * time) + (0.5 * projectileGravity * time * time) + shootFrom.y
	if time >= -initialSpeed / acceleration:
		projectile.queue_free()
		isShot = false

func onCDTimeout() -> void:
	canShoot = true
