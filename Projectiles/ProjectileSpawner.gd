extends Node2D
@export var Projectile: PackedScene
@export var defender: Area2D
@export var DefenderType: PackedScene
@export var globalCooldown = 0.5
var globalCooldownCurrent
@export var cooldownQ = 2
var cooldownQCurrent
@export var cooldownW = 1
var cooldownWCurrent
@export var cooldownE = 1.5
var cooldownECurrent

# Called when the node enters the scene tree for the first time.
func _ready():
	if defender == null:
		defender = DefenderType.instantiate()
		add_child(defender)
	globalCooldownCurrent = 0
	cooldownQCurrent = 0
	cooldownWCurrent = 0
	cooldownECurrent = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	globalCooldownCurrent = max(globalCooldownCurrent - delta, 0)
	cooldownQCurrent = max (cooldownQCurrent - delta, 0)
	cooldownWCurrent = max (cooldownWCurrent - delta, 0)
	cooldownECurrent = max (cooldownECurrent - delta, 0)
	if globalCooldownCurrent <= 0:
		if Input.is_action_just_pressed("defender_attack_q") and cooldownQCurrent <= 0:
			shoot("barrel")
			cooldownQCurrent = cooldownQ
		elif Input.is_action_just_pressed("defender_attack_w") and cooldownWCurrent <= 0:
			shoot("crate")
			cooldownWCurrent = cooldownW
		elif Input.is_action_just_pressed("defender_attack_e") and cooldownECurrent <= 0:
			shoot("cannonball")
			cooldownECurrent = cooldownE
			
	var remainingCooldown = max(globalCooldownCurrent, cooldownQCurrent)
	if remainingCooldown > 0:
		$BarrelSprite/Label.text = str(remainingCooldown)
	else:
		$BarrelSprite/Label.text = "Q"
	remainingCooldown = max(globalCooldownCurrent, cooldownWCurrent)
	if remainingCooldown > 0:
		$CrateSprite/Label.text = str(remainingCooldown)
	else:
		$CrateSprite/Label.text = "W"
	remainingCooldown = max(globalCooldownCurrent, cooldownECurrent)
	if remainingCooldown > 0:
		$CannonballSprite/Label.text = str(remainingCooldown)
	else:
		$CannonballSprite/Label.text = "E"

func shoot(type):
	globalCooldownCurrent = globalCooldown
	var projectile = Projectile.instantiate()
	projectile.position = defender.position
	projectile.type = type
	add_child(projectile)
