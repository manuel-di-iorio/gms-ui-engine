function ui_button(args = {}) {
	var _opts = args[$ "opts"] ?? {};
	var _text = _opts[$ "text"];
	
	var elem = ui_node(args);
	
	with (elem) {
		pointer_events = true;
		
		on_mouse_leave = function() {
			if (image_index != 1) return;
			image_index = 0;
		}
		
		on_mouse_enter = function() {
			if (image_index) return;
			image_index = 1;
		}
		
		on_mouse_press = function() {
			image_index = 2;
		}
		
		on_step = function() {
			if (mouse_check_button_released(mb_any)) {
				image_index = hovered;
			}
		}
	}
	
	if (_text != undefined) {
		var label = ui_text({ parent: elem });
	
		with (label) {
			text = _text;
		}
	}
	
	return elem;
}