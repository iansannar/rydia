/// @description Camera movement control

x += 1 / CAMERA.zoom.current * (keyboard_check(ord("D")) - keyboard_check(ord("A")));
y += 1 / CAMERA.zoom.current * (keyboard_check(ord("S")) - keyboard_check(ord("W")));


if (mouse_wheel_down())
	CAMERA.zoom.target /= 1.25;
	
if (mouse_wheel_up())
	CAMERA.zoom.target *= 1.25;

if keyboard_check_pressed(ord("1")) {
	shake.intensity *= 2;
}

if keyboard_check_pressed(ord("3")) {
	shake.intensity /= 2;
}

if keyboard_check_pressed(ord("2")) {
	shake.duration *= 2;
}

if keyboard_check_pressed(ord("5")) {
	shake.duration /= 2;
}

if keyboard_check_pressed(ord("4")) {
	shake.frequency *= 2;
}

if keyboard_check_pressed(ord("6")) {
	shake.frequency /= 2;
}

if (mouse_check_button_pressed(mb_middle)) {
	switch (shake.select) {
		case 0:
			CAMERA.shake.a = new shake_channel(shake.intensity, shake.duration, shake.frequency);
			break;
		case 1:
			CAMERA.shake.b = new shake_channel(shake.intensity, shake.duration, shake.frequency);
			break;
		case 2:
			CAMERA.shake.c = new shake_channel(shake.intensity, shake.duration, shake.frequency);
			break;
		case 3:
			CAMERA.shake.d = new shake_channel(shake.intensity, shake.duration, shake.frequency);
			break;
		default:
			break;
	}
	shake.select = ++shake.select mod 4;
}