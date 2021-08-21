##############################################################
# Modular Fucntion to Check and Apply Compiler Flags in Bulk #
##############################################################

# To use this function, define a variable called compile_settings_list. This variable
# is used to iterate over each compiler/flag/native setting to reduce duplication.
# Populate this variable before including this module.
#
# Each element should be a dict, with the following fields:
#	'lang': programming language (string)
#	'flags': a list of flags that you want to test and apply to the project
#	'isnative': true if native, false otherwise
#
## Here is an example list that applies flags to C and C++ for native true/false
#
#compile_settings_list = [
#	{'lang': 'c', 'flags': desired_c_compile_flags, 'isnative': false},
#	{'lang': 'c', 'flags': desired_native_c_compile_flags, 'isnative': true},
#	{'lang': 'cpp', 'flags': desired_cpp_compile_flags, 'isnative': false},
#	{'lang': 'cpp', 'flags': desired_native_cpp_compile_flags, 'isnative': true},
#]


if get_variable('compile_settings_list', []).length() == 0
	warning('Expected variable compile_settings_list not defined. Processor arguments are not being processed!')
else
	# Process each compiler configuration
	foreach entry : compile_settings_list
		entry_compiler = meson.get_compiler(entry.get('lang'), native: entry.get('isnative'))
		add_project_arguments(entry_compiler.get_supported_arguments(
				entry.get('flags') + desired_common_compile_flags),
			language: entry.get('lang'), native: entry.get('isnative'))
	endforeach
endif
