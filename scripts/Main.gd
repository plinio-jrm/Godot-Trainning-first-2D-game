extends Node

@export var mob_scene: PackedScene
var score: int

func _ready():
	new_game()

func Game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game() -> void:
	score = 0
	$Player.Start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate() as RigidBody2D
	var mob_spawn_location = $MobPath/MobSpawnerLocation as PathFollow2D
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	
	mob.position = mob_spawn_location.position
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
