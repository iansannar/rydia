/// @description Insert description here
last_camera = CAMERA.following.target;
last_zoom = CAMERA.zoom.target;
CAMERA.following.target = id;

delta_x = 0;
delta_y = 0;

shake = {
	intensity : 256,
	duration : 128,
	frequency : 4,
	select : 0,
};
