class_name FighterPanel
extends PanelContainer
# Displays the status of a demon in the player's party, updating dynamically during battle

@onready var button: Button = %SelectButton

var fighter: Fighter

func _on_health_changed(health: int) -> void:
	%HealthBar.set_number(health)
	%HealthBar.set_progress(health / float(fighter.max_health))

func _on_stamina_changed(stamina: int) -> void:
	%StaminaBar.set_number(stamina)
	%StaminaBar.set_progress(stamina / float(fighter.max_stamina))

func _on_status_changed(status_effects: Array[int]) -> void:
	%StatusIcon.set_status_effects(status_effects)

func initialize(fighter: Fighter, is_duplicate: bool = false) -> void:
	self.fighter = fighter
	if fighter == null:
		button.visible = false
		%DataContainer.visible = false
		%EmptyLabel.visible = true
		return
	if is_duplicate:
		%ActivePanel.visible = true
	%NameLabel.text = fighter.display_name
	fighter.health_changed.connect(_on_health_changed)
	fighter.stamina_changed.connect(_on_stamina_changed)
	fighter.status_changed.connect(_on_status_changed)
	
	_on_health_changed(fighter.health)
	_on_stamina_changed(fighter.stamina)
	_on_status_changed(fighter.status_effects)
