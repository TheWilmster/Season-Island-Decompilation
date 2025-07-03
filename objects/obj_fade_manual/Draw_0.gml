var color = draw_get_color();
var alpha = draw_get_alpha();
draw_set_color(image_blend);
draw_set_alpha(image_alpha);
draw_rectangle(0, 0, 640, 360, false);
draw_set_alpha(alpha);
draw_set_color(color);
