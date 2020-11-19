// Contains utility functions.

#region functions
///@func create(type)
///@desc Creates a new instance of an object.
///@param {id} type The object to create an instance of.
///@returns {id} The identifier of the instance created.
function create(type) {
	return instance_create_depth(0, 0, 0, type);
}

function to_string() {
	var msg = "";
	for (i = 0; i < argument_count; ++i) {
		msg += string(argument[i]) + ", ";
	}
	return msg;
}

#endregion