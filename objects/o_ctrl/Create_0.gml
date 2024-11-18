// Create the showcase
var stories_names = [
	"Text",
	"Button",
	"Checkbox"
];
var stories = [
	scr_story_text,
	scr_story_button,
	scr_story_checkbox
];

root_panel = ui_node({ style: { flexDirection: "row", height: "100%", gap: 20, padding: 10 }});
with (root_panel) {
	font = f_default;
	color = c_white;
}

list_panel = ui_node({ style: { width: 192, gap: 5 }, parent: root_panel });
content_panel = ui_node({ style: { flex: 1, justifyContent: "center", alignItems: "center", gap: 10 }, parent: root_panel });

for (var i=0, len=array_length(stories); i<len; i++) {
	var name = stories_names[i];
	var button = ui_button({ style: { justifyContent: "center", alignItems: "center", padding: 10, paddingBottom: 15 }, parent: list_panel });
	with (button) {
		sprite_index = spr_btn;
		on_click = method({ story: stories[i] }, function() {
			o_ctrl.content_panel.remove_all_children();
			story();
		});
	}
	
	var label = ui_text({ parent: button });
	with (label) {
		text = name;
	}
}

// Select the initial story
scr_story_text();