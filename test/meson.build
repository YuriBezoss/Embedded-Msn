# Test Build Definition

PROJECT_test_files = files(
	'main.c',
	'test_suite.c',
)

files_to_lint += PROJECT_test_files

#######################
# Test Compiler Flags #
#######################

test_suite_compiler_flags = native_c_compiler.get_supported_arguments(
	'-Wno-unused-parameter',
)

###############
# Test Target #
###############

PROJECT_tests = executable('PROJECT_tests',
	PROJECT_test_files,
	dependencies: [
		cmocka_native_dep,
	],
	link_args: native_map_file.format(meson.current_build_dir() + '/PROJECT_tests'),
	c_args: test_suite_compiler_flags,
	native: true
)

#############################
# Register Tests with Meson #
#############################

# CMocka Test Suite #

test_output_dir = 'CMOCKA_XML_FILE=' + meson.build_root() + '/test/%g.xml'

test('PROJECT_tests',
	PROJECT_tests,
	env: [test_output_dir])

run_target('PROJECT-tests',
	command: [PROJECT_tests]
)

run_target('PROJECT-tests-xml',
	command: [
		meson.source_root() + '/tools/exec_program_with_env.sh',
		PROJECT_tests,
		test_output_dir
	],
)
