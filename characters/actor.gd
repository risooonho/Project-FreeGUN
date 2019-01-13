extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal gun_changed
signal ammo_changed
signal health_changed

#Base player variables and stats
export (int) var speed = 200
var velocity = Vector2()
var health = 100
#Array to check if player has a gun
var has_guns = [true, false, false]
#Array to store current gun stats (gun number(gun_stats[0]), bullet speed(gun_stats[1]), damage(gun_stats[2]))
var gun_stats = [0, 500, 34]
#array to store gun ammunition ammount
var gun_ammo = [1, 0, 0]

func health_check():
	emit_signal("health_changed")
	if self.health <= 0:
		self.queue_free()

func shoot():
	if gun_ammo[gun_stats[0]] > 0:
		print("fire")
		#Bullet scene is loading into game
		var new_bullet = load("res://bullet/bullet.tscn").instance()
		$"../".add_child(new_bullet)
		#Bullet position and rotation is set to the spawn point and rotation on the player
		new_bullet.position = $"bullet_spawn".global_position
		new_bullet.rotation = self.rotation
		#Velocity of the bullet is set to the speed of the weapon's bullets
		new_bullet.linear_velocity = Vector2(cos(self.rotation)*gun_stats[1], sin(self.rotation)*gun_stats[1])
		#The parent of the bullet is set to the player
		new_bullet.parent = self
		#Check to see if player still has ammo for all guns besides starting weapon
		if gun_stats[0] > 0:
			self.gun_ammo[gun_stats[0]] -= 1
			print(gun_ammo[gun_stats[0]])
			emit_signal("ammo_changed")
			print("one less")
		print(new_bullet.parent)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
