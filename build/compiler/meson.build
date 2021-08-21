##################################################
# Common Non-language Specific Compiler Settings #
##################################################

# NOTE:
#	For language-specific values, use subdir('build/compiler/<lang>') in your top-level build file

# These variables should be set for all combinations of compilers and native: true/false
desired_common_compile_flags = [
	# Some compilers complain about our use of #pragma mark in source files
	'-Wno-unknown-pragmas'
]

# This list is used to iterate over each compiler/flag/native setting to reduce duplication
# Using the compiler/check-and-apply-flags module
# Populate this variable in your top-level `meson.build` file.
#
# Each element should be a dict, with the following fields:
#	'lang': programming language (string)
#	'compiler': compiler object to supply for has_argument() calls
#	'flags': a list of flags that you want to test and apply to the project
#	'isnative': true if native, false otherwise
compile_settings_list = []

## Here is an example list that applies flags to C and C++ for native true/false
#compile_settings_list = [
#	{'lang': 'c', 'compiler': host_c_compiler, 'flags': desired_c_compile_flags, 'isnative': false},
#	{'lang': 'c', 'compiler': native_c_compiler, 'flags': desired_native_c_compile_flags, 'isnative': true},
#	{'lang': 'cpp', 'compiler': host_cpp_compiler, 'flags': desired_cpp_compile_flags, 'isnative': false},
#	{'lang': 'cpp', 'compiler': native_cpp_compiler, 'flags': desired_native_cpp_compile_flags, 'isnative': true},
#]
