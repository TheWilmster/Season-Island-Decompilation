var target_x = (body.image_xscale < 0) ? (body.x - body_offset_x) : (body.x + body_offset_x);
var target_y = body.y + body_offset_y;
x = lerp(x, target_x, lerp_amount);
y = lerp(y, target_y, lerp_amount);
