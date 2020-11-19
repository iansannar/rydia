/// @description Draw debug HUD elements
draw_set_font(font_vcr);
draw_set_color(c_white);
draw_set_alpha(1);
draw_text(4, 0, "fps: " + string(fps_real) + ", zoom: " + string(CAMERA.zoom.current))
draw_text(4, 16, "shake: " + string(shake.intensity) + "i, " + string(shake.duration) + "d, " + string(shake.frequency) + "f");
draw_text(4, 32, "channels: " + string(CAMERA.shake.a.life) + ", " + string(CAMERA.shake.b.life) + ", " + string(CAMERA.shake.c.life) + ", " + string(CAMERA.shake.d.life));

draw_set_color(c_red);
var center_x = surface_get_width(application_surface) / 2;
var center_y = surface_get_height(application_surface) / 2;
draw_line_width(center_x, center_y, center_x + delta_x, center_y + delta_y, 2);
draw_set_color(c_white);