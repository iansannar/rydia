/// @description Main logic loop

if (DEBUG) {
	if (keyboard_check_pressed(vk_insert)) {
		if (instance_exists(debug_camera)) {
			instance_destroy(debug_camera);
			report(report_type.event, "game/pgltfo9i", "Debug camera destroyed.");
		} else {
			create(debug_camera);
			report(report_type.event, "game/sf0auix5", "Debug camera created.");
		}
	}
}

update_camera();

if mouse_check_button_pressed(mb_left) {
	//var l = instance_create_layer(mouse_x, mouse_y, layer_get_id("instances"), noise_test);
	var l = create(Object5);
	l.x = mouse_x;
	l.y = mouse_y;
}