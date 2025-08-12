extends Node2D
func _get_local_input() -> Dictionary:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	print(input_vector)
	var input := {}
	if input_vector != Vector2.ZERO:
		input["input_vector"] = input_vector
		
	return input

func _network_process(input: Dictionary) -> void: 
	position += input.get("input_vector", Vector2.ZERO) * 8
	
func _save_state() -> Dictionary:
	return {
		position = position,
	}

func _load_state(state: Dictionary) -> void:
	position = state["position"]

func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():  # Only run input collection on the owning client
		var input := _get_local_input()
		_network_process(input)
