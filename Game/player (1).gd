extends KinematicBody2D

enum States {AIR = 1, FLOOR, LADDER, WALL}
var velocity = Vector2(0,0)
var coins = 0
const SPEED = 150
const GRAVITY = 35
const JUMPFORCE = -450

func _physics_process(delta):
	
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$player.play("Other Character")
		$player.flip_h = true
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$player.play("Other Character")
		$player.flip_h = false
	else:
		$player.play("idle2")
	if not is_on_floor():
		$player.play("idle2")
		
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMPFORCE
		$SoundJump.play()
		
	velocity = move_and_slide(velocity,Vector2.UP)
		
	velocity.x = lerp(velocity.x,0,0.2)


func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://death.tscn")

func add_coin():
	coins = coins + 1

func bounce():
	velocity.y = JUMPFORCE * 0.7

func ouch(var enemyposx):
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = JUMPFORCE * 0.5
	
	if position.x < enemyposx:
		velocity.x = -800
	elif position.x > enemyposx:
		velocity.x = 800
		
	Input.action_release("left")
	Input.action_release("right")
	
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Level1.tscn")


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://Level2.tscn")
