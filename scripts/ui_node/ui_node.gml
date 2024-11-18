function UiNode(args = {}) constructor {
	var _style = args[$ "style"] ?? {};
	var _parent = args[$ "parent"];
	
	// Editable properties
	background = undefined;
	scroll_x = 0;
	scroll_y = 0;
	pointer_events = false;
	visible = true;
	sprite_index = undefined;
	image_index = 0;
	background = undefined;
	on_create = function() {};
	on_step = function() {};
	on_draw = function() {};
	on_mouse_enter = function() {};
	on_mouse_leave = function() {};
	on_click = function() {};
	on_mouse_press = function() {};
	on_mouse_hold = function() {};
	on_mouse_release = function() {};
		
	// Internal read-only variables, do not manually edit them
	node = flexpanel_create_node(_style);
	parent = undefined;
	children = [];
	updated = false;
	hovered = false;
	created = false;
	mounted = false;
	x1 = 0;	
	y1 = 0;	
	x2 = 0;	
	y2 = 0;
	width = 0;
	height = 0;
	padding_left = 0;
	padding_top = 0;
	padding_right = 0;
	padding_bottom = 0;
	margin_left = 0;
	margin_top = 0;
	margin_right = 0;
	margin_bottom = 0
	
	// Methods
	
	/**
	 * Remove the element itself
	 */
	remove = function() {
		var index = array_find_index(children, method(self, function(child) {
			return child == self;
		}));
		array_delete(parent.children, index, 1);
		flexpanel_node_remove_child(parent.node, node);
		flexpanel_delete_node(node);
		ui_update();
	}
	
	/**
	 * Add a child to the element's children list
	 */
	add_child = function(child) {
		array_push(children, child);
		flexpanel_node_insert_child(node, child.node, flexpanel_node_get_num_children(node));
		ui_update();
	}
	
	/**
	 * Remove a child from the element's children list
	 */
	remove_child = function(child) {
		var index = array_find_index(children, method(child, function(parentChild) {
			return parentChild == self;
		}));
		array_delete(children, index, 1);		
		flexpanel_node_remove_child(node, child.node);	
		flexpanel_delete_node(child.node);
		ui_update();
	}
	
	/**
	 * Remove all children from the element's children list
	 */
	remove_all_children = function() {
		flexpanel_node_remove_all_children(node);
	
		array_foreach(children, function(child) {
			flexpanel_delete_node(child.node);
		});
		array_resize(children, 0);
		ui_update();
	}
	
	/**
	 * Bring the element on top of everything else
	 */
	focus = function() {
		var parentChildren = parent.children;
		var parentNode = parent.node;
	
		var index = array_find_index(parentChildren, method(self, function(child) {
			return child == self;	
		}));
		array_delete(parentChildren, index, 1);
		array_push(parentChildren, self);
	
		flexpanel_node_remove_child(parentNode, node);
		flexpanel_node_insert_child(parentNode, node, flexpanel_node_get_num_children(parentNode));	
		ui_update();
		if (parent.parent) parent.focus();
	}
	
	/**
	 * Trigger the click event
	 */
	click = function() {
		__ui_pointer_events_run_event(self, __ui_create_pointer_event("on_click"));
	}
	
	/**
	 * Set a new parent for this element
	 */
	set_parent = function(_parent) {
		remove();
		_parent.add_child(self);
	}
	 
	/**
	 * Get the specified property value
	 * If the value is undefined, will recursively get the value from the parents up to the root
	 */
	get = function(name) {
		var value = self[$ name];
	
		if (value == undefined && parent != undefined) {
			return parent.get(name);
		}
	
		return value;
	}
	
	// Automatically add the node to the parent children list
	if (variable_global_exists("ui")) {
		parent = _parent != undefined ? _parent : global.ui;
		parent.add_child(self);
	}
}

function ui_node(args = {}) {
	return new UiNode(args);
}