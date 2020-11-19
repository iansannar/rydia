/// @description Insert description here


repeat (500) {
	var m = gauss(1);
	var d = random_range(0, 360 - EPSILON);
	var X = lengthdir_x(m, d);
	var Y = lengthdir_y(m, d);
	instance_create_depth(X, Y, 0, Object5);
}