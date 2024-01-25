extends Node

# enemies send exp on death
signal send_exp(amount: float, spawn_bonus: int)

signal update_tally(enemies: int, bosses: int, dens: int)
