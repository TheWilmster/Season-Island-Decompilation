if (!is_open)
{
	create_textbox("spike book cover");
	commented_cover = true;
}
else
{
	array_push(commented_left_page_numbers, left_page_number);
	switch (left_page_number)
	{
		case 0:
			create_textbox("spike book page 0");
			break;
		case 2:
			create_textbox("spike book page 2");
			break;
		case 4:
			create_textbox("spike book page 4");
			break;
	}
}
