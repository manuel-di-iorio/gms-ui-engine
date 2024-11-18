function scr_story_checkbox() {
	var checkbox_wrapper = ui_node({ style: { width: "22%", justifyContent: "left", gap: 10 }, parent: o_ctrl.content_panel });
	
	var uncheck = ui_checkbox({ style: { width: 32, height: 32 }, parent: checkbox_wrapper, opts: { text: "Unchecked" }});
	var check = ui_checkbox({ style: { width: 32, height: 32 }, parent: checkbox_wrapper, opts: { text: "Checked" }});
	
	// Checkboxes
	with (uncheck) {
		sprite_index = spr_checkbox;
	}
	
	with (check) {
		sprite_index = spr_checkbox;
		// Feather disable once GM1019
		set_checked(true);
	}
}