function face_get_opposite(face)
{
	switch (face)
	{
		case FACE.RIGHT:
			return FACE.LEFT;
		case FACE.UP:
			return FACE.DOWN;
		case FACE.LEFT:
			return FACE.RIGHT;
		case FACE.DOWN:
			return FACE.UP;
	}
}
