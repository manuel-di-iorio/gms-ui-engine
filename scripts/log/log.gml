function log() {
	var str = "";
	for (var i=0; i<argument_count; i++) {
        str += string(argument[i]);
		if (i < argument_count - 1) str += " ";
    }
	show_debug_message(str);
}