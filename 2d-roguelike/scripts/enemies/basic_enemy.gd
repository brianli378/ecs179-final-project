class_name BasicEnemy
extends CharacterBody2D

var health: int
var speed: float
var damage: float

func initialize(spec: EnemySpec):
	self.health = spec.health
	self.damage = spec.damage
	self.speed  = spec.speed

# need physics process

# take damage (similar to exercise 3)


	
