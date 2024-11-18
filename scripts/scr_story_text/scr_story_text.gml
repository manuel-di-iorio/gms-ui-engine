function scr_story_text() {
	var label = ui_text({ parent: o_ctrl.content_panel });
	
	with (label) {
		text = "Welcome to UI Engine." + chr(13) + chr(10) + "Click on an element on the list to show it";
		halign = fa_center;
		valign = fa_middle;
	}
}