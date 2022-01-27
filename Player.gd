extends KinematicBody2D

#Kertoo kuinka kovaa gravity vetää peli hahmoa alaspäin ja kuinka voimakas yksittäinen hyppy on
const UP = Vector2(0,-1)
const FLAP = 200
const MAXFALLSPEED = 200
const GRAVITY = 10

var motion = Vector2()
var Wall = preload("res://Wallnode.tscn")
var score = 0

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	#Kun painaa space näppäintä hahmo hyppää 
	if Input.is_action_just_pressed("FLAP"):
		motion.y = -FLAP
	
	motion = move_and_slide(motion, UP)
	
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)
	#Tämä koodin pätkä saa pylväät tulemaan random järjestyksessä -60,60 alueen välillä 
func Wall_reset():
	var Wall_instance = Wall.instance()
	Wall_instance.position = Vector2(450,rand_range(-60,60))
	get_parent().call_deferred("add_child",Wall_instance)
	
func _on_Resetter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		Wall_reset()

#Kun menee pylväistä läpi saa yhden pisteen
func _on_Detect_area_entered(area):
	if area.name == "PointArea":
		score = score + 1

#Ainakun osuu pylvääseen peli alkaa alusta
func _on_Detect_body_entered(body):
	if body.name == "Walls":
		get_tree().change_scene("res://Menu.tscn")
func _on_Boss_body_entered(body):
	get_tree().change_scene("res://Menu.tscn")
