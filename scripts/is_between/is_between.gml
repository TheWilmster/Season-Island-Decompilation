function is_between(_val, _min, _max, _minIsEqual = true, _maxIsEqual = true)
{
	var _res = true;
	if (_minIsEqual)
		_res = _res && _val >= _min;
	else
		_res = _res && _val > _min;
	if (_maxIsEqual)
		_res = _res && _val <= _max;
	else
		_res = _res && _val < _max;
	return _res;
}
