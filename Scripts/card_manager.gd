extends Node2D

var suits = ["H", "D", "C", "S"]
var ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

var cardScene = preload("res://Scenes/card.tscn")
var active_cards = []

# Dictionary to map suits to their corresponding texture paths
var suit_to_texture_path = {
	"C": "res://Sprites/cards/clubs/",
	"D": "res://Sprites/cards/diamonds/",
	"H": "res://Sprites/cards/hearts/",
	"S": "res://Sprites/cards/spades/"
}

# Function to create a full deck of cards
func create_deck():
	var deck = []
	for suit in suits:
		for rank in ranks:
			deck.append(rank + suit)
	return deck

# Function to remove red-faced cards and red Aces
func remove_red_faces_and_aces(deck):
	var filtered_deck = []
	for card in deck:
		var suit = card.substr(card.length() - 1)  # Get the suit (last character)
		var rank = card.substr(0, card.length() - 1)  # Get the rank (all characters except the last)
		
		# Check if the card is a red-faced card or a red Ace
		if (suit == "H" or suit == "D") and (rank == "J" or rank == "Q" or rank == "K" or rank == "A"):
			continue  # Skip this card (don't add it to the filtered deck)
		else:
			filtered_deck.append(card)  # Add the card to the filtered deck
	return filtered_deck

# Function to pick 4 unique random cards
func pick_random_cards(filtered_deck):
	var random_cards = []
	var deck_copy = filtered_deck.duplicate()  # Create a copy of the deck to avoid modifying the original

	for i in range(4):
		if deck_copy.size() == 0:
			break  # Stop if there are no more cards to pick
		var random_index = randi() % deck_copy.size()  # Pick a random index
		random_cards.append(deck_copy[random_index])  # Add the card to the list
		deck_copy.remove_at(random_index)  # Remove the card from the deck to avoid duplicates

	return random_cards

func display_cards(cards):
	var start_x = 370  # Starting X position for the first card
	var start_y = 170  # Y position for all cards
	var spacing = 120  # Horizontal spacing between cards

	for i in range(cards.size()):
		var card_instance = cardScene.instantiate()
		add_child(card_instance)

		# Set the position of the card
		card_instance.position = Vector2(start_x + i * spacing, start_y)

		# Extract the suit from the card
		var card = cards[i]
		var suit = card.substr(card.length() - 1)  # Suit is always the last character

		# Load the corresponding card texture based on the suit
		if suit in suit_to_texture_path:
			var texture_path = suit_to_texture_path[suit] + card + ".png"
			var card_texture = load(texture_path)
			card_instance.get_node("Sprite2D").texture = card_texture
		else:
			print("Invalid suit for card: ", card)

# Function to handle card removal
func _on_card_removed(card_name):
	remove_card(card_name)  # Remove the card from the active cards list
	print("Remaining cards: ", active_cards)

# Function to remove a card from the active cards list
func remove_card(card_name):
	for i in range(active_cards.size()):
		if active_cards[i] == card_name:
			active_cards.remove_at(i)  # Remove the card from the list
			break

func _ready():
	pass


func _on_button_pressed() -> void:
	var deck = create_deck()
	var filtered_deck = remove_red_faces_and_aces(deck)
	var random_cards = pick_random_cards(filtered_deck)
	print("Random cards picked: ", random_cards)
	active_cards = random_cards.duplicate()  # Initialize the list of active cards
	display_cards(random_cards)
