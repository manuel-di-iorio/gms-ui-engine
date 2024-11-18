/**
 * Draw the components
 * In debug mode, also borders, margins and paddings are drawn
 */
function ui_on_draw(debug = false, elem = global.ui) {
	if (elem.mounted && elem.visible) {
		if (elem.background != undefined) {
			// Feather disable once GM1044
			draw_set_color(elem.background);
			draw_rectangle(elem.x1, elem.y1, elem.x2-1, elem.y2-1, false);
		}
		
		if (elem.sprite_index != undefined) {
			var spr_xoffset = sprite_get_xoffset(elem.sprite_index);
			var spr_yoffset = sprite_get_yoffset(elem.sprite_index);
			draw_sprite_stretched(
				elem.sprite_index, 
				elem.image_index, 
				elem.x1,
				elem.y1,
				elem.width,
				elem.height
			);
		}
	
		elem.on_draw();
	}
	
	
	if (debug) {
		draw_set_alpha(.5);
		//draw_set_color(#b08454);
	//	//draw_rectangle(elem.x1 - elem.margin_left, elem.y1 - elem.margin_top, elem.x2-1 + elem.margin_right, elem.y2-1 + elem.margin_bottom, true);
		
		draw_set_color(#e4c382);
	// #b8c480 rectangle=false
		//draw_rectangle(elem.x1, elem.y1, elem.x2-1, elem.y2-1, true);
		
	//	//draw_set_color(#88b2bd);
	//	//draw_rectangle(elem.x1 + elem.padding_left, elem.y1 + elem.padding_top, elem.x2-1 - elem.padding_right, elem.y2-1 - elem.padding_bottom, true);
		draw_set_alpha(1);
	}
	
	for (var i=0, num=array_length(elem.children); i<num; i++) {
		ui_on_draw(debug, elem.children[i]);
	}
}