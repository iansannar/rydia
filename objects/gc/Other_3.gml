/// @description Garbage collection on game exit

report(report_type.terminate, "gc/e14gg14d", "Termination initiatied.");

terminate_graphics();

gc_collect();
terminate_log();