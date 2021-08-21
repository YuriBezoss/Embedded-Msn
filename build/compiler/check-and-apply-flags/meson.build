##############################################################
# Modular Fucntion to Check and Apply Compiler Flags in Bulk #
##############################################################

## Note:
#	This function is designed to be used with the compile_settings_list documented in
#	compiler/meson.build. See that file for documentation on the format of the variable.

# Process each compiler configuration
foreach entry : compile_settings_list
	add_project_arguments(entry.get('compiler').get_supported_arguments(
			entry.get('flags') + desired_common_compile_flags),
		language: entry.get('lang'), native: entry.get('isnative'))
endforeach
