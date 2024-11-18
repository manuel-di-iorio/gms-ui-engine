function ui_text(args = {}) // Feather disable GM1019
{
	var _opts = args[$ "opts"] ?? {};
	var _text = _opts[$ "text"] ?? "";
	
	var elem = ui_node(args);
	
	with (elem) {
		text = _text;
		font = get("font");
		color = get("color");
		text_sep = -1;
		halign = fa_center;
		valign = fa_middle;
		
		resize = function() {
			draw_set_font(font);
			flexpanel_node_style_set_width(node, string_width_ext(text, text_sep, parent.width) + padding_left + padding_right, flexpanel_unit.point);
			flexpanel_node_style_set_height(node, string_height_ext(text, text_sep, parent.width) + padding_top + padding_bottom, flexpanel_unit.point);
			ui_update();
		}
	
		on_create = function() {
			resize();
		}
	
		on_draw = function() {
			if (!parent.width) return;
			draw_set_font(font);
			draw_set_color(color); 
			draw_set_halign(halign);
			draw_set_valign(valign);
			draw_text_ext(round(mean(x1, x2)), round(mean(y1, y2)), text, text_sep, parent.width);
		}
	}
	
	return elem;
}