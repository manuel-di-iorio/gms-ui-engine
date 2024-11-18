function scr_story_button() {
	var btn = ui_button({
		style: {
			padding: 10, paddingBottom: 15, margin: 20, width: 150, height: 40, justifyContent: "center", alignItems: "center" 
		}, 
		parent: o_ctrl.content_panel, 
		opts: { 
			text: "Hello world!"
		}
	});
	
	with (btn) {
		sprite_index = spr_btn;
	}
}