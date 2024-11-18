function ui_checkbox(args = {}) {
	var _opts = args[$ "opts"] ?? {};
	var _text = _opts[$ "text"];
	
	// Container
	var container = ui_node({ style: { gap: 10, flexDirection: "row", justifyContent: "start", alignItems: "center" }, parent: args.parent });
	
	with (container) {
		pointer_events = true;
	}
	
	// Checkbox
	var elem = ui_node({ style: args.style, parent: container });
	
	with (elem) {
		pointer_events = true;
		checked = false;
		
		set_checked = function(_checked) {
			checked = _checked;
			image_index = checked ? (hovered ? 4 : 3) : (hovered ? 1 : 0);
		}
		
		on_mouse_leave = function() {
			if (image_index != 1 && image_index != 4) return;
			image_index = checked ? 3 : 0;
		}
		
		on_mouse_enter = function() {
			if (image_index != 0 && image_index != 3) return;
			image_index = checked ? 4 : 1;
		}
		
		on_mouse_press = function() {			
			image_index = checked ? 5 : 2;
		}
			
		on_click = function() {
			// Feather disable once GM1019
			set_checked(!checked);
		}
		
		on_step = function() {
			if (mouse_check_button_released(mb_any)) {
				image_index = checked ? (hovered ? 4 : 3) : (hovered ? 1 : 0);
			}
		}
	}
	
	// Label
	if (_text != undefined) {
		var label = ui_text({ parent: container });
		with (label) {
			text = _text;
		}
	}
	
	return elem;
}