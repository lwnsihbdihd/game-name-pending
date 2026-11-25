extends Node2D
@onready var level: Node2D = $Level
@export var enemy_spawn_timer: Timer
@export var enemies: Node2D

var player: Node
var playerCamera: Node
var viewportX: float
var viewportY: float
var spawnLimitX: float
var spawnLimitY: float
var extraSpawnLimitX: int = 0
var extraSpawnLimitY: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = level.get_node_or_null("Player")
	playerCamera = player.get_node("Camera")
	viewportX = get_viewport().get_visible_rect().size.x
	viewportY = get_viewport().get_visible_rect().size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#pass


func spawnEnemy(limitX: float, limitY: float) -> void:
	# instantiates an enemy node inside the "Enemies" parent node
	var enemyPath = load("res://scenes/enemy.tscn")
	var enemy = enemyPath.instantiate()
	enemies.call_deferred("add_child", enemy)
	# sets the position of each enemy to be a random value outside the player camera view
	var whereX: int = randi_range(-1, 1)
	var whereY: int = randi_range(-1, 1)
	if whereX == 0 and whereY == 0:
		enemy.call_deferred("queue_free")
	while whereX == 0 or whereY == 0:
		whereX = randi_range(-1, 1)
		whereY = randi_range(-1, 1)
	enemy.position = Vector2(randf_range(limitX, limitX + extraSpawnLimitX) * whereX, randf_range(limitY, limitY + extraSpawnLimitY) * whereY)


func _on_enemy_spawn_timer_timeout() -> void:
	spawnLimitX = player.position.x + viewportX
	spawnLimitY = player.position.y + viewportY
	spawnEnemy(spawnLimitX, spawnLimitY)
