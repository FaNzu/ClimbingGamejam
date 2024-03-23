extends Node2D
@export var Projectile: PackedScene
@export var defender: Area2D
@export var DefenderType: PackedScene
@export var globalCooldown = 0.5
var globalCooldownCurrent
@export var cooldownQ = 2
var cooldownQCurrent

# Called when the node enters the scene tree for the first time.
func _ready():
	if defender == null:
		defender = DefenderType.instantiate()
		add_child(defender)
	globalCooldownCurrent = 0
	cooldownQCurrent = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	globalCooldownCurrent = max(globalCooldownCurrent - delta, 0)
	cooldownQCurrent = max (cooldownQCurrent - delta, 0)
	if globalCooldownCurrent <= 0:
		if Input.is_action_just_pressed("defender_attack_q") and cooldownQCurrent <= 0:
			shoot("placeholder")
			globalCooldownCurrent = globalCooldown
			cooldownQCurrent = cooldownQ

func shoot(type):
	var projectile = Projectile.instantiate()
	projectile.position = defender.position
	projectile.type = type
	add_child(projectile)
