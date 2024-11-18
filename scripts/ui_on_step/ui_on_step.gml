function ui_on_step() // Feather disable GM1041
{
	with (global.ui) {
		if (updated) {
			updated = false;
			flexpanel_calculate_layout(global.ui.node, display_get_gui_width(), display_get_gui_height(), flexpanel_direction.LTR);
			__ui_calculate_cache_pos(global.ui);
		}
	}
	
	__ui_check_pointer_events();
	__ui_on_step();
}

function __ui_on_step(elem = global.ui) {
	elem.on_step();
	
	for (var i=0, num=array_length(elem.children); i<num; i++) {
		__ui_on_step(elem.children[i]);
	}
}

function __ui_check_pointer_events(elem = global.ui) {
	// Check if the previously hovered component is still intersecting the mouse
	if (global.ui_hovered_elem != undefined) {
		var hovered_elem = global.ui_hovered_elem;
		if (!point_in_rectangle(mouse_x, mouse_y, hovered_elem.x1, hovered_elem.y1, hovered_elem.x2, hovered_elem.y2)) {
			__ui_pointer_events_unhover_elem(hovered_elem);
		}
	}
	
	// Events algorithm
	var children = elem.children;
	
	for (var i=array_length(children)-1; i>=0; i--) {
		var child = children[i];
		
		// First check the pointer events of the children nodes
		if (array_length(child.children)) {
			if (__ui_check_pointer_events(child)) return true;
		}
		
		// Check the pointer events of this child
		if (child.pointer_events && point_in_rectangle(mouse_x, mouse_y, child.x1, child.y1, child.x2, child.y2)) {
			if (!child.hovered) {
				if (global.ui_hovered_elem) {
					__ui_pointer_events_unhover_elem(global.ui_hovered_elem);
				}
				
				child.hovered = true;
				global.ui_hovered_elem = child;
				__ui_pointer_events_run_event(child, __ui_create_pointer_event("on_mouse_enter"));
			}
				
			if (mouse_check_button_pressed(mb_any)) __ui_pointer_events_run_event(child, __ui_create_pointer_event("on_mouse_press"));
			if (mouse_check_button(mb_any)) __ui_pointer_events_run_event(child, __ui_create_pointer_event("on_mouse_hold"));	
			if (mouse_check_button_released(mb_any)) __ui_pointer_events_run_event(child, __ui_create_pointer_event("on_mouse_release"));
			if (mouse_check_button_released(mb_left)) __ui_pointer_events_run_event(child, __ui_create_pointer_event("on_click"));			
			return true;
		}
	}
	
	return false;
}

function __ui_create_pointer_event(eventName) {
	return { 
		name: eventName,
		propagate: true,
		stopProgapation: function() {
			self.propagate = false;	
		}
	}
}

function __ui_pointer_events_unhover_elem(elem) {
	elem.hovered = false;
	__ui_pointer_events_run_event(elem, __ui_create_pointer_event("on_mouse_leave"));
	global.ui_hovered_elem = undefined;
}

/**
 * Run a pointer event and propagate down the event to the children (capturing phase)
 */
function __ui_pointer_events_run_event(elem, event) {
	// Execute the event and stop the propagation if the event returns true
	elem[$ event.name](event);
	
	if (!event.propagate) return;
	var children = elem.children;
	for (var i=0, len=array_length(children); i<len; i++) {
		__ui_pointer_events_run_event(children[i], event);
	}
}

/**
 * Cache the layout position in the components theirself
 * @recursive
 */
function __ui_calculate_cache_pos(elem) {
	var pos = flexpanel_node_layout_get_position(elem.node, false);
	elem.width = pos.width;
	elem.height = pos.height;
	elem.x1 = pos.left - elem.scroll_x;
	elem.y1 = pos.top - elem.scroll_y;
	elem.x2 = elem.x1 + pos.width;
	elem.y2 = elem.y1 + pos.height;
	elem.width = pos.width;
	elem.height = pos.height;
	elem.padding_left = pos.paddingLeft;
	elem.padding_top = pos.paddingTop;
	elem.padding_right = pos.paddingRight;
	elem.padding_bottom = pos.paddingBottom;
	elem.margin_left = pos.marginLeft;
	elem.margin_top = pos.marginTop;
	elem.margin_right = pos.marginRight;
	elem.margin_bottom = pos.marginBottom;
	
	if (!elem.created) {
		elem.created = true;
		elem.on_create();
		
		call_later(1, time_source_units_frames, method(elem, function() {
			self.mounted = true;
		}));
	}
	
	for (var i=0, num=array_length(elem.children); i<num; i++) {
		__ui_calculate_cache_pos(elem.children[i]);
	}
}

global.ui_hovered_elem = undefined;
global.ui = ui_node();