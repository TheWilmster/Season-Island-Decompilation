function Inventory(size) constructor
{
	items = array_create(size, ItemType.None);
	selected_slot = -1;
	
	item_replace = function(item, new_item)
	{
		var index = item_find_index(item);
		if (index == -1)
		{
			show_debug_message(string("Could not replace item {0} by {1}: item {2} not found.", item, new_item, item));
			exit;
		}
		items[index] = new_item;
	};
	
	item_replace_selected = function(item)
	{
		items[selected_slot] = item;
	};
	
	select_item_at_index = function(index)
	{
		if (index < 0 || index >= array_length(items))
			exit;
		selected_slot = index;
	};
	
	deselect_item = function()
	{
		selected_slot = -1;
	};
	
	get_size = function()
	{
		return array_length(items);
	};
	
	get_selected_item = function()
	{
		if (selected_slot < 0)
			return -1;
		return items[selected_slot];
	};
	
	find_first_empty_slot = function()
	{
		return array_find_index(items, function(element)
		{
			return element == ItemType.None;
		});
	};
	
	item_add = function(item)
	{
		var item_index = find_first_empty_slot();
		if (item_index == ItemType.None)
		{
			show_debug_message(string("Couldn't add item {0}: inventory is full.", item));
			exit;
		}
		items[item_index] = item;
	};
	
	item_find_index = function(item_type)
	{
		return array_find_index(items, method(
		{
			item_id: item_type
		}, function(item_type)
		{
			return item_type == item_id;
		}));
	};
	
	item_rmv = function(item_type)
	{
		var item_index = item_find_index(item_type);
		if (item_index == ItemType.None)
		{
			show_debug_message(string("Couldn't remove item {0} from inventory: item not found.", item_type));
			exit;
		}
		items[item_index] = -1;
		if (item_index == selected_slot)
			selected_slot = -1;
	};
	
	is_empty = function()
	{
		return find_first_empty_slot() == ItemType.None;
	};
	
	item_rmv_selected = function()
	{
		items[selected_slot] = -1;
		selected_slot = -1;
	};
	
	contains_item = function(item_type)
	{
		for (var i = 0; i < get_size(); i++)
		{
			if (items[i] == item_type)
				return true;
		}
		return false;
	};
	
	contains_items = function(array)
	{
		for (var i = 0; i < array_length(array); i++)
		{
			if (!contains_item(array[i]))
				return false;
		}
		return true;
	};
}
