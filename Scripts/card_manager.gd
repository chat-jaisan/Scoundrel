extends Node2D

var cardScene = preload("res://Scenes/card.tscn")
var active_cards = []

@onready var card_slots = [
	$card_slot_1,
	$card_slot_2,
	$card_slot_3,
	$card_slot_4
]

func _ready():
	pass

# --- SPAWN & DISPLAY CARDS ---
func spawn_cards():
	for i in range(card_slots.size()):
		var card_instance = cardScene.instantiate()
		card_slots[i].add_child(card_instance)
		card_instance.position = Vector2.ZERO

		active_cards.append(card_instance)

	# Print all card values to simulate dealer knowledge
	for card in active_cards:
		print("Dealer sees card: %s (value: %d)" % [card.chosen_card, card.card_value])

func press_random() -> void:
	spawn_cards()
