// Contains video settings.

#region global
#macro TIME_DELTA global._TIME_DELTA // Controls physics based off of the target framerate.
#macro SECOND game_get_speed(gamespeed_fps)
#macro MILLISECOND game_get_speed(gamespeed_fps) / 1000
#macro VIDEO global._VIDEO // A struct that contains video settings.
#macro CAMERA global._CAMERA // A struct that contains camera settings.

// Global variables hidden behind macros
global._TIME_DELTA = game_get_speed(gamespeed_microseconds) / 1000000; // Can be changed
global._VIDEO = {
	aspect_ratio : display_get_width() / display_get_height(), // The aspect ratio of the display.
	ideal_width : 540, // Safe values: 540, 360, 270, 216, 180, 135, 90
	ideal_height : noone, // Ideal width and height are only calculated once and should be a multiple of display resolution
	max_scale : noone, // Makes sure the window never becomes larger than the display
};
global._CAMERA = {
	view : noone, // The global camera
	x : 0,
	y : 0,
	zoom : {
		zoom_min : 0.03, // At this level it's hard to identify objects and the fps drops considerably for some reason
		zoom_max : 8, // Arbitrary
		zoom_speed : SECOND / 8, // How fast the camera approaches the zoom level in ms
		target : 1, // Zoom level to approach
		current : 1,		
	},
	shake : { // Four shake channels
		a : new shake_channel(0, 0, 0),
		b : new shake_channel(0, 0, 0),
		c : new shake_channel(0, 0, 0),
		d : new shake_channel(0, 0, 0),
	},
	following : {
		target : game, // If set to an instance, the camera follows it
		follow_speed : SECOND / 8, // How fast the camera approaches the target in ms
		offset : {
			h : 0,
			v : 0,
		},
	},
	
}

#endregion

#region structures
function shake_channel(_intensity, _duration, _frequency) constructor {
	intensity = _intensity; // The
	duration = _duration; // The initial duration, used to calculate intensity over time
	frequency = _frequency;
	
	life = _duration; // The remaining duration
	current = 0;
	target = 0;
	
	seed = {
		a : random(current_time),
		b : random(current_time << 1),
	}
}

#endregion

#region functions
///@func initialize_graphics()
///@desc Initializes the drawing surfaces and camera.
function initialize_graphics() {
	VIDEO.ideal_height = round(VIDEO.ideal_width / VIDEO.aspect_ratio);

	//Forces ideal_width and ideal_height to an even number via bitwise
	VIDEO.ideal_width += (VIDEO.ideal_width & 1);
	VIDEO.ideal_height += (VIDEO.ideal_height & 1);

	//Double-checks resolution parameters to enable pixel-perfect scaling
	if (display_get_width() mod VIDEO.ideal_width != 0) {
		var i = round(display_get_width() / VIDEO.ideal_width);
		VIDEO.ideal_width = display_get_width() / i;
	}

	if (display_get_height() mod VIDEO.ideal_height != 0) {
		var i = round(display_get_height() / VIDEO.ideal_height);
		VIDEO.ideal_height = display_get_height() / i;
	}

	VIDEO.max_scale = floor(display_get_width() / VIDEO.ideal_width);

	CAMERA.view = camera_create_view(0, 0, VIDEO.ideal_width, VIDEO.ideal_height);
	
	//camera_set_view_size(CAMERA.view, VIDEO.ideal_width, VIDEO.ideal_height);

	//Assign the global camera for every room
	for (var i = room_first; i <= room_last; ++i) {
		if (room_exists(i)) {
			room_set_view_enabled(i, true);
			room_set_viewport(i, 0, true, 0, 0, VIDEO.ideal_width, VIDEO.ideal_height);
			room_set_camera(i, 0, CAMERA.view);
		}
	}
	
	report(report_type.initialize, "graphics/pq6og0tz", "Camera initialized with ideal dimensions of " + string(VIDEO.ideal_width) + "×" + string(VIDEO.ideal_height));
	configure_display(2, 1, false);
}

///@func terminate_graphics()
///@desc Deletes graphics-related data structures and cameras.
function terminate_graphics() {
	delete(VIDEO);
	delete(CAMERA);
	report(report_type.terminate, "gc/bxib55a5", "Graphics freed.");
}

