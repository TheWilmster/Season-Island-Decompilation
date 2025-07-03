function value_change_linear(a, b, amt)
{
	var diff = b - a;
	if (abs(diff) <= amt)
		return b;
	else if (diff > 0)
		return min(a + amt, b);
	else
		return max(a - amt, b);
}
