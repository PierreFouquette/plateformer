extends KinematicBody2D

onready var anim = $AnimatedSprite
var vitesse = 200
var gravity = 1000
var impulsion = -800
var jumping = false
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	_anim_player()

func _physics_process(delta):
	_ctrl_player()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0,-1))

func _anim_player():
	if Input.is_action_pressed("ui_right"):
		anim.flip_h = false
		anim.play("run")
	elif Input.is_action_pressed("ui_left"):
		anim.flip_h = true
		anim.play("run")
	else:
		anim.flip_h = false
		anim.play("default")

func _ctrl_player():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_select")
	
	velocity.x = 0
	if right:
		velocity.x += vitesse
	if left:
		velocity.x -= vitesse
	if jump and is_on_floor():
		jumping = true
		velocity.y = impulsion
