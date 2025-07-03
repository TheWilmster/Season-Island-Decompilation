function Blocker() constructor
{
	token_quantity = 0;
	
	function block()
	{
		token_quantity++;
	}
	
	function unblock()
	{
		if (token_quantity > 0)
			token_quantity--;
	}
	
	function is_blocked()
	{
		return token_quantity > 0;
	}
}
