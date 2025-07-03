function time_format_string(time)
{
	var _seconds = time / 1000000;
	var _minutes = _seconds / 60;
	var _hours = _minutes / 60;
	var _seconds_mod = floor(_seconds) % 60;
	var _minutes_mod = floor(_minutes) % 60;
	var _hours_mod = floor(_hours) % 24;
	var _time_string = "";
	if (_hours_mod < 10)
		_time_string += "0";
	_time_string += string(_hours_mod);
	_time_string += ":";
	if (_minutes_mod < 10)
		_time_string += "0";
	_time_string += string(_minutes_mod);
	_time_string += ":";
	if (_seconds_mod < 10)
		_time_string += "0";
	_time_string += string(_seconds_mod);
	return _time_string;
}
