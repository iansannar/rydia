// Contains setup.

#region global
#macro DEBUG true // Enables debugging tools if true, disables if false.
#macro LOGFILE global._LOGFILE // The name of the log file.

// Global variables hidden behind macros
global._LOGFILE = noone;

#endregion

date_set_timezone(timezone_utc);
var filename = string(current_year) + "-" + string(current_month) + "-" + string(current_day) + "-" + string(current_minute) + ".log";
LOGFILE = file_text_open_write(filename);
report(report_type.initialize, "foundation/ik1er1db", "Log file " + filename + " created.");
report(report_type.event, "foundation/27gbozsl", "Running on " + identify_platform());

if (DEBUG) {
	random_set_seed(0);
	report(report_type.event, "foundation/ubmfaew7", "Random seed set to 0.");
} else {
	randomize();
	report(report_type.event, "foundation/a59jsgu8", "Random seed generated.");
}

initialize_graphics();
room_goto(room_first);