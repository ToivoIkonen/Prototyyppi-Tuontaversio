extends StaticBody2D



func _ready():
	pass # Replace with function body.
#Tällä saadaan pylväät liikkumaan kokoajan 2 pykälää oikealle 
func _physics_process(delta):
	position += Vector2(-2,0)


