function buffer_from_string(str)
{
	var _buffer_size = string_byte_length(str);
	var _buffer = buffer_create(_buffer_size, buffer_fixed, 1);
	buffer_write(_buffer, buffer_text, str);
	return _buffer;
}
