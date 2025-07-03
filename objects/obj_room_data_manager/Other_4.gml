assign_instance_indexes(obj__clickable_object_interactive);
assign_instance_indexes(obj__persistent_room_object);

load_current_room();
obj_sound_manager.on_room_start();
var room_name = room_get_name(room);
var room_function = variable_struct_get(room_functions, room_name);
if (room_function)
	room_function();
obj_save_file_manager.timer_set();
