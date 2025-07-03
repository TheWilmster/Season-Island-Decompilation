function json_file_get_struct(fname, is_base64 = false)
{
	if (file_exists(fname))
	{
		var _file = file_text_open_read(fname);
		var _contents = file_text_read_string(_file);
		file_text_close(_file);
		if (_contents != "")
		{
			var _struct = json_parse(is_base64 ? base64_decode(_contents) : _contents);
			return _struct;
		}
		else
		{
			show_debug_message("File \"" + fname + "\" is empty. Could not retrieve data.");
		}
	}
	else
	{
		show_debug_message("json_file_get_struct: file \"" + fname + "\" does not exist.");
	}
	return undefined;
}
