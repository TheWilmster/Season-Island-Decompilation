function clamp_loop(_val, _min, _max)
{
	if (_val < _min)
		_val = _max;
	else if (_val > _max)
		_val = _min;
	return _val;
}
