extends CharacterBody2D
@export var attackComponent: AttackComponent
@export var attackArea: CollisionShape2D

@export var healthComponent: HealthComponent
@export var hitboxComponent: HitboxComponent

@export var sprite: AnimatedSprite2D


signal playerDied

const SPEED = 800.0

var isAlive: bool = true

var canMove: bool = true
var direction

@export var dashSpeed: int = 3
@export var dashMaxCD: float = 1
@export var dashMaxDuration: float = 0.2
var dashCD: float
var dashDuration: float
var isDashing: bool = false
var startDashCD: bool = false
var canDash: bool = true

func _ready() -> void:
	dashCD = dashMaxCD
	dashDuration = dashMaxDuration

func _physics_process(delta: float) -> void:
	
	if not isAlive:
		return
	
	if Input.is_action_just_pressed("attack"):
		attackComponent.attack()
		if sprite.animation == "attack" and sprite.frame == 2:
			attackArea.disabled = false
		else:
			attackArea.disabled = true
	
	
	
	if canMove:
		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_vector("left", "right", "up", "down")
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		if velocity.x > 1:
			sprite.flip_h = false
		elif velocity.x < -1:
			sprite.flip_h = true
		
	if Input.is_action_just_pressed("dash") and canDash:
		isDashing = true
	# applies velocity if player dashed
	if isDashing and dashDuration >= 0:
		dashDuration -= delta
		velocity = direction * SPEED * dashSpeed
		print(dashDuration)
	else:
		velocity = direction * SPEED
	# checks if dash is over
	if dashDuration <=0:
		isDashing = false
		dashDuration = dashMaxDuration
		startDashCD = true
	# starts dash cd when dash is over
	if startDashCD:
		dashCD -= delta
		canDash = false
	#checks when dash cd if over
	if dashCD <= 0:
		startDashCD = false
		dashCD = dashMaxCD

		canDash = true
	move_and_slide()

func die() -> void:
	playerDied.emit()
	isAlive = false

func revive() -> void:
	isAlive = true


func onAreaEnteredAttackArea(area) -> void:
	if area is HitboxComponent:
		area.takeDamage(attackComponent.attackDamage)
