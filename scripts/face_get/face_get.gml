function face_get(current_face, xdir, ydir)
{
	if (xdir == 0 && ydir == 0)
		return current_face;
	if (xdir == 0)
		return (ydir > 0) ? FACE.DOWN : FACE.UP;
	if (ydir == 0)
		return (xdir > 0) ? FACE.RIGHT : FACE.LEFT;
	if (current_face == FACE.LEFT || current_face == FACE.RIGHT)
		return (ydir > 0) ? FACE.DOWN : FACE.UP;
	if (current_face == FACE.UP || current_face == FACE.DOWN)
		return (xdir > 0) ? FACE.RIGHT : FACE.LEFT;
	return current_face;
}
