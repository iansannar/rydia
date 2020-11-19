/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_red);
draw_circle(x, y, 2, false);
draw_circle(x, y, amplitude, true);
draw_set_color(c_green);
var m = noise(seed.a++, 1 / frequency) * amplitude;
var d = 360 * noise(seed.b++, 1 / frequency) + 180;
draw_line_width(x, y, x + lengthdir_x(m, d), y + lengthdir_y(m, d), 2);
draw_circle(x, y, 1, false);
draw_set_color(c_white);