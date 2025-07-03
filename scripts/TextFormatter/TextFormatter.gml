function TextFormatter(_font_name, _color, _halign, _valign) constructor
{
	self.font_name = _font_name;
	self.font_color = _color;
	self.halign = _halign;
	self.valign = _valign;
	
	function get_formatted_text(_string)
	{
		return scribble(_string).starting_format(font_name, font_color).align(halign, valign);
	}
	
	function text_width(_string)
	{
		return get_formatted_text(_string).get_width();
	}
	
	function text_width_ext(_string, _wrapWidth)
	{
		return get_formatted_text(_string).wrap(_wrapWidth).get_width();
	}
	
	function text_height(_string)
	{
		return get_formatted_text(_string).get_height();
	}
	
	function text_height_ext(_string, _wrapWidth)
	{
		return get_formatted_text(_string).wrap(_wrapWidth).get_height();
	}
}
