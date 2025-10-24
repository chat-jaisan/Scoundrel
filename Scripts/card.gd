extends Area2D

@onready var button = $"../Button"

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		button.visible = !button.visible  # Toggle button visibility
		

func _on_button_pressed() -> void:
	$"..".visible = false  # Hide the card
	emit_signal("card_removed", self.name)  # Emit the signal with the card's name
	
func _ready():
	pass
