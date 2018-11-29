set_global_assignment -entity "test" -library "lib_test" -name IP_TOOL_NAME "clocked_audio_output"
set_global_assignment -entity "test" -library "lib_test" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "test" -library "lib_test" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_test" -name SPD_FILE [file join $::quartus(sip_path) "test.spd"]

set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/test.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/mentor/cao_fifo.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/mentor/cao_merge.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/mentor/cao_avalon.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/mentor/cao_registers.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/mentor/altera_cao_reset_synchronizer.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/mentor/clocked_audio_output.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/aldec/cao_fifo.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/aldec/cao_merge.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/aldec/cao_avalon.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/aldec/cao_registers.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/aldec/altera_cao_reset_synchronizer.v"]
set_global_assignment -library "lib_test" -name MISC_FILE [file join $::quartus(sip_path) "test_sim/clocked_audio_output/aldec/clocked_audio_output.v"]