///@func configure_display(window_scale, gui_scale, enable_subpixels)
///@desc Applies video settings to the game display.
///@param {real} window_scale A ratio of how big an in-game pixel is to the physical pixel on the display. Changes window size.
///@param {real} gui_scale A ratio of how big an in-game pixel from the GUI layer is to the physical pixel on the display.
///@param {bool} enable_subpixels Upscales the application layer to maintain a 1:1 ratio between game and display pixels.
function configure_display(window_scale, gui_scale, enable_subpixels) {
	window_scale = clamp(floor(window_scale), 1, VIDEO.max_scale);
	var window_w = VIDEO.ideal_width * window_scale;
	var window_h = VIDEO.ideal_height * window_scale;
	gui_scale = clamp(floor(gui_scale), 1, VIDEO.max_scale);
	
	window_set_size(window_w, window_h);
	display_set_gui_size(VIDEO.ideal_width * gui_scale, VIDEO.ideal_height * gui_scale);
	
	// Resizes the drawing surface to match the window resolution if subpixels are enabled
	if (enable_subpixels) {
		surface_resize(application_surface, window_w, window_h);
	} else {
		surface_resize(application_surface, VIDEO.ideal_width, VIDEO.ideal_height);
	}
	
	display_reset(0, true);
	
	report(report_type.success, "graphics/8odidcgd", "Resolution changed to " + string(window_w) + "×" + string(window_h) + "(true resolution " + string(VIDEO.ideal_width) + "×" + string(VIDEO.ideal_height) + ")");
}

///@func update_camera()
///@desc Timestep for the global camera object.
function update_camera() {
	
	var delta_x = 0;
	var delta_y = 0;
	
	// Instance following
	if (CAMERA.following.target != noone) {
		CAMERA.x += (CAMERA.following.target.x - CAMERA.x) / CAMERA.following.follow_speed;
		CAMERA.y += (CAMERA.following.target.y - CAMERA.y) / CAMERA.following.follow_speed;
	}
	
	// Camera zoom
	CAMERA.zoom.target = clamp(CAMERA.zoom.target, CAMERA.zoom.zoom_min, CAMERA.zoom.zoom_max);
	CAMERA.zoom.current += (CAMERA.zoom.target - CAMERA.zoom.current) / CAMERA.zoom.zoom_speed;
	CAMERA.zoom.current = clamp(CAMERA.zoom.current, CAMERA.zoom.zoom_min, CAMERA.zoom.zoom_max);
	
	// Camera shake
	// Camera shake channel a
	if (CAMERA.shake.a.life > 0) {
		var decay = CAMERA.shake.a.life / CAMERA.shake.a.duration;
		var m = noise(CAMERA.shake.a.seed.a++, 1 / CAMERA.shake.a.frequency) * CAMERA.shake.a.intensity * decay / CAMERA.zoom.current;
		var d = 360 * noise(CAMERA.shake.a.seed.b++, 1 / CAMERA.shake.a.frequency) + 180;
		delta_x += lengthdir_x(m, d);
		delta_y += lengthdir_y(m, d);
		CAMERA.shake.a.life -= TIME_DELTA;
	}
	// Camera shake channel b
	if (CAMERA.shake.b.life > 0) {
		var decay = CAMERA.shake.b.life / CAMERA.shake.b.duration;
		var m = noise(CAMERA.shake.b.seed.a++, 1 / CAMERA.shake.b.frequency) * CAMERA.shake.b.intensity * decay / CAMERA.zoom.current;
		var d = 360 * noise(CAMERA.shake.b.seed.b++, 1 / CAMERA.shake.b.frequency) + 180;
		delta_x += lengthdir_x(m, d);
		delta_y += lengthdir_y(m, d);
		CAMERA.shake.b.life -= TIME_DELTA;
	}
	// Camera shake channel c
	if (CAMERA.shake.c.life > 0) {
		var decay = CAMERA.shake.c.life / CAMERA.shake.c.duration;
		var m = noise(CAMERA.shake.c.seed.a++, 1 / CAMERA.shake.c.frequency) * CAMERA.shake.c.intensity * decay / CAMERA.zoom.current;
		var d = 360 * noise(CAMERA.shake.c.seed.b++, 1 / CAMERA.shake.c.frequency) + 180;
		delta_x += lengthdir_x(m, d);
		delta_y += lengthdir_y(m, d);
		CAMERA.shake.c.life -= TIME_DELTA;
	}
	// Camera shake channel d
	if (CAMERA.shake.d.life > 0) {
		var decay = CAMERA.shake.d.life / CAMERA.shake.d.duration;
		var m = noise(CAMERA.shake.d.seed.a++, 1 / CAMERA.shake.d.frequency) * CAMERA.shake.d.intensity * decay / CAMERA.zoom.current;
		var d = 360 * noise(CAMERA.shake.d.seed.b++, 1 / CAMERA.shake.d.frequency) + 180;
		delta_x += lengthdir_x(m, d);
		delta_y += lengthdir_y(m, d);
		CAMERA.shake.d.life -= TIME_DELTA;
	}
	
	if (instance_exists(debug_camera)) {
		debug_camera.delta_x = delta_x;
		debug_camera.delta_y = delta_y;
	}
	
	camera_set_view_size(view_camera, VIDEO.ideal_width / CAMERA.zoom.current, VIDEO.ideal_height / CAMERA.zoom.current);
	var center_x = camera_get_view_width(view_camera) / 2;
	var center_y = camera_get_view_height(view_camera) / 2;
	camera_set_view_pos(view_camera, CAMERA.x + delta_x + CAMERA.following.offset.h - center_x, CAMERA.y + delta_y + CAMERA.following.offset.v - center_y);
}

#endregion