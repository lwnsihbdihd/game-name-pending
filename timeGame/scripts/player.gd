extends CharacterBody2D


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
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if canMove:
		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_vector("left", "right", "up", "down")
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if Input.is_action_just_pressed("dash") and canDash:
		isDashing = true
	
	if isDashing and dashDuration >= 0:
		dashDuration -= delta
		velocity = direction * SPEED * dashSpeed
		print(dashDuration)
	else:
		velocity = direction * SPEED
		
	if dashDuration <=0:
		isDashing = false
		dashDuration = dashMaxDuration
		startDashCD = true
	if startDashCD:
		dashCD -= delta
		canDash = false
	if dashCD <= 0:
		startDashCD = false
		dashCD = dashMaxCD

		canDash = true
	move_and_slide()

func die() -> void:
	pass
	#isAlive = false

func revive() -> void:
	isAlive = true
