// Contains debug tools.

#region global

// Enums
enum report_type {
	initialize = 0,
	terminate = 1,
	event = 2,
	success = 3,
	warning = 4,
	error = 5,
	fatal = 6,
}

#endregion

#region functions
///@func report(type, trace, msg)
///@desc Writes an event to the log file, and the console as well if in debug mode.
///@param {ReportType} type The type of event.
///@param {string} trace The origin of the event in the format of "resource/bookmark". Bookmarks are unique 6-character comments.
///@param {string} msg The message to be logged.
function report(type, trace, msg) {
	// Select the appropriate glyphs for the report type for both the log file and the debug console
	switch (type) { 
		case report_type.initialize:
			var file_symbol = "\u23fa\ufe0f";
			var console_symbol = "\u23fa";
			break;
		case report_type.terminate:
			var file_symbol = "\u23f9\ufe0f";
			var console_symbol= "\u23f9";
			break;
		case report_type.event:
			var file_symbol = "\u1f4ac";
			var console_symbol = "\u1f4ac";
			break;
		case report_type.success:
			var file_symbol = "\u2705\ufe0f";
			var console_symbol = "\u2611";
			break;
		case report_type.warning:
			var file_symbol = "\u26a0\ufe0f";
			var console_symbol = "\u26a0";
			break;
		case report_type.error:
			var file_symbol = "\u274c";
			var console_symbol = "\u274e";
			break;
		case report_type.fatal:
			var file_symbol = "\u2620\ufe0f";
			var console_symbol = "\u2620";
			break;
		default:
			var file_symbol = "�";
			var console_symbol = "�";
			break;
	}
	
	file_text_write_string(LOGFILE, file_symbol + " " + datetime8601() + " [ " + trace + " ]: " + msg);
	file_text_writeln(LOGFILE);
	
	if (DEBUG) {
		show_debug_message(console_symbol + " @ " + datetime8601() + " [ " + trace + " ]: " + msg);
	}
	
}

///@func datetime8601()
///@desc Provides the current date and time in ISO 8601 format.
///@returns {string} The current date and time in ISO 8601 format.
function datetime8601() {
	// Pad numbers with a zero if less than 10
	var month = (current_month < 10)? "0" + string(current_month) : string(current_month);
	var day = (current_day < 10)? "0" + string(current_day) : string(current_day);
	var hour = (current_hour < 10)? "0" + string(current_hour) : string(current_hour);
	var minute = (current_minute < 10)? "0" + string(current_minute) : string(current_minute);
	var second = (current_second < 10)? "0" + string(current_second) : string(current_second);
	return string(current_year) + "-" + month + "-" + day + "T" + hour + ":" + minute + ":" + second + "Z";
}

///@func identify_platform()
///@desc Provides the current platform the game is running on.
///@returns {string} A string describing the platform.
function identify_platform() {
	switch (os_type) {
		case os_windows: return "Windows";
			break;
		case os_uwp: return "Microsoft UWP";
			break;
		case os_linux: return "Linux";
			break;
		case os_macosx: return "macOS X";
			break;
		case os_ios: return "iOS";
			break;
		case os_android: return "Android";
			break;
		case os_ps4: return "Playstation 4";
			break;
		case os_xboxone: return "Xbox One";
			break;
		case os_switch: return "Nintendo Switch";
			break;
		case os_unknown: return "Unknown OS";
			break;
		default: return "Invalid OS";
			break;
	}
}

///@func terminate_log()
///@desc Closes the log file.
function terminate_log() {
	report(report_type.terminate, "debug/wf3ubigm", "Log file closed.");
	file_text_close(LOGFILE);
}

function print() {
	var msg = "";
	for (i = 0; i < argument_count; ++i) {
		msg += string(argument[i]) + ", ";
	}
	show_debug_message(msg);
}

#endregion